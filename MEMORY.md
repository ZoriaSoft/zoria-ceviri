# Zoria Çeviri — Proje Hafızası

## Tek satır
Android-first Flutter uygulaması — konuşmayı transkripte et ve isteğe bağlı olarak hedef dile çevir. Altyapı: NVIDIA NIM Whisper (gRPC), Cloudflare Worker (proxy + rate-limit + secret).

## Durum (2026-06-04)
- ✅ Proje iskeleti yazıldı: `lib/` (Pragmatic Clean), `worker/`, `l10n/` (TR+EN), `pubspec.yaml`, `DESIGN.md`, `README.md`
- ✅ `flutter pub get` çözüldü (154 paket) — `pubspec.lock` mevcut
- ⚠️ `dart run build_runner build` → **OOM** (sandbox 4GB RAM yetersiz)
- ❌ `flutter analyze` çalıştırılamadı (sandbox kapandı)
- ❌ `flutter build apk` çalıştırılamadı (sandbox kapandı + Flutter SDK yok /opt dışında)
- ❌ Sandbox `ta-01KT882E3RRRM8ZV04CC4F8M4P` KAPANDI — bu oturumda daha fazla test imkansız

## Yeni oturumda ilk iş
1. `cd /home/workspace/Projects/zoria-ceviri`
2. `export PATH="/opt/flutter/bin:$PATH"` (Flutter 3.44.0 /opt/flutter altında mevcut)
3. `flutter pub get` (lock var, hızlı çözüm)
4. `flutter analyze` — tüm hataları listele, düzelt
5. `flutter build apk --debug --dart-define=AI_BASE_URL=https://placeholder.workers.dev` — APK doğrula

## Stack
- **Mobil:** Flutter 3.44 / Dart 3.12, Android target (Kotlin), min SDK 24
- **Mimari:** Pragmatic Clean — `app/`, `core/`, `data/`, `domain/`, `features/`, `shared/`, `l10n/`
- **State:** Riverpod 2.5.x (manuel provider, generator kullanılmadı)
- **Routing:** GoRouter 14
- **DB:** Drift 2.18 (transkripsiyon geçmişi) — `.g.dart` henüz generate edilmedi
- **Network:** Dio 5.5 (multipart upload)
- **Ses:** `record` 5.x (Android), m4a/aac, 16kHz hedef
- **Tema:** editorial-mobile register, amber accent, Fraunces + Inter Tight + JetBrains Mono
- **i18n:** TR + EN (Flutter intl, ARB)
- **AI backend:** Cloudflare Worker + Hono → NVIDIA NIM Whisper

## Zorunlu kural (DNA)
- Kullanıcıdan API key / Worker URL **asla** istenmez
- `AI_BASE_URL` build-time `--dart-define` ile gömülür
- Worker secret'ında `NVIDIA_API_TOKEN` tutulur
- Uygulamada "Worker URL" / "API anahtarı" / "Mock'a dön" UI alanı **yok**

## Bilinen TODO'lar (henüz tamamlanmadı)
- [ ] `dart run build_runner build --delete-conflicting-outputs` → drift `app_database.g.dart` + freezed `translation_dto.freezed.dart/.g.dart` üretecek (AMA: freezed kullanımı kaldırıldı, düz class yazıldı; sadece drift gerekli)
- [ ] `flutter analyze` çıktısına göre import/lint hataları düzeltilecek
- [ ] `flutter build apk --debug` ile build doğrulanacak
- [ ] Android `AndroidManifest.xml` → `RECORD_AUDIO` izni eklenecek
- [ ] App icon + splash screen (boilerplate Flutter iconu duruyor)
- [ ] Worker deploy edilecek + gerçek `AI_BASE_URL` ile APK alınacak
- [ ] NIM Whisper gRPC veya REST davranışı canlıda test edilecek

## Kritik tasarım kararları
- Register: `editorial-mobile` (Fraunces serif + amber aksan)
- Yasaklar: mor gradyan, Inter/Geist default, generic Material 3 surface, `bg-zinc-*` combo
- Detay: `DESIGN.md`

## NIM Whisper davranış notları
- **Offline-only** — streaming yok
- Word timestamps, confidence, alternatives, diarization, hotword biasing → **YOK**
- Yapabiliyor: transcription, auto language detect (`multi`), translation to English, auto punctuation, verbatim
- Server: `grpc.nvcf.nvidia.com:443`, function-id: `b702f636-f60c-4a3d-a6f4-f3568c13bd7d`
- Test sonucu: 11s JFK audio → 0.99s transkript, doğruluk mükemmel
- **NIM'in REST endpoint'i 404 döndü** (`/v1/audio/transcriptions` çalışmıyor) → Worker'da `integrate.api.nvidia.com` kullanılıyor (OpenAI-uyumlu köprü)

## Düzeltilmesi gereken şeyler
- `lib/data/models/translation_dto.dart` yarım kaldı → rewrite gerekli (önceki yazım kesilmişti)
- `app.dart` import'larında `buildLightTheme`/`buildDarkTheme` kullanılmış ama `app_theme.dart` sadece `dark()` döndürüyor → ya `app.dart` sadeleştirilecek, ya da tema 2 modlu yazılacak
- `home_screen.dart`'te `AppColors.surfaceElevated` kullanılmış ama `app_colors.dart`'ta yok → `surfaceRaised` ile değiştirilecek
- `result_screen.dart`'te `resultHelp`, `resultKicker`, `resultSource`, `resultTarget`, `resultShare`, `resultNew` gibi stringler kullanılmış ama ARB'de yok → ya ARB'ye eklenecek, ya da inline kullanılacak
- Benzer şekilde `history_screen.dart`, `settings_screen.dart`, `root_shell.dart` ARB stringleri eksik

## Çalışma komutları
```bash
export PATH="/opt/flutter/bin:$PATH"
cd /home/workspace/Projects/zoria-ceviri
flutter pub get
flutter analyze
flutter build apk --debug --dart-define=AI_BASE_URL=https://<worker>.workers.dev
```

## Workspace path'leri
- Proje root: `/home/workspace/Projects/zoria-ceviri/`
- Worker: `/home/workspace/Projects/zoria-ceviri/worker/`
- Referans mimari: `/home/workspace/Projects/zoria-videonote/src/`
- Toolchain referansı: `/home/workspace/Skills/zoria-flutter-bootstrap/assets/reference/`
