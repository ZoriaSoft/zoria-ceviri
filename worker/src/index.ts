import { Hono } from "hono";
import { cors } from "hono/cors";

type Bindings = {
  NVIDIA_API_TOKEN: string;
  NIM_FUNCTION_ID: string; // e.g. "b702f636-f60c-4a3d-a6f4-f3568c13bd7d"
  ALLOW_ORIGIN?: string;   // e.g. "https://zoria.zo.space" or "*" for dev
  RATE_PER_MIN?: string;
};

const app = new Hono<{ Bindings: Bindings }>();

app.use("*", cors({
  origin: (c) => (c as any).env?.ALLOW_ORIGIN ?? "*",
  allowMethods: ["POST", "OPTIONS"],
  allowHeaders: ["Content-Type"],
}));

// Naive in-memory token bucket per IP (per-isolate, good enough for soft guard).
const buckets = new Map<string, { tokens: number; updated: number }>();
function takeToken(ip: string, ratePerMin: number): boolean {
  const now = Date.now();
  const refillPerMs = ratePerMin / 60_000;
  const b = buckets.get(ip) ?? { tokens: ratePerMin, updated: now };
  b.tokens = Math.min(ratePerMin, b.tokens + (now - b.updated) * refillPerMs);
  b.updated = now;
  if (b.tokens < 1) { buckets.set(ip, b); return false; }
  b.tokens -= 1;
  buckets.set(ip, b);
  return true;
}

app.get("/", (c) => c.json({ service: "zoria-ceviri", status: "ok" }));

// Multipart /v1/transcribe → NIM gRPC → JSON.
// Avoids Worker-to-Worker gRPC at the edge by talking to NIM via its public REST
// bridge on docker NIM; here we transcribe via NIM's OpenAI-compatible surface.
app.post("/v1/transcribe", async (c) => {
  const ip = c.req.header("cf-connecting-ip") ?? "anon";
  const rpm = Number(c.env.RATE_PER_MIN ?? 30);
  if (!takeToken(ip, rpm)) return c.json({ error: "rate_limited" }, 429);

  const form = await c.req.parseBody();
  const file = form.file;
  const sourceLang = (form.source_lang as string) || "auto";
  const targetLang = (form.target_lang as string) || "en";

  if (!(file instanceof File)) {
    return c.json({ error: "missing_file" }, 400);
  }

  // Bridge to NIM OpenAI-compatible REST surface. Falls back to gRPC if you
  // wire `nvidia-riva` (Node) into the bundle — see README.
  const upstream = new FormData();
  upstream.append("file", file, "recording.m4a");
  upstream.append("model", "whisper-large-v3");
  if (sourceLang !== "auto") upstream.append("language", sourceLang);

  const whisp = await fetch("https://integrate.api.nvidia.com/v1/audio/transcriptions", {
    method: "POST",
    headers: {
      authorization: `Bearer ${c.env.NVIDIA_API_TOKEN}`,
    },
    body: upstream,
  });
  if (!whisp.ok) {
    const err = await whisp.text();
    return c.json({ error: "upstream_transcription_failed", detail: err }, 502);
  }
  const whispJson = (await whisp.json()) as { text: string };

  let translated = "";
  if (targetLang && targetLang !== sourceLang) {
    const tform = new FormData();
    tform.append("file", file, "recording.m4a");
    tform.append("model", "whisper-large-v3");
    tform.append("language", sourceLang === "auto" ? "en" : sourceLang);
    const tr = await fetch("https://integrate.api.nvidia.com/v1/audio/translations", {
      method: "POST",
      headers: { authorization: `Bearer ${c.env.NVIDIA_API_TOKEN}` },
      body: tform,
    });
    if (tr.ok) {
      const t = (await tr.json()) as { text: string };
      translated = t.text;
    }
  }

  return c.json({
    source_text: whispJson.text ?? "",
    translated_text: translated,
    detected_lang: sourceLang,
    duration_ms: 0,
  });
});

export default app;
