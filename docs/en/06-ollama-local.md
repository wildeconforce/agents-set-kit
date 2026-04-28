# 06 — Ollama local models

> **Goal**: run AI models on your own PC — unlimited free, no data leaves your machine.
> **Time**: 30 min (incl. download time).

Ollama runs LLMs locally. Works without internet, $0 API cost, data stays on-device.

---

## ⚠️ Prerequisites

### Recommended specs
- 16GB+ RAM (8GB works, but only small models)
- GPU (NVIDIA preferred, CPU works but is slow)
- 20GB+ free disk (each model ~5–10GB)

### Not recommended
- 4GB RAM laptop — too slow
- Intel integrated graphics — small models only

---

## ✅ Install

### Windows
```powershell
winget install Ollama.Ollama
```
Or download .exe from https://ollama.com/download/windows

### Mac
```bash
brew install ollama
```
Or download .dmg from https://ollama.com/download/mac

### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Verify
```bash
ollama --version
```

---

## ✅ Download a model

### Recommended — Qwen 2.5 7B (balanced, native Korean)
```bash
ollama pull qwen2.5:7b
```
~4.4GB, 5–15 min download.

### Recommended models matrix

| Model | Size | RAM needed | Notes |
|-------|------|------------|-------|
| `qwen2.5:7b` | 4.7GB | 8GB+ | Native Korean, balanced |
| `qwen2.5:14b` | 9GB | 16GB+ | Smarter |
| `qwen2.5-coder:7b` | 4.7GB | 8GB+ | Code-specialized |
| `llama3.2:3b` | 2GB | 4GB+ | Lightweight |
| `llama3.3:70b` | 43GB | 64GB+ | Large (server-class) |
| `deepseek-r1:7b` | 4.7GB | 8GB+ | Strong reasoning (no tools) |
| `deepseek-r1:14b` | 9GB | 16GB+ | Reasoning, smarter |
| `gpt-oss:20b` | 13GB | 16GB+ | OpenAI open-source |

### List installed models
```bash
ollama list
```

### Remove a model
```bash
ollama rm qwen2.5:7b
```

---

## ✅ First run

### Direct chat
```bash
ollama run qwen2.5:7b
```
Drops you into a chat. Type, get a response. Exit: `/bye`.

### Korean test
```
Please respond in English.
Explain quantum computing to a 5-year-old in one line.
```

---

## ✅ Environment variable — context length

Default context is 4096 tokens (small). Not enough for agent work.

### Increase (persistent)

**Windows**:
```powershell
setx OLLAMA_CONTEXT_LENGTH 32768
```

**Mac/Linux**:
```bash
echo 'export OLLAMA_CONTEXT_LENGTH=32768' >> ~/.zshrc
source ~/.zshrc
```

Restart Ollama for it to take effect.

---

## ✅ Integrate with OpenClaw / Claude Code

### Register with OpenClaw
Set environment variable (like OLLAMA_CONTEXT_LENGTH above):
```bash
export OLLAMA_API_KEY="ollama-local"
```

OpenClaw config:
```bash
openclaw config set models.providers.ollama.baseUrl "http://localhost:11434/v1"
openclaw config set models.providers.ollama.apiKey "ollama-local"
```

Or edit `~/.openclaw/openclaw.json` directly:
```json
{
  "models": {
    "providers": {
      "ollama": {
        "baseUrl": "http://localhost:11434/v1",
        "apiKey": "ollama-local",
        "api": "openai-completions",
        "models": [
          {
            "id": "qwen2.5:7b",
            "name": "Qwen 2.5 7B",
            "input": ["text"],
            "cost": {"input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0},
            "contextWindow": 32768,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
```

Set as default model:
```bash
openclaw models set ollama/qwen2.5:7b
```

---

## ⚠️ Tool support check

OpenClaw is tool-call-based. Models without tool support can't do agent work.

### Check model capabilities
```bash
curl -s http://localhost:11434/api/show -d '{"name":"qwen2.5:7b"}' | grep capabilities
```

| Model | Tools | Recommendation |
|-------|-------|----------------|
| `qwen2.5:7b` | ✅ | OK |
| `qwen2.5-coder:7b` | ✅ | OK |
| `llama3.2:3b` | ✅ | OK |
| `llama3.3:70b` | ✅ | OK |
| `deepseek-r1:*` | ❌ | **No agent**, chat only |

---

## 🚧 Troubleshooting

### Daemon not running
```bash
# Mac/Linux
ollama serve

# Windows — Ollama tray app autostarts; if not:
"C:\Program Files\Ollama\ollama.exe" serve
```

### Very slow responses
- No GPU → CPU mode → slow (1–5 tokens/sec)
- Use a smaller model (`qwen2.5:7b` → `llama3.2:3b`)
- Or switch to a cloud model (OpenRouter)

### "model not found"
Model name is case-sensitive:
```bash
ollama list  # check what's installed
ollama pull qwen2.5:7b  # exact name
```

### Out of memory
RAM exhausted. Use a smaller model or upgrade your PC.

---

## 💡 Tips

### 24/7 operation
Leave your PC on and OpenClaw / Claude Code can run background tasks. Wire in the Telegram bot and you can command from your phone.

### Data security
Local = nothing leaves the machine. You can throw sensitive code / docs at the model freely.

### Cost comparison
- Claude API full-throttle 24/7: ~$200/mo
- OpenRouter free: $0 (within limits)
- Ollama local: $0 (electricity ~$5/mo)

---

## ✅ Next

- [07-telegram-bot.md](07-telegram-bot.md) — command from your phone (start of automation)
- Or fold it into your own workflow
