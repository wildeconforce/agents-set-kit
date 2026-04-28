# 03 — Install Claude Code

> **Goal**: command Claude in plain English from your terminal.
> **Time**: 15 min.

[Claude Code](https://docs.anthropic.com/claude-code) is Anthropic's official CLI — the super-powered version of browser Claude that can touch files, run code, and execute commands directly.

---

## ✅ Install

### One line
```bash
npm install -g @anthropic-ai/claude-code
```

### Permission errors

**Mac**:
```bash
sudo npm install -g @anthropic-ai/claude-code
```

**Windows**: re-open PowerShell as **Administrator** and try again

### Verify
```bash
claude --version
```
→ Output like `Claude Code 1.x.x`

---

## ✅ First run + login

```bash
claude
```

1. A browser opens automatically (Anthropic login page)
2. Sign up / log in
3. Click "Authorize Claude Code"
4. Browser → "Authentication successful"
5. Back in the terminal → logged in, prompt waiting

### Browser doesn't open?
Copy the URL printed in the terminal and paste it into your browser manually.

---

## ✅ First commands

Inside Claude Code, just talk naturally:

```
Hi! Please respond in English.
```

If you get a response, it works.

### Harder commands

**Analyze the current folder**:
```
Tell me what files are in this folder.
```
→ Claude runs `ls`-style commands and reports back.

**Summarize a file**:
```
Read README.md and tell me 3 key points.
```

**Write code**:
```
Make hello.py that prints "Hello, world!"
Then run it.
```
→ Claude creates the file + runs python + shows the result.

---

## 🎓 Core usage

### 1. Plain language
English / Korean / both work. Write the *intent*, not the exact command.

```
Tidy up yesterday's notes and turn them into a blog post.
```

### 2. File / folder context
Claude treats your current directory as default context. To work elsewhere:
```
/cd C:\Users\you\my-project
```
Or use absolute paths:
```
Analyze C:\Users\you\my-project\app.py
```

### 3. Slash commands
```
/help        # help
/cd <path>   # change working directory
/clear       # clear conversation
/resume      # continue previous session
/exit        # quit
```

### 4. Risky commands ask for permission
File deletes / system commands prompt every time. Don't blindly approve — read the command and confirm.

---

## 💡 Use cases — one a day for the first week

| Day | Try |
|-----|-----|
| 1 | "Tidy up this folder" — get a file inventory |
| 2 | One of your own writeups → "polish the awkward sentences" |
| 3 | "Write a short retrospective of today" → text journal |
| 4 | One-line Python — "show me the weather right now" |
| 5 | "Rewrite my GitHub profile README" |

Start small. It becomes part of your workflow.

---

## 🚧 Troubleshooting

### Responses come in English only
Add `Please respond in Korean` to the end of your prompt.
Or set it once at the start:
```
From now on, always respond in Korean.
```

### Responses too long
```
Be brief.
```
Or:
```
One sentence.
```

### Hit usage limit
- Free tier has hourly / daily limits
- Wait until the next hour / next day
- Or pay for Claude Pro ($20/mo)

### `claude` not recognized after install
- Open a new terminal window
- Run `npm root -g` and confirm that path is in your system PATH

---

## ✅ You've made it this far

Congrats. You already have an AI agent starting point. 90% of users only need this much.

Going deeper:
- [04-openclaw.md](04-openclaw.md) — multiple free models (cost savings)
- [07-telegram-bot.md](07-telegram-bot.md) — command from your phone (automation)
- [08-agents-hq-dashboard.md](08-agents-hq-dashboard.md) — live dashboard (monitoring)
