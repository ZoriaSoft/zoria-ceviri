import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  const AppSettings({required this.locale, required this.sourceLang, required this.targetLang});
  final String locale;
  final String sourceLang;
  final String targetLang;
}

class SettingsController extends StateNotifier<AppSettings> {
  SettingsController(this._prefs)
      : super(AppSettings(
          locale: _prefs.getString(_kLocale) ?? 'system',
          sourceLang: _prefs.getString(_kSource) ?? 'auto',
          targetLang: _prefs.getString(_kTarget) ?? 'en',
        ));

  final SharedPreferences _prefs;

  static const _kLocale = 'settings.locale';
  static const _kSource = 'settings.source';
  static const _kTarget = 'settings.target';

  Future<void> setLocale(String v) async {
    await _prefs.setString(_kLocale, v);
    state = AppSettings(locale: v, sourceLang: state.sourceLang, targetLang: state.targetLang);
  }

  Future<void> setSource(String v) async {
    await _prefs.setString(_kSource, v);
    state = AppSettings(locale: state.locale, sourceLang: v, targetLang: state.targetLang);
  }

  Future<void> setTarget(String v) async {
    await _prefs.setString(_kTarget, v);
    state = AppSettings(locale: state.locale, sourceLang: state.sourceLang, targetLang: v);
  }

  Locale? get resolvedLocale {
    if (state.locale == 'system') return null;
    return Locale(state.locale);
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AppSettings>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsController(prefs);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError('Override at app start');
});
