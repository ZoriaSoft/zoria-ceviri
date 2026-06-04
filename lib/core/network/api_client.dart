import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Talks to the Cloudflare Worker proxy. The Worker holds the NVIDIA NIM
/// credentials and forwards audio bytes to the NIM Whisper gRPC function.
class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? _defaultDio();

  static Dio _defaultDio() {
    return Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  /// Compile-time injected by `--dart-define=AI_BASE_URL=https://...`.
  /// Falls back to a placeholder so debug builds don't crash.
  static const String _baseUrl = String.fromEnvironment(
    'AI_BASE_URL',
    defaultValue: 'https://zoria-ceviri-worker.example.workers.dev',
  );

  final Dio _dio;

  Future<TranscriptionResult> transcribe({
    required File audioFile,
    required String sourceLang, // 'auto' | 'tr' | 'en'
    required String targetLang, // 'tr' | 'en' (translation target)
  }) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        audioFile.path,
        filename: 'recording.m4a',
      ),
      'source_lang': sourceLang,
      'target_lang': targetLang,
    });

    try {
      final res = await _dio.post('/v1/transcribe', data: form);
      final data = res.data as Map<String, dynamic>;
      return TranscriptionResult(
        sourceText: (data['source_text'] as String?) ?? '',
        translatedText: (data['translated_text'] as String?) ?? '',
        detectedLang: data['detected_lang'] as String? ?? sourceLang,
        durationMs: (data['duration_ms'] as int?) ?? 0,
      );
    } on DioException catch (e) {
      debugPrint('[ApiClient] transcribe failed: ${e.response?.statusCode} ${e.message}');
      rethrow;
    }
  }
}

class TranscriptionResult {
  const TranscriptionResult({
    required this.sourceText,
    required this.translatedText,
    required this.detectedLang,
    required this.durationMs,
  });

  final String sourceText;
  final String translatedText;
  final String detectedLang;
  final int durationMs;

  bool get isEmpty => sourceText.isEmpty && translatedText.isEmpty;
}
