# Zoria Çeviri — Tasarım Sistemi

**Register:** `editorial-mobile` — keli

## Motion (polish, 2026-06-04)

Editorial-mobile register'a uygun: minimal ama hissedilir.

**Tokens (`lib/core/theme/motion.dart`):**
- Easings: `easeOut` (0.23, 1, 0.32, 1) — UI feedback / entry
            `easeInOut` (0.77, 0, 0.175, 1) — on-screen movement
- Durations: `press` 120ms, `recording` 200ms, `stateChange` 220ms, `enter` 180ms, `exit` 90ms
- Asymmetric enter/exit: girişler yavaş (180ms), çıkışlar hızlı (90ms) — Emil Kowalski
- Sadece `transform` + `opacity` animate edilir (GPU-friendly)
- Custom curves (built-in easings "çok zayıf" hissediyor)

**Uygulanan hareketler:**

| Element | Animasyon | Neden |
|---|---|---|
| `_RecordHalo` press | AnimatedScale 1.0 → 0.94, 120ms easeOut | Basınca anında tepki |
| `_RecordHalo` record glow | box-shadow blur/spread 200ms easeOut, alpha pulse | Sesin varlığı, yazıya dönüş süreci |
| `_RecordHalo` mic/stop ikon | AnimatedSwitcher (fade+scale 0.92→1.0) 220ms | State değişimini yumuşak gösterir |
| `_StatusLine` text | AnimatedSwitcher 220ms | State metni değişiminde kesme yok |
| `_SwapButton` | 180° rotation on tap, 220ms easeInOut | Swap eylemi fiziksel hissettirir |
| Result screen entrance | Slide-up (12px) + fade-in, 180ms easeOut | Edit sayfası havası |
| Bottom nav items | AnimatedScale (active 0.92 / default 1.0), 100ms | Aktif tab hafifçe "basılı" hissi |
| Buttons (global theme) | scale(0.97) on press, 160ms easeOut | "Arayüz seni dinliyor" hissi |

**Yasaklar (Emil + DNA):**
- `ease-in` UI elementlerde (sluggish hissi)
- `transition: all` (specific property belirt)
- `scale(0)` (doğada hiçbir şey yoktan var olmaz — `scale(0.9)` + opacity)
- Keyframes on rapidly-triggered UI (interruptible değil)
- Animation > 300ms UI feedback için
- Hover animation `prefers-reduced-motion` kontrolsüz
