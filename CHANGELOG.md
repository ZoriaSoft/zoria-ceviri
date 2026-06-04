# Changelog

Tüm notable değişiklikler burada. Yeni oturum üstte.

## 2026-06-04 — Design polish + build fix

### Build & lint temizliği
- 48 analyze hatası → 0. Onarılanlar: DB `forTesting` named constructor, eksik pubspec deps (sqlite3, freezed_annotation, json_annotation), eksik l10n key'leri (homeHelp, navX, stateIdle, resultKicker, settingsKicker, historyKicker), app.dart `resolvedLocale` getter, recorderService onStateChanged getter kaldırma, app_theme.dart light() minimal hale getirme, test/widget_test.dart Flutter template test → gerçek smoke test.
- Widget test: 1/1 geçiyor (app boots, MaterialApp mount olur).
- Worker TypeScript: `tsconfig.json` eklendi, CORS origin callback `(c) => c.env` → `(c) => c.env?.ALLOW_ORIGIN ?? "*"`. 0 hata.
- AndroidManifest: `RECORD_AUDIO` + `INTERNET` izinleri eklendi.
- pubspec.yaml: assets/fonts/ referansı korundu, generate: true.

### Tasarım polish (editorial-mobile register)
- Yeni dosya: `lib/core/theme/motion.dart` — `AppMotion` token'ları (easeOut/easeInOut, press 120ms, recording 200ms, stateChange 220ms, enter 180ms, exit 90ms, stagger 60ms).
- app_theme.dart buton themesine press feedback (transform scale 0.97) + ease-out transition eklendi.
- home_screen.dart: `_RecordHalo` gradient → box-shadow glow (GPU-cheap); press state `AnimatedScale 0.94`; mic/stop ikon `AnimatedSwitcher` (fade + scale 0.92→1.0); `_SwapButton` 180° rotate on tap; `_StatusLine` AnimatedSwitcher.
- root_shell.dart: `_NavItem` `AnimatedScale` 0.92 active state + Icon AnimatedSwitcher.
- result_screen.dart: `TweenAnimationBuilder` slide-up (12px) + fade-in entrance, AppMotion.enter.
- DESIGN.md: Motion bölümü eklendi, Before/After tablo kararları işlendi.

### Yapılan
- "0 issues found!" (flutter analyze), 1/1 test geçti, worker tsc temiz.
- 5 polish detayı; hiçbiri yeni feature değil, sadece var olan akışın hissiyatı.

