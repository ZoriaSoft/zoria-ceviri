import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecorderService {
  RecorderService();

  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;

  bool get isRecording => _isRecording;

  Future<void> start() async {
    if (_isRecording) return;
    final hasPerm = await _recorder.hasPermission();
    if (!hasPerm) {
      throw const RecorderException('Microphone permission denied');
    }
    final dir = await getTemporaryDirectory();
    final path = p.join(dir.path, 'z_${DateTime.now().millisecondsSinceEpoch}.m4a');
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 96000,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: path,
    );
    _isRecording = true;
  }

  Future<File> stop() async {
    final path = await _recorder.stop();
    _isRecording = false;
    if (path == null) {
      throw const RecorderException('Recorder returned no file');
    }
    return File(path);
  }

  Future<void> dispose() => _recorder.dispose();
}

class RecorderException implements Exception {
  const RecorderException(this.message);
  final String message;
  @override
  String toString() => 'RecorderException: $message';
}
