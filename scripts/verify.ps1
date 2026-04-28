# Agents Set Kit — 작동 확인 스크립트 (Windows)

Write-Host ""
Write-Host "🔍 Agents Set Kit — 작동 확인" -ForegroundColor Cyan
Write-Host ""

# ─── Node.js ─────────────────────────────────────────────────────
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host "✅ Node.js:    $(node --version)"
} else {
    Write-Host "❌ Node.js:    미설치" -ForegroundColor Red
}

# ─── npm ─────────────────────────────────────────────────────────
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "✅ npm:        $(npm --version)"
} else {
    Write-Host "❌ npm:        미설치" -ForegroundColor Red
}

# ─── Claude Code ─────────────────────────────────────────────────
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "✅ Claude Code: $(claude --version 2>$null)"
} else {
    Write-Host "❌ Claude Code: 미설치 (npm install -g @anthropic-ai/claude-code)" -ForegroundColor Red
}

# ─── OpenClaw (선택) ─────────────────────────────────────────────
if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    Write-Host "✅ OpenClaw:   $(openclaw --version 2>$null)"
} else {
    Write-Host "⚪ OpenClaw:   미설치 (선택, npm install -g openclaw)"
}

# ─── Ollama (선택) ───────────────────────────────────────────────
if (Get-Command ollama -ErrorAction SilentlyContinue) {
    Write-Host "✅ Ollama:     $(ollama --version 2>$null | Select-Object -First 1)"
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:11434/api/version" -TimeoutSec 2 -UseBasicParsing 2>$null
        Write-Host "✅ Ollama 데몬: 돌고 있음"
    } catch {
        Write-Host "⚠️  Ollama 데몬: 안 돌고 있음 (Ollama 트레이 앱 실행)" -ForegroundColor Yellow
    }
} else {
    Write-Host "⚪ Ollama:     미설치 (선택)"
}

# ─── Telegram bot 토큰 (선택) ────────────────────────────────────
$telegramEnv = "$env:USERPROFILE\.claude\channels\telegram\.env"
if (Test-Path $telegramEnv) {
    $content = Get-Content $telegramEnv -Raw
    if ($content -match "TELEGRAM_BOT_TOKEN") {
        Write-Host "✅ Telegram 봇: 토큰 등록됨"
    } else {
        Write-Host "⚪ Telegram 봇: 토큰 미등록"
    }
} else {
    Write-Host "⚪ Telegram 봇: 미등록 (선택)"
}

Write-Host ""
Write-Host "📚 다음 단계 → docs/03-claude-code.md" -ForegroundColor Yellow
