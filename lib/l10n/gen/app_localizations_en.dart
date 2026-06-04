// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Zoria Çeviri';

  @override
  String get tagline => 'Speak. We listen, transcribe, translate.';

  @override
  String get homeGreeting => 'Ready when you are';

  @override
  String get homeSubline =>
      'Hold the button, speak naturally, let the words settle.';

  @override
  String get homeHelp => 'Help';

  @override
  String get startRecording => 'Start';

  @override
  String get stopRecording => 'Stop';

  @override
  String get recordHint => 'Hold to record';

  @override
  String get pickFromDevice => 'Pick an audio file';

  @override
  String get openHistory => 'History';

  @override
  String get resultTitle => 'Result';

  @override
  String get resultKicker => 'Zoria · Result';

  @override
  String get resultSource => 'Transcript';

  @override
  String get resultTarget => 'Translation';

  @override
  String get transcriptLabel => 'Transcript';

  @override
  String get translationLabel => 'Translation';

  @override
  String get translateTo => 'Translate to';

  @override
  String get translateToEnglish => 'English';

  @override
  String get translateToTurkish => 'Türkçe';

  @override
  String get sourceLanguage => 'Source language';

  @override
  String get autoDetect => 'Auto-detect';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'English';

  @override
  String get copy => 'Copy';

  @override
  String get share => 'Share';

  @override
  String get saveToHistory => 'Save';

  @override
  String get resultShare => 'Share';

  @override
  String get resultNew => 'New';

  @override
  String get noResult => 'Nothing came back. Try again, a little louder maybe.';

  @override
  String get recording => 'Listening…';

  @override
  String get processing => 'Working on it';

  @override
  String get uploading => 'Sending the audio';

  @override
  String get transcribing => 'Transcribing';

  @override
  String get translating => 'Translating';

  @override
  String get stateIdle => 'Hold the button to start';

  @override
  String stateRecording(String time) {
    return 'Recording $time';
  }

  @override
  String get stateProcessing => 'Working on it…';

  @override
  String get stateDone => 'Done';

  @override
  String get stateError => 'Something went wrong';

  @override
  String get error => 'Something went wrong';

  @override
  String get permissionMicDenied =>
      'Mic access is off. Open settings to allow it.';

  @override
  String get historyTitle => 'History';

  @override
  String get historyKicker => 'Zoria · History';

  @override
  String get historyEmpty => 'Your translations will live here. Nothing yet.';

  @override
  String get historyClear => 'Clear all';

  @override
  String get historyClearConfirm => 'Erase every entry? This cannot be undone.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsKicker => 'Zoria · Settings';

  @override
  String get settingsLanguage => 'App language';

  @override
  String get settingsLangSystem => 'System';

  @override
  String get settingsSource => 'Source language';

  @override
  String get settingsTarget => 'Target language';

  @override
  String get settingsFooter => 'Made by ZoriaSoft · v1.0';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageSection => 'Language';

  @override
  String get appLanguage => 'App language';

  @override
  String get appLanguageSystem => 'System default';

  @override
  String get aboutSection => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfService => 'Terms of service';

  @override
  String get aboutApp =>
      'Zoria Çeviri turns your voice into text and lets you carry it across languages. Audio is processed through a secure proxy — your recordings are not stored on our servers.';

  @override
  String get navHome => 'Speak';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String durationSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get justNow => 'just now';

  @override
  String minutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get yesterday => 'yesterday';

  @override
  String daysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get retry => 'Retry';
}
