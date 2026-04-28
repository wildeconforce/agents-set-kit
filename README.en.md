# Agents Set Kit

> **One Korean-first guide to set up 5 AI tools at once.**
> Claude Code · OpenClaw · Ollama · OpenRouter · Telegram bot — end to end.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/status-active-brightgreen.svg)]()
[![Korean](https://img.shields.io/badge/lang-한국어-lightgrey.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-blue.svg)](README.en.md)

🇰🇷 [한국어](README.md) · 🇺🇸 English (current)

---

## 🎯 What is this

A guided path so even a complete AI newbie can get a **full AI agent stack running on their own laptop** — five tools wired together.

**End state**:
- Talk to AI from your terminal in plain language (Claude Code)
- Multiple free models in one place (Ollama / OpenRouter / OpenClaw)
- Phone-as-remote: send tasks via Telegram from anywhere
- Live dashboard to monitor agent runs

**Audience**:
- AI first-timers — clicks are spelled out
- "I've used Claude.ai but want to go deeper"
- People who want to build custom automations / chatbots

---

## 🆚 How it differs from similar kits

GitHub already has many [Claude Code](https://github.com/davila7/claude-code-templates) [starter](https://github.com/peterkrueck/Claude-Code-Development-Kit) [kits](https://github.com/centminmod/my-claude-code-setup). What this one does differently:

| Aspect | Popular existing kits | **Agents Set Kit** |
|--------|----------------------|--------------------|
| Language | English only | **Korean-first + English alongside** |
| Scope | Claude Code only | **Claude Code + OpenClaw + Ollama + OpenRouter + Telegram, integrated** |
| Cost assumption | Claude Pro $20/mo | **Free tiers + free models + local = $0/mo possible** |
| Audience | Developers / CC subscribers | **First-time AI users (click-by-click)** |
| Format | Configs / plugins library | **Step-by-step setup guides (01 → 08)** |

In short: nothing existed that was Korean-first, free-first, beginner-first, and wired five tools together. So we built it.

---

## 🚀 Quick start (5 min)

### Prerequisites
- A laptop (Windows / Mac / Linux)
- Internet
- An email address (for signups)
- (Optional) A phone (for Telegram bot)

### Get Claude Code working in 5 minutes

```bash
# 1. Install Node.js (LTS from https://nodejs.org)

# 2. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 3. Verify
claude --version

# 4. First run (browser auth opens automatically)
claude

# 5. Inside Claude Code:
Hello! Please respond in English.
```

Working? → Read [docs/en/03-claude-code.md](docs/en/03-claude-code.md) for depth.

---

## 📚 Step-by-step guides

Follow in order. 10–30 min each.

| Step | Topic | Time | Required |
|------|-------|------|----------|
| [01](docs/en/01-ai-services-signup.md) | AI services signup (Claude / ChatGPT / Gemini) | 15 min | Required |
| [02](docs/en/02-nodejs-install.md) | Install Node.js | 5 min | Required |
| [03](docs/en/03-claude-code.md) | Claude Code install + first command | 15 min | Required |
| [04](docs/en/04-openclaw.md) | OpenClaw — multi-model setup | 30 min | Recommended |
| [05](docs/en/05-openrouter-free.md) | OpenRouter free models | 20 min | Recommended |
| [06](docs/en/06-ollama-local.md) | Ollama — local models | 30 min | Optional |
| [07](docs/en/07-telegram-bot.md) | Telegram bot integration | 30 min | Recommended |
| [08](docs/en/08-agents-hq-dashboard.md) | Live dashboard | 30 min | Optional |
| [00](docs/en/troubleshooting.md) | Troubleshooting | — | Reference |

---

## 🛠️ Auto-install script

### Windows (PowerShell)
```powershell
# Open PowerShell as Administrator, then:
iwr -useb https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-windows.ps1 | iex
```

### Mac / Linux
```bash
curl -sSL https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-mac.sh | bash
```

The script:
- Checks Node.js (guides install if missing)
- Installs Claude Code
- Installs OpenClaw (optional)
- Verifies each step

After install:
```bash
# Verify
bash scripts/verify.sh    # Mac
.\scripts\verify.ps1      # Windows
```

---

## 💡 How it fits together

```
[You]
  ├─ Browser → Claude.ai / ChatGPT / Gemini  (light usage)
  ├─ Terminal → Claude Code  (main workspace)
  │              ├─ Direct file / code access
  │              ├─ Automation workflows
  │              └─ Telegram plugin → command from your phone
  └─ Terminal → OpenClaw  (free-model backup)
                ├─ OpenRouter (remote free)
                └─ Ollama (local free)
```

---

## 🤔 FAQ

**Q: Will this cost money?**
A: $0 to start. Claude / ChatGPT / Gemini free tiers + OpenRouter free models + local Ollama = $0/month.

**Q: Mac and Windows both?**
A: Yes. Commands are nearly identical; guides cover both.

**Q: Do I need to know English?**
A: No. Claude responds in Korean fluently; the guides are Korean-first.

**Q: I get stuck during install — now what?**
A: Check [docs/en/troubleshooting.md](docs/en/troubleshooting.md) first. If still stuck, file an [issue](https://github.com/wildeconforce/agents-set-kit/issues).

**Q: Will this work on a corporate laptop?**
A: Depends on permissions. If `npm install -g` is blocked, you'll need IT's help.

**Q: Can I combine this with awesome-claude-code / claude-code-templates / etc.?**
A: Yes. Use this kit to *get the environment set up*, then layer their agents / skills / commands on top. No conflicts.

---

## 🧰 Origin

Built by the operator of [wildeconforce.com](https://wildeconforce.com) — a collection of traps, workarounds, and setup patterns gathered over 5 months of building AI agent stacks.

**Related writeups**:
- [7 traps in agent setup, and how to escape them](https://wildeconforce.com/posts/2026-04-27-agent-setup-7-traps)
- [Telegram two-way recovery diary](https://wildeconforce.com/posts/2026-04-28-telegram-recovery)
- [V4.2 → V4.3.1 backtest log](https://wildeconforce.com/posts/2026-04-27-v42-v431-grid-search-overfit)

---

## 📜 License

MIT — fork / modify / redistribute freely.

Contributions welcome — Pull Requests, Issues, or [@wildeconforce](https://x.com/wildeconforce) DM.

---

## ⭐ If this helped

Please star the repo so others can find it.

Share what you build with [#agents_set_kit](https://x.com/hashtag/agents_set_kit) — happy to RT.
