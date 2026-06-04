# Zoria Çeviri

Konuş, dinleyelim. Yazıya döksün, dilinden diline taşısın.

Android için Flutter ile yazılmış, NVIDIA NIM Whisper destekli bir transkripsiyon + çeviri uygulaması. Konuşmayı algılar, metne döker, istenirse hedef dile çevirir.

## Mimari

```
[Flutter]  → multipart upload
   ↓
[CF Worker + Hono]  → auth, rate-limit, secret yönetimi
   ↓ gRPC :443
[NVIDIA NIM Whisper]  → transcription / translation
```

- Kullanıcı API anahtarı **göremez**, Worker base URL build-time gömülüdür.
- TR + EN i18n, offline-first history (Drift), paylaşım/kopyalama.

## Yerel geliştirme

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run --dart-define=AI_BASE_URL=https://<your-worker>.workers.dev
```

## Worker deploy

`worker/` dizininde Hono + multipart alıp NIM gRPC'ye yönlendiren basit bir proxy bulunur. `wrangler secret put NVIDIA_API_TOKEN` ile token'ı ekle, `wrangler deploy` ile yayınla.

## Proje yapısı

```
lib/
├── app/                    # MaterialApp + router config
├── core/
│   ├── audio/              # recorder_service
│   ├── network/            # api_client (Dio)
│   ├── providers/          # global Riverpod providers
│   ├── router/             # GoRouter
│   └── theme/              # editorial-mobile palette + typography
├── data/
│   ├── database/           # Drift (history)
│   ├── models/             # freezed DTOs
│   └── repositories/       # transcription + history
├── features/
│   ├── home/               # ana ekran — bas-konuş
│   ├── recorder/           # kayıt state machine
│   ├── result/             # transkripsiyon + çeviri sonucu
│   ├── history/            # geçmiş
│   └── settings/           # dil tercihi
├── l10n/                   # TR + EN ARB
└── shared/widgets/         # root_shell, section_header
```
