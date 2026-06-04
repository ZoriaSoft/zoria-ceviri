import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Zoria Çeviri'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Speak. We listen, transcribe, translate.'**
  String get tagline;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get homeGreeting;

  /// No description provided for @homeSubline.
  ///
  /// In en, this message translates to:
  /// **'Hold the button, speak naturally, let the words settle.'**
  String get homeSubline;

  /// No description provided for @homeHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get homeHelp;

  /// No description provided for @startRecording.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startRecording;

  /// No description provided for @stopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopRecording;

  /// No description provided for @recordHint.
  ///
  /// In en, this message translates to:
  /// **'Hold to record'**
  String get recordHint;

  /// No description provided for @pickFromDevice.
  ///
  /// In en, this message translates to:
  /// **'Pick an audio file'**
  String get pickFromDevice;

  /// No description provided for @openHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get openHistory;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultTitle;

  /// No description provided for @resultKicker.
  ///
  /// In en, this message translates to:
  /// **'Zoria · Result'**
  String get resultKicker;

  /// No description provided for @resultSource.
  ///
  /// In en, this message translates to:
  /// **'Transcript'**
  String get resultSource;

  /// No description provided for @resultTarget.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get resultTarget;

  /// No description provided for @transcriptLabel.
  ///
  /// In en, this message translates to:
  /// **'Transcript'**
  String get transcriptLabel;

  /// No description provided for @translationLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translationLabel;

  /// No description provided for @translateTo.
  ///
  /// In en, this message translates to:
  /// **'Translate to'**
  String get translateTo;

  /// No description provided for @translateToEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get translateToEnglish;

  /// No description provided for @translateToTurkish.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get translateToTurkish;

  /// No description provided for @sourceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get sourceLanguage;

  /// No description provided for @autoDetect.
  ///
  /// In en, this message translates to:
  /// **'Auto-detect'**
  String get autoDetect;

  /// No description provided for @turkish.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get turkish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @saveToHistory.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveToHistory;

  /// No description provided for @resultShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get resultShare;

  /// No description provided for @resultNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get resultNew;

  /// No description provided for @noResult.
  ///
  /// In en, this message translates to:
  /// **'Nothing came back. Try again, a little louder maybe.'**
  String get noResult;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get recording;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Working on it'**
  String get processing;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Sending the audio'**
  String get uploading;

  /// No description provided for @transcribing.
  ///
  /// In en, this message translates to:
  /// **'Transcribing'**
  String get transcribing;

  /// No description provided for @translating.
  ///
  /// In en, this message translates to:
  /// **'Translating'**
  String get translating;

  /// No description provided for @stateIdle.
  ///
  /// In en, this message translates to:
  /// **'Hold the button to start'**
  String get stateIdle;

  /// No description provided for @stateRecording.
  ///
  /// In en, this message translates to:
  /// **'Recording {time}'**
  String stateRecording(String time);

  /// No description provided for @stateProcessing.
  ///
  /// In en, this message translates to:
  /// **'Working on it…'**
  String get stateProcessing;

  /// No description provided for @stateDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get stateDone;

  /// No description provided for @stateError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get stateError;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// No description provided for @permissionMicDenied.
  ///
  /// In en, this message translates to:
  /// **'Mic access is off. Open settings to allow it.'**
  String get permissionMicDenied;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyKicker.
  ///
  /// In en, this message translates to:
  /// **'Zoria · History'**
  String get historyKicker;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your translations will live here. Nothing yet.'**
  String get historyEmpty;

  /// No description provided for @historyClear.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get historyClear;

  /// No description provided for @historyClearConfirm.
  ///
  /// In en, this message translates to:
  /// **'Erase every entry? This cannot be undone.'**
  String get historyClearConfirm;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsKicker.
  ///
  /// In en, this message translates to:
  /// **'Zoria · Settings'**
  String get settingsKicker;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsLanguage;

  /// No description provided for @settingsLangSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsLangSystem;

  /// No description provided for @settingsSource.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get settingsSource;

  /// No description provided for @settingsTarget.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get settingsTarget;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Made by ZoriaSoft · v1.0'**
  String get settingsFooter;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @appLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get appLanguageSystem;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsOfService;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'Zoria Çeviri turns your voice into text and lets you carry it across languages. Audio is processed through a secure proxy — your recordings are not stored on our servers.'**
  String get aboutApp;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Speak'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String durationSeconds(int seconds);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(int count);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String daysAgo(int count);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
