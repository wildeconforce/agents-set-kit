# 🆘 Troubleshooting — first place to look when stuck

## 🔍 Diagnostic priority

Try in order:
1. **Open a new terminal window** (60% of issues)
2. **`/exit` + `claude --continue`** (restart Claude Code)
3. **Check internet connection**
4. **Search this doc for the symptom**

---

## 📦 Install phase

### `npm: command not found`
**Cause**: Node.js missing or PATH not applied
**Fix**:
- Confirm Node.js install: https://nodejs.org (LTS)
- Open a **new** terminal after install
- Mac: `source ~/.zshrc`

### `EACCES: permission denied`
**Mac/Linux**:
```bash
sudo npm install -g <package>
```

**Windows**: right-click PowerShell → "Run as Administrator" → retry

### `ENOENT: no such file or directory`
**Cause**: corrupted npm cache
**Fix**:
```bash
npm cache clean --force
npm install -g <package>
```

### Windows: `node` works but `npm` doesn't
**Fix**: reinstall Node.js (npm comes bundled)

---

## 🤖 Claude Code

### `claude` not recognized after install
**Fix**:
1. New terminal
2. `npm root -g` → confirm output path is in PATH
3. Windows: add `%APPDATA%\npm` to PATH

### Browser doesn't open on first login
**Fix**: copy the URL from the terminal manually into your browser

### Responses come in English only
**Fix**:
```
From now on, always respond in Korean.
```

### Hit usage limit
**Fix**:
- Wait until next hour / next day
- Or switch to OpenClaw + free models

### Can't get back in after `/exit`
**Fix**:
```bash
claude --continue
```

---

## 📦 OpenClaw

### `openclaw` not recognized
**Fix**: same as Claude Code — new terminal / check `npm root -g`.

### "Unknown model" error
**Cause**: model not in OpenClaw's static catalog
**Fix**:
```bash
openclaw models list --all  # see available models
```
If yours isn't there → use a similar one.

### Config file corrupted
**Fix**:
```bash
# Backup then reset
mv ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak
openclaw  # auto-recreates
```

### Endless model errors
**Fix**:
```bash
openclaw doctor --fix
```

---

## 🌐 OpenRouter

### `429 rate-limited`
**Cause**: free tier limit hit
**Fix**: switch to a different model (use the fallback chain)

### `401 unauthorized`
**Cause**: bad API key
**Fix**:
- Recheck your key at https://openrouter.ai/keys
- Re-register the env var / config

### "no endpoints found"
**Cause**: model temporarily disabled
**Fix**: switch to a different free model

---

## 💻 Ollama

### Daemon not running
```bash
# Manual start
ollama serve

# Windows: click tray app or
"C:\Program Files\Ollama\ollama.exe" serve
```

### Very slow (CPU mode)
**Fix**:
- Smaller model (`qwen2.5:7b` → `llama3.2:3b`)
- Or switch to a cloud model (OpenRouter)

### Out of memory
**Cause**: not enough RAM
**Fix**: smaller model or close other apps

### Model context too short (4k)
**Fix**: set the env var
```bash
export OLLAMA_CONTEXT_LENGTH=32768
```
(Windows: `setx OLLAMA_CONTEXT_LENGTH 32768`)
Restart Ollama after setting.

---

## 📱 Telegram bot

### Bot doesn't respond (no typing indicator)
**Cause**: bad token or Claude Code not running
**Fix**:
- Re-check token at `@BotFather → /mybots → bot → "API Token"`
- Make sure Claude Code is running (`claude` open)

### Bot doesn't respond (typing IS shown) ⚠️
**Cause (most common)**: missing `--channels` flag (after npm update)
**Fix**:
1. Diagnose:
   ```bash
   # Mac/Linux
   cat ~/.npm-global/bin/claude | grep channels

   # Windows
   type %APPDATA%\npm\claude.cmd | findstr channels
   ```
2. Empty output → re-patch the shim:
   - Open the npm shim file
   - Add `--channels plugin:telegram@claude-plugins-official` before the `claude.exe` invocation
3. Restart Claude Code (`/exit` + `claude --continue`)

### Token leaked
**Fix**: BotFather → `/mybots` → bot → "Revoke Token" → reissue → update `.env`

### Letting others use the bot
Edit `~/.claude/channels/telegram/access.json`:
```json
{
  "allowFrom": ["yourID", "friendID"]
}
```

---

## 🌐 General / network

### Korean IP blocked (rare)
**Symptom**: page won't load, can't sign up
**Fix**: VPN (Cloudflare WARP free, the 1.1.1.1 app)

### npm very slow
Korean mirror:
```bash
npm config set registry https://registry.npmmirror.com/
```
Restore:
```bash
npm config set registry https://registry.npmjs.org/
```

### Wifi drops (during a class)
- Turn on phone hotspot
- Use mobile data temporarily

---

## 🔍 Diagnostic tools

### One-shot system check
```bash
# Mac/Linux
node --version && npm --version && claude --version && openclaw --version

# Windows PowerShell
node --version; npm --version; claude --version; openclaw --version
```

### Telegram bot status
```bash
curl https://api.telegram.org/bot<token>/getMe
```

### Claude Code shim state
```bash
# Mac/Linux
which claude
cat $(which claude) | grep channels

# Windows
where claude
type "%APPDATA%\npm\claude.cmd"
```

---

## 💬 Still stuck?

### Step 1 — search yourself
- Google in English: paste the error message verbatim
- Throw the error at ChatGPT / Claude

### Step 2 — community
- [Issues](https://github.com/wildeconforce/agents-set-kit/issues) — search for similar problems
- If none → New Issue (include error / environment / what you tried)

### Step 3 — direct contact
- X DM: [@wildeconforce](https://x.com/wildeconforce)
- Email: redjacker84@gmail.com

---

## 📝 How to file a good Issue

### Good
```
Title: [Mac] After installing Claude Code, 'claude' command not recognized

Environment:
- macOS Sonoma 14.5
- Node.js v22.0.0
- Command: npm install -g @anthropic-ai/claude-code (with sudo)

Symptom:
- Install completed but 'claude' returns 'command not found'
- Same after opening a new terminal

What I tried:
1. source ~/.zshrc — no effect
2. echo $PATH — /usr/local/bin present
3. npm root -g — /usr/local/lib/node_modules

Expected: claude --version output
Actual: command not found
```

### Bad
```
Install isn't working. What do I do?
```
(No environment, command, or error → hard to help)
