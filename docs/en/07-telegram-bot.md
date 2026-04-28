# 07 — Telegram bot integration

> **Goal**: send a Telegram message → your PC runs the task → reply lands in Telegram.
> **Time**: 30 min.

The start of automation. Command your AI without sitting at the computer.

---

## ✅ Sign up for Telegram (if you haven't)

1. Install the Telegram app on your phone
2. Enter phone number → SMS verification
3. Enter name / username → done

Desktop also works, but phone-number verification is required first.

---

## ✅ Create a bot — BotFather

1. In Telegram, search `@BotFather` → start chat
2. Command:
   ```
   /newbot
   ```
3. Enter bot name (anything, e.g. `MyAIAgent`)
4. Enter bot username — **must end with `_bot`** (e.g. `myaiagent_2026_bot`)
5. **You get a token**: format `1234567890:ABCdefGhIjKlMnOpQrStUvWxYz`
6. **Copy the token → save somewhere safe.** You can't view it again.

### Token security
- Never put on GitHub / chat / anywhere public
- If leaked: BotFather → `/mybots` → bot → "Revoke Token" → reissue

---

## ✅ Install the Claude Code Telegram plugin

Inside Claude Code (after running `claude`):

```
/plugin install plugin:telegram@claude-plugins-official
```

Once installed, slash commands become available.

---

## ✅ Register the token

```
/telegram:configure
```

Interactive mode prompts for the token. Paste → save.

Or edit the `.env` file directly:
```bash
# File: ~/.claude/channels/telegram/.env
TELEGRAM_BOT_TOKEN=1234567890:ABCdefGhIjKlMnOpQrStUvWxYz
```

---

## ✅ Pairing — register your Telegram ID

1. Open the chat with your bot (e.g. `@myaiagent_2026_bot`)
2. Send `/start`
3. In Claude Code:
   ```
   /telegram:access
   ```
4. You get a pairing code → reply with the code in the bot chat
5. Registered

### Or manual registration
Get your chat ID:
```
https://api.telegram.org/bot<token>/getUpdates
```
→ `"id":` in the JSON is your chat ID.

Edit `access.json`:
```json
{
  "dmPolicy": "allowlist",
  "allowFrom": ["1234567890"]
}
```
Path: `~/.claude/channels/telegram/access.json`

---

## ⚠️ Critical — `--channels` flag

Claude Code sessions must opt in to the Telegram channel for it to work.

### Auto-apply (recommended)
Patch the npm shim:

**Windows** — `%APPDATA%\npm\claude.cmd`:
```cmd
"%dp0%\node_modules\@anthropic-ai\claude-code\bin\claude.exe" --channels plugin:telegram@claude-plugins-official %*
```

**Mac/Linux** — `~/.npm-global/bin/claude` or similar:
```sh
exec "$basedir/node_modules/@anthropic-ai/claude-code/bin/claude.exe" --channels plugin:telegram@claude-plugins-official "$@"
```

### Re-patch after npm updates
A claude-code update regenerates the shim → your patch is gone. Re-apply.

---

## ✅ Verify it works

1. In Claude Code, `/exit` → `claude --continue` (restart)
2. Send the bot a message:
   ```
   Hi! Please respond in English.
   ```
3. Claude Code terminal shows the message arriving:
   ```
   <channel source="plugin:telegram:telegram" chat_id="..." ...>
   Hi! Please respond in English.
   </channel>
   ```
4. Claude responds → automatically sent to Telegram
5. The reply appears on your phone

Done.

---

## 💡 Automation scenarios

### 1. Daily morning briefing
```
Every day at 8am, summarize yesterday's calendar and send to Telegram.
```
→ Claude Code sets up a cron automatically.

### 2. Photo-of-code debugging
On your phone, photograph code → send to bot → "Analyze this error"
→ Bot OCRs + analyzes + replies.

### 3. Auto-journaling / retrospective
"Summarize today" → bot scans your notes / mail → summary.

### 4. Long-running tasks in the background
"Analyze this 100MB file and ping me when done"
→ Claude Code runs → notification on Telegram when finished.

---

## 🚧 Troubleshooting

### Bot doesn't respond (no "typing" indicator)
- Verify the token (BotFather → `/mybots` → bot → "API Token")
- Verify the bot username

### Bot doesn't respond (typing IS shown)
**Cause**: missing `--channels` flag (common after npm updates)
**Fix**: re-patch the shim + restart Claude Code
```bash
# Diagnose
grep "channels" ~/.npm-global/bin/claude  # Mac/Linux
type %APPDATA%\npm\claude.cmd  # Windows
```
→ If `--channels` is missing, re-patch.

### Letting other people use the bot
Add their IDs to `access.json`:
```json
"allowFrom": ["1234567890", "9876543210"]
```

### Group chat
```json
{
  "groups": {
    "-1001234567890": {
      "allowFrom": ["1234567890"],
      "requireMention": true
    }
  }
}
```
In group, mention `@yourbot` to trigger.

---

## ⚠️ Security

### Never do
- Push the bot token to GitHub (it gets stolen instantly)
- Add strangers to `allowFrom`
- Send sensitive info ("my password is X") to the bot

### Do
- Keep the token in `.env` only (`.gitignore` it)
- Rotate the token monthly (Revoke + reissue)
- Use `dmPolicy: "allowlist"` (no public bots)

---

## ✅ Next

- [08-agents-hq-dashboard.md](08-agents-hq-dashboard.md) — live dashboard for monitoring
- Or start your own automation scenarios
