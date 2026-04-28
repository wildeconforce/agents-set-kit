#!/usr/bin/env bash
# Agents Set Kit — 작동 확인 스크립트 (Mac/Linux)

echo ""
echo "🔍 Agents Set Kit — 작동 확인"
echo ""

OK="✅"
FAIL="❌"

# ─── Node.js ─────────────────────────────────────────────────────
if command -v node &> /dev/null; then
    echo "$OK Node.js:    $(node --version)"
else
    echo "$FAIL Node.js:    미설치"
fi

# ─── npm ─────────────────────────────────────────────────────────
if command -v npm &> /dev/null; then
    echo "$OK npm:        $(npm --version)"
else
    echo "$FAIL npm:        미설치"
fi

# ─── Claude Code ─────────────────────────────────────────────────
if command -v claude &> /dev/null; then
    echo "$OK Claude Code: $(claude --version 2>/dev/null || echo '실행 가능 (버전 확인 안 됨)')"
else
    echo "$FAIL Claude Code: 미설치 (npm install -g @anthropic-ai/claude-code)"
fi

# ─── OpenClaw (선택) ─────────────────────────────────────────────
if command -v openclaw &> /dev/null; then
    echo "$OK OpenClaw:   $(openclaw --version 2>/dev/null)"
else
    echo "⚪ OpenClaw:   미설치 (선택, npm install -g openclaw)"
fi

# ─── Ollama (선택) ───────────────────────────────────────────────
if command -v ollama &> /dev/null; then
    echo "$OK Ollama:     $(ollama --version 2>/dev/null | head -1)"
    # Ollama 데몬 확인
    if curl -sf http://localhost:11434/api/version > /dev/null 2>&1; then
        echo "$OK Ollama 데몬: 돌고 있음"
    else
        echo "⚠️  Ollama 데몬: 안 돌고 있음 (ollama serve)"
    fi
else
    echo "⚪ Ollama:     미설치 (선택)"
fi

# ─── Telegram bot 토큰 (선택) ────────────────────────────────────
TELEGRAM_ENV="$HOME/.claude/channels/telegram/.env"
if [ -f "$TELEGRAM_ENV" ] && grep -q "TELEGRAM_BOT_TOKEN" "$TELEGRAM_ENV"; then
    echo "$OK Telegram 봇: 토큰 등록됨"
else
    echo "⚪ Telegram 봇: 미등록 (선택)"
fi

echo ""
echo "📚 다음 단계 → docs/03-claude-code.md"
