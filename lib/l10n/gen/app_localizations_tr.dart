// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Zoria Çeviri';

  @override
  String get tagline =>
      'Konuş, dinleyelim. Yazıya döksün, dilinden diline taşısın.';

  @override
  String get homeGreeting => 'Hazır olduğunda başla';

  @override
  String get homeSubline =>
      'Tuşu basılı tut, doğal konuş, kelimelerin otursun.';

  @override
  String get homeHelp => 'Yardım';

  @override
  String get startRecording => 'Başla';

  @override
  String get stopRecording => 'Dur';

  @override
  String get recordHint => 'Basılı tut, kayıt başlasın';

  @override
  String get pickFromDevice => 'Cihazdan ses dosyası seç';

  @override
  String get openHistory => 'Geçmiş';

  @override
  String get resultTitle => 'Sonuç';

  @override
  String get resultKicker => 'Zoria · Sonuç';

  @override
  String get resultSource => 'Transkripsiyon';

  @override
  String get resultTarget => 'Çeviri';

  @override
  String get transcriptLabel => 'Transkripsiyon';

  @override
  String get translationLabel => 'Çeviri';

  @override
  String get translateTo => 'Hedef dil';

  @override
  String get translateToEnglish => 'English';

  @override
  String get translateToTurkish => 'Türkçe';

  @override
  String get sourceLanguage => 'Kaynak dil';

  @override
  String get autoDetect => 'Otomatik algıla';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'English';

  @override
  String get copy => 'Kopyala';

  @override
  String get share => 'Paylaş';

  @override
  String get saveToHistory => 'Kaydet';

  @override
  String get resultShare => 'Paylaş';

  @override
  String get resultNew => 'Yeni kayıt';

  @override
  String get noResult =>
      'Bir şey gelmedi. Biraz daha yüksek sesle tekrar dener misin?';

  @override
  String get recording => 'Dinliyorum…';

  @override
  String get processing => 'Üzerinde çalışıyorum';

  @override
  String get uploading => 'Sesi gönderiyorum';

  @override
  String get transcribing => 'Yazıya dökülüyor';

  @override
  String get translating => 'Çevriliyor';

  @override
  String get stateIdle => 'Başlamak için tuşu basılı tut';

  @override
  String stateRecording(String time) {
    return 'Kayıt $time';
  }

  @override
  String get stateProcessing => 'Üzerinde çalışıyorum…';

  @override
  String get stateDone => 'Tamam';

  @override
  String get stateError => 'Bir sorun çıktı';

  @override
  String get error => 'Bir sorun çıktı';

  @override
  String get permissionMicDenied =>
      'Mikrofon izni kapalı. Ayarlardan açabilirsin.';

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String get historyKicker => 'Zoria · Geçmiş';

  @override
  String get historyEmpty => 'Çevirilerin burada birikecek. Henüz boş.';

  @override
  String get historyClear => 'Hepsini temizle';

  @override
  String get historyClearConfirm =>
      'Tüm geçmişi silmek istediğine emin misin? Geri alınamaz.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsKicker => 'Zoria · Ayarlar';

  @override
  String get settingsLanguage => 'Uygulama dili';

  @override
  String get settingsLangSystem => 'Sistem';

  @override
  String get settingsSource => 'Kaynak dil';

  @override
  String get settingsTarget => 'Hedef dil';

  @override
  String get settingsFooter => 'ZoriaSoft · v1.0';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get languageSection => 'Dil';

  @override
  String get appLanguage => 'Uygulama dili';

  @override
  String get appLanguageSystem => 'Sistem dili';

  @override
  String get aboutSection => 'Hakkında';

  @override
  String get version => 'Sürüm';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get termsOfService => 'Kullanım koşulları';

  @override
  String get aboutApp =>
      'Zoria Çeviri sesini yazıya döker, dilinden diline taşır. Sesler güvenli bir katman üzerinden işlenir — kayıtların sunucularımızda saklanmaz.';

  @override
  String get navHome => 'Konuş';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String durationSeconds(int seconds) {
    return '${seconds}sn';
  }

  @override
  String get justNow => 'şimdi';

  @override
  String minutesAgo(int count) {
    return '${count}dk önce';
  }

  @override
  String hoursAgo(int count) {
    return '${count}sa önce';
  }

  @override
  String get yesterday => 'dün';

  @override
  String daysAgo(int count) {
    return '${count}g önce';
  }

  @override
  String get cancel => 'Vazgeç';

  @override
  String get delete => 'Sil';

  @override
  String get ok => 'Tamam';

  @override
  String get retry => 'Tekrar dene';
}
