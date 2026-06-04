import 'dart:io';

import '../../core/network/api_client.dart';

class TranscriptionRepository {
  TranscriptionRepository(this._api);

  final ApiClient _api;

  Future<TranscriptionResult> transcribe({
    required File audio,
    required String sourceLang,
    required String targetLang,
  }) {
    return _api.transcribe(
      audioFile: audio,
      sourceLang: sourceLang,
      targetLang: targetLang,
    );
  }
}
