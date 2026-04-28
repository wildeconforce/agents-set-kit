# 04 — Install OpenClaw

> **Goal**: use multiple free models from one place.
> **Time**: 30 min.

OpenClaw is similar to Claude Code, but it handles **multiple models / multiple providers** at once — Llama / Qwen / DeepSeek / GPT-OSS as well as Claude / GPT / Gemini.

This step is **optional** — Claude Code alone gets work done. Use OpenClaw if you want cost savings or to compare models side by side.

---

## ✅ Install

```bash
npm install -g openclaw
```

### Verify
```bash
openclaw --version
```

### First run
```bash
openclaw
```
The first run auto-creates the config file (`~/.openclaw/openclaw.json`). ~30 seconds.

---

## ✅ Register a model provider

OpenClaw doesn't ship with models. You need an external provider's API key. Free options recommended:

### Option A — OpenRouter free models (recommended)
- See [05-openrouter-free.md](05-openrouter-free.md)
- No credit card required
- Daily limits, but plenty for learning

### Option B — Anthropic direct (same key as Claude Code)
```bash
openclaw config set models.providers.anthropic.apiKey YOUR_ANTHROPIC_KEY
```

### Option C — Ollama local (unlimited free)
- See [06-ollama-local.md](06-ollama-local.md)
- Run models on your own machine → unlimited free
- But you need decent specs (16GB+ RAM)

---

## ✅ Set the model

### Default model
```bash
# OpenRouter free model
openclaw models set openrouter/openai/gpt-oss-120b:free

# Claude (if Anthropic key is registered)
openclaw models set anthropic/claude-sonnet-4-6

# Ollama local
openclaw models set ollama/qwen2.5:7b
```

### Fallback chain (multi-layer safety net)
If the primary model is down, OpenClaw automatically falls through:
```bash
openclaw models fallbacks add openrouter/qwen/qwen3-coder:free
openclaw models fallbacks add ollama/qwen2.5:7b
```

---

## ✅ First run

```bash
openclaw
```
The interface is similar to Claude Code. Plain language commands.

```
Hi! Please respond in English.
```

The response comes from whichever model you selected.

### Compare models — same prompt, multiple models
```bash
# Run with model 1
openclaw models set openrouter/openai/gpt-oss-120b:free
openclaw "Introduce yourself"

# Run with model 2
openclaw models set openrouter/qwen/qwen3-coder:free
openclaw "Introduce yourself"
```

→ Comparing the answers exposes each model's personality.

---

## 💡 Recommended free models with strong Korean

| Model ID | Notes |
|----------|-------|
| `openrouter/openai/gpt-oss-120b:free` | OpenAI open-source, balanced |
| `openrouter/qwen/qwen3-coder:free` | Native Korean, strong on code |
| `openrouter/google/gemma-3-27b-it:free` | Google Gemma, fast |
| `ollama/qwen2.5:7b` | Local, native Korean |
| `ollama/deepseek-r1:14b` | Local, strong reasoning (no tool support though) |

---

## 🚧 Troubleshooting

### "Unknown model" error
Model ID isn't in OpenClaw's static catalog. Check available models:
```bash
openclaw models list --all
```
If yours isn't there → register a custom provider (advanced).

### "rate-limited upstream"
Free models have per-minute call limits. Retry shortly.

### Models without tool support
Some reasoning models (DeepSeek-R1 etc.) don't support tool calling.
OpenClaw is tool-call-based, so these can't do agent work.
→ Use Qwen / GPT-OSS / Llama (tools-supported) for agent tasks.

### Awkward Korean responses
Add a persona rule to OpenClaw's `SOUL.md`:
```bash
echo '## Language: Always respond in Korean by default.' >> ~/.openclaw/workspace/SOUL.md
```
Korean responses enforced from the next run.

---

## ✅ Next

- [05-openrouter-free.md](05-openrouter-free.md) — OpenRouter free models in detail
- [06-ollama-local.md](06-ollama-local.md) — local models for truly unlimited free
