# Agents Set Kit — Windows 자동 설치
#
# 사용 (PowerShell 관리자 권한):
#   iwr -useb https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-windows.ps1 | iex
#
# 또는 다운로드 후:
#   .\install-windows.ps1

Write-Host ""
Write-Host "🚀 Agents Set Kit — 자동 설치 시작" -ForegroundColor Cyan
Write-Host "   Windows 환경" -ForegroundColor Cyan
Write-Host ""

# ─── 관리자 권한 체크 ────────────────────────────────────────────
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "⚠️  관리자 권한이 필요합니다." -ForegroundColor Yellow
    Write-Host "    PowerShell을 우클릭 → '관리자 권한으로 실행' 후 다시 시도하세요." -ForegroundColor Yellow
    exit 1
}

# ─── 1. Node.js 확인 ──────────────────────────────────────────────
Write-Host "1️⃣  Node.js 확인..." -ForegroundColor Green
$nodeVer = & node --version 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ Node.js 설치됨: $nodeVer"
} else {
    Write-Host "   ✗ Node.js 미설치" -ForegroundColor Red
    Write-Host "   👉 https://nodejs.org/ko 에서 LTS 버전 다운로드 후 다시 실행" -ForegroundColor Yellow
    Write-Host "   또는: winget install OpenJS.NodeJS.LTS" -ForegroundColor Yellow
    exit 1
}

# ─── 2. Claude Code 설치 ────────────────────────────────────────
Write-Host ""
Write-Host "2️⃣  Claude Code 설치..." -ForegroundColor Green
$claudeExists = $null -ne (Get-Command claude -ErrorAction SilentlyContinue)
if ($claudeExists) {
    Write-Host "   ✓ 이미 설치됨"
} else {
    Write-Host "   설치 중..."
    npm install -g "@anthropic-ai/claude-code"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ 설치 완료"
    } else {
        Write-Host "   ✗ 설치 실패" -ForegroundColor Red
        exit 1
    }
}

# ─── 3. OpenClaw 설치 (선택) ────────────────────────────────────
Write-Host ""
Write-Host "3️⃣  OpenClaw 설치 (멀티모델, 선택 사항)" -ForegroundColor Green
$installOC = Read-Host "    설치할까요? (y/n)"
if ($installOC -eq "y" -or $installOC -eq "Y") {
    $ocExists = $null -ne (Get-Command openclaw -ErrorAction SilentlyContinue)
    if ($ocExists) {
        Write-Host "   ✓ 이미 설치됨"
    } else {
        Write-Host "   설치 중..."
        npm install -g openclaw
        Write-Host "   ✓ 설치 완료"
    }
}

# ─── 4. Ollama 설치 (선택) ──────────────────────────────────────
Write-Host ""
Write-Host "4️⃣  Ollama 설치 (로컬 모델, 선택 사항)" -ForegroundColor Green
$installOlla = Read-Host "    설치할까요? (y/n)"
if ($installOlla -eq "y" -or $installOlla -eq "Y") {
    $ollExists = $null -ne (Get-Command ollama -ErrorAction SilentlyContinue)
    if ($ollExists) {
        Write-Host "   ✓ 이미 설치됨"
    } else {
        Write-Host "   winget으로 설치 중..."
        winget install Ollama.Ollama --silent --accept-source-agreements --accept-package-agreements
        Write-Host "   ✓ 설치 완료"
        Write-Host ""
        Write-Host "   📦 추천 모델 다운로드 (Qwen 2.5 7B, ~5GB)" -ForegroundColor Yellow
        $pullModel = Read-Host "   다운로드할까요? (y/n)"
        if ($pullModel -eq "y" -or $pullModel -eq "Y") {
            & "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe" pull qwen2.5:7b
            Write-Host "   ✓ qwen2.5:7b 다운 완료"
        }
    }
}

# ─── 5. 작동 확인 ────────────────────────────────────────────────
Write-Host ""
Write-Host "5️⃣  작동 확인..." -ForegroundColor Green
Write-Host ""
Write-Host "   Node.js:    $(node --version)"
Write-Host "   npm:        $(npm --version)"
$claudeV = (claude --version 2>$null)
Write-Host "   Claude Code: $claudeV"
if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    Write-Host "   OpenClaw:   $(openclaw --version 2>$null)"
}
if (Get-Command ollama -ErrorAction SilentlyContinue) {
    Write-Host "   Ollama:     $(ollama --version 2>$null | Select-Object -First 1)"
}

Write-Host ""
Write-Host "✅ 설치 완료!" -ForegroundColor Cyan
Write-Host ""
Write-Host "다음 단계:" -ForegroundColor Yellow
Write-Host "  1. claude    # Claude Code 첫 실행 (브라우저 로그인)"
Write-Host "  2. docs/03-claude-code.md 문서 참조"
Write-Host ""
Write-Host "막히면:" -ForegroundColor Yellow
Write-Host "  - docs/troubleshooting.md"
Write-Host "  - https://github.com/wildeconforce/agents-set-kit/issues"
Write-Host ""
