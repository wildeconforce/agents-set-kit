# 08 — Agents HQ dashboard (optional)

> **Goal**: visualize agent runs live + push status to Telegram.
> **Time**: 30 min.

This step is **advanced / optional**. Reach for it when you want to monitor what your AI agent is doing in real time.

---

## Core features

- Agent card grid (per-role character avatars)
- Live transcript (user prompts / tool calls / results)
- Telegram push (status updates every 3 seconds)
- Public URL (cloudflared tunnel)

---

## ✅ Setup

This kit uses [agents-hq](https://github.com/wildeconforce/agents-hq) (separate repo).

### Quick start
```bash
git clone https://github.com/wildeconforce/agents-hq.git
cd agents-hq
python serve.py
```
→ open http://localhost:8787/dashboard.html

### Auto-start (Windows Startup)
- Run `agents-hq/startup.bat`
- Or add a .lnk to the Startup folder

### Cloudflared tunnel (external access)
```bash
cloudflared tunnel --url http://localhost:8787
```
→ Public URL issued (`https://xxxx.trycloudflare.com`).

---

## How it works

1. Claude Code hooks (`SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `Stop`)
2. `status_writer.py` consumes hook events and updates `state.json`
3. `dashboard.html` polls every 500ms and re-renders
4. `telegram_status.py` pushes the same data to a Telegram bot via edit-in-place

---

## Detailed setup

Out of scope for this kit. See the separate repo: [github.com/wildeconforce/agents-hq](https://github.com/wildeconforce/agents-hq).

---

## Use cases

- Live coding stream — viewers watch the workflow and chat
- Education / workshops — instructor's screen mirrored for students
- Personal monitoring — get pinged when an agent gets stuck

More: [Wildeconforce LIVE project](https://wildeconforce.com/projects/wef-live).
