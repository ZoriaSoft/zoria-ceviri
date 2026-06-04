import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/recorder_service.dart';
import '../../../core/providers/providers.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../data/repositories/transcription_repository.dart';

final recorderServiceProvider = Provider<RecorderService>((ref) {
  final svc = RecorderService();
  ref.onDispose(svc.dispose);
  return svc;
});

enum RecorderState { idle, recording, processing, done, error }

class RecorderUi {
  const RecorderUi({
    required this.state,
    required this.elapsedMs,
    required this.level,
    this.errorMessage,
    this.sourceText,
    this.translatedText,
  });

  final RecorderState state;
  final int elapsedMs;
  final double level;
  final String? errorMessage;
  final String? sourceText;
  final String? translatedText;

  RecorderUi copyWith({
    RecorderState? state,
    int? elapsedMs,
    double? level,
    String? errorMessage,
    String? sourceText,
    String? translatedText,
    bool clearError = false,
  }) {
    return RecorderUi(
      state: state ?? this.state,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      level: level ?? this.level,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      sourceText: sourceText ?? this.sourceText,
      translatedText: translatedText ?? this.translatedText,
    );
  }
}

class RecorderController extends StateNotifier<RecorderUi> {
  RecorderController({
    required this._recorder,
    required this._transcription,
    required this._history,
  }) : super(const RecorderUi(state: RecorderState.idle, elapsedMs: 0, level: 0));

  final RecorderService _recorder;
  final TranscriptionRepository _transcription;
  final HistoryRepository _history;
  Timer? _tick;
  DateTime? _startedAt;

  Future<void> start() async {
    try {
      await _recorder.start();
      state = state.copyWith(state: RecorderState.recording, clearError: true);
      _startedAt = DateTime.now();
      _tick?.cancel();
      _tick = Timer.periodic(const Duration(milliseconds: 120), (_) {
        if (_startedAt == null) return;
        final ms = DateTime.now().difference(_startedAt!).inMilliseconds;
        state = state.copyWith(
          elapsedMs: ms,
          level: _levelFor(ms),
        );
      });
    } catch (e) {
      state = state.copyWith(
        state: RecorderState.error,
        errorMessage: e.toString(),
      );
    }
  }



  Future<void> stopAndProcess({
    required String sourceLang,
    required String targetLang,
  }) async {
    if (state.state != RecorderState.recording) return;
    _tick?.cancel();
    state = state.copyWith(state: RecorderState.processing, level: 0);
    try {
      final File file = await _recorder.stop();
      final result = await _transcription.transcribe(
        audio: file,
        sourceLang: sourceLang,
        targetLang: targetLang,
      );
      await _history.add(
        sourceText: result.sourceText,
        translatedText: result.translatedText,
        sourceLang: sourceLang,
        targetLang: targetLang,
        durationMs: state.elapsedMs,
      );
      state = state.copyWith(
        state: RecorderState.done,
        sourceText: result.sourceText,
        translatedText: result.translatedText,
      );
    } catch (e) {
      state = state.copyWith(
        state: RecorderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> cancel() async {
    _tick?.cancel();
    if (state.state == RecorderState.recording) {
      try {
        await _recorder.stop();
      } catch (_) {}
    }
    state = const RecorderUi(state: RecorderState.idle, elapsedMs: 0, level: 0);
  }

  void clear() {
    state = const RecorderUi(state: RecorderState.idle, elapsedMs: 0, level: 0);
  }

  double _levelFor(int ms) {
    // soft visual breathing curve, deterministic so animation reads organic
    final t = (ms / 1000) % 6;
    return 0.35 + 0.45 * (0.5 + 0.5 * (t.isNaN ? 0 : (t < 3 ? t / 3 : (6 - t) / 3)));
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }
}

final recorderControllerProvider =
    StateNotifierProvider<RecorderController, RecorderUi>((ref) {
  return RecorderController(
    recorder: ref.watch(recorderServiceProvider),
    transcription: ref.watch(transcriptionRepositoryProvider),
    history: ref.watch(historyRepositoryProvider),
  );
});
