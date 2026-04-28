# 05 — OpenRouter free models

> **Goal**: use 100+ AI models for free without registering a credit card.
> **Time**: 20 min.

OpenRouter unifies many AI providers (OpenAI / Anthropic / Google / Meta / Qwen / DeepSeek etc.) under one API. **Plenty of free models, no credit card required.**

---

## ✅ Sign up

1. Go to https://openrouter.ai
2. **Sign in** → Google / GitHub
3. You can use it immediately

### Credit card?
**Not required.** Hit a limit and you're auto-blocked, no charges. → Zero risk of a billing surprise.

(Different from traps like Gemini Free Trial — Gemini auto-converts to paid when you exceed limits!)

---

## ✅ Get an API key

1. Go to https://openrouter.ai/keys
2. Click **Create Key**
3. Give it a name (e.g. "claude-code") → Create
4. Copy the key (`sk-or-v1-...`)
5. **Save it somewhere safe** — you can't view it again

### Key security
- Never commit to GitHub / paste into chat
- If leaked: Revoke immediately + create new
- Save to `.env` only → add `.env` to `.gitignore`

---

## ✅ Register with Claude Code or OpenClaw

### Environment variable (Mac/Linux)
```bash
export OPENROUTER_API_KEY="sk-or-v1-yourkeyhere"
```
Persist:
```bash
echo 'export OPENROUTER_API_KEY="sk-or-v1-yourkeyhere"' >> ~/.zshrc
source ~/.zshrc
```

### Environment variable (Windows PowerShell)
```powershell
setx OPENROUTER_API_KEY "sk-or-v1-yourkeyhere"
```
Open a **new** PowerShell window for it to take effect.

### OpenClaw direct registration
```bash
openclaw config set models.providers.openrouter.apiKey "sk-or-v1-yourkeyhere"
```

---

## ✅ Use free models

### Set a free model in OpenClaw
```bash
openclaw models set openrouter/openai/gpt-oss-120b:free
```

### Recommended free models

| Model | Context | Notes |
|-------|---------|-------|
| `openai/gpt-oss-120b:free` | 128k | OpenAI open-source, stable |
| `openai/gpt-oss-20b:free` | 128k | Smaller, faster |
| `qwen/qwen3-coder:free` | 256k | Strong Korean + code |
| `google/gemma-3-27b-it:free` | 128k | Google Gemma, fast |
| `meta-llama/llama-3.3-70b-instruct:free` | 65k | Meta large |
| `nvidia/nemotron-nano-9b-v2:free` | 128k | NVIDIA reasoning |
| `z-ai/glm-4.5-air:free` | 128k | Z.AI, strong Korean |

### List available models
```bash
# All models
openclaw models list --all | grep ":free"
```

Or web: https://openrouter.ai/models?max_price=0 → "Free" filter.

---

## 💡 Free model limits

Each model has **per-minute / per-day / token** limits. Limits vary by model.

### Typical limits
- 5–20 calls/minute
- 50–500 calls/day
- Exceeded → 429 error → retry shortly

### Raising limits
1. Add **$10+** credit to OpenRouter → "Tier 1" → some models get higher limits
2. Add your own API keys (OpenAI / Anthropic) → use their limits

---

## 🚧 Troubleshooting

### "Provider returned error 429"
Limit exceeded. Switch to a different model or wait.

### Use the fallback chain
When the primary model is rate-limited, OpenClaw auto-falls through:
```bash
openclaw models fallbacks add openrouter/qwen/qwen3-coder:free
openclaw models fallbacks add openrouter/openai/gpt-oss-20b:free
```

### "No endpoints found"
Model is temporarily disabled on OpenRouter. Use a different one.

### Responses come in English only
Some free models (gpt-oss etc.) lean English-biased. Force Korean:
- Add "Respond in Korean" to the system prompt
- Add a rule to OpenClaw's `SOUL.md`

---

## 💰 Cost simulation

### Free only
- 24/7 light use → **$0**
- Heavy use → blocked when limit hit, refreshes the next day
- Zero risk of a billing surprise

### Tier 1 (one-time $10 top-up)
- Higher limits (varies by model)
- Free + paid models in the same account

### Pay-as-you-go
- gpt-4o: $2.5 / 1M tokens
- claude-sonnet-4: $3 / 1M tokens
- Light use → $1–5/month

---

## ✅ Next

OpenRouter set up?
- [06-ollama-local.md](06-ollama-local.md) — local models, truly unlimited free
- [07-telegram-bot.md](07-telegram-bot.md) — command from your phone
