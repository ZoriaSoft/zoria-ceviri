# Mimari Kararlar

> Tarih sıralı. Yeni karar alta eklenir.

## 2026-06-04 — AI backend kanalı (gRPC yerine REST bridge)
Worker, NIM gRPC yerine NVIDIA'nın OpenAI uyumlu REST surface'ini kullanır
(`integrate.api.nvidia.com/v1/audio/transcriptions` + `/translations`).
**Gerekçe:** gRPC için ek Node paketi + proto dosyası gerekir; REST bridge aynı
işi bir fetch ile yapar. NIM'in kendi instance'ına geçersek bu kararı gözden
geçiririz (proto + nvidia-riva ekleriz).

## 2026-06-04 — Drift `forTesting` named constructor
Test'lerde memory'de Drift açabilmek için `AppDatabase.forTesting(QueryExecutor)`
eklendi. Prod constructor (file-based) değişmedi.

## 2026-06-04 — BYOK / API key YOK
Tüm AI çağrıları Worker üzerinden gider. Client uygulamada API key, Worker URL,
"Mock'a dön" UI alanı **yok**. Build-time `--dart-define=AI_BASE_URL` ile
gömülür. Kullanıcı bu detayı hiç görmez.

## 2026-06-04 — Tasarım: editorial-mobile register
Amber-ink palette + Fraunces / Inter Tight / JetBrains Mono. Son 3 Zoria
projesinden (zoria-cal, zoria-mesh, zoria-videonote) farklı. Koyu temalı,
asimetrik, edit-sayfası estetiği.
