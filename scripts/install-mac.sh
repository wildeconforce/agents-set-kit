#!/usr/bin/env bash
# Agents Set Kit — Mac/Linux 자동 설치
#
# 사용:
#   curl -sSL https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-mac.sh | bash
#
# 또는 다운로드 후:
#   bash install-mac.sh

set -e

echo "🚀 Agents Set Kit — 자동 설치 시작"
echo "    Mac / Linux 환경"
echo ""

# ─── 1. Node.js 확인 ──────────────────────────────────────────────
echo "1️⃣  Node.js 확인..."
if command -v node &> /dev/null; then
    NODE_VER=$(node --version)
    echo "   ✓ Node.js 설치됨: $NODE_VER"
else
    echo "   ✗ Node.js 미설치"
    echo "   👉 https://nodejs.org/ko 에서 LTS 버전 다운로드 후 다시 실행"
    echo "   또는: brew install node"
    exit 1
fi

# ─── 2. Claude Code 설치 ────────────────────────────────────────
echo ""
echo "2️⃣  Claude Code 설치..."
if command -v claude &> /dev/null; then
    CLAUDE_VER=$(claude --version 2>/dev/null || echo "?")
    echo "   ✓ 이미 설치됨: $CLAUDE_VER"
else
    echo "   설치 중..."
    if npm install -g @anthropic-ai/claude-code 2>&1; then
        echo "   ✓ 설치 완료"
    else
        echo "   ⚠️  권한 오류 — sudo 시도..."
        sudo npm install -g @anthropic-ai/claude-code
    fi
fi

# ─── 3. OpenClaw 설치 (선택) ────────────────────────────────────
echo ""
echo "3️⃣  OpenClaw 설치 (멀티모델, 선택 사항)"
read -p "    설치할까요? (y/n): " INSTALL_OC
if [ "$INSTALL_OC" = "y" ] || [ "$INSTALL_OC" = "Y" ]; then
    if command -v openclaw &> /dev/null; then
        echo "   ✓ 이미 설치됨"
    else
        echo "   설치 중..."
        if npm install -g openclaw 2>&1; then
            echo "   ✓ 설치 완료"
        else
            sudo npm install -g openclaw
        fi
    fi
else
    echo "   건너뜀"
fi

# ─── 4. Ollama 설치 (선택) ──────────────────────────────────────
echo ""
echo "4️⃣  Ollama 설치 (로컬 모델, 선택 사항)"
read -p "    설치할까요? (y/n): " INSTALL_OLL
if [ "$INSTALL_OLL" = "y" ] || [ "$INSTALL_OLL" = "Y" ]; then
    if command -v ollama &> /dev/null; then
        echo "   ✓ 이미 설치됨"
    else
        echo "   설치 중..."
        curl -fsSL https://ollama.com/install.sh | sh
        echo "   ✓ 설치 완료"
        echo ""
        echo "   📦 추천 모델 다운로드 (Qwen 2.5 7B, ~5GB)"
        read -p "   다운로드할까요? (y/n): " PULL_MODEL
        if [ "$PULL_MODEL" = "y" ] || [ "$PULL_MODEL" = "Y" ]; then
            ollama pull qwen2.5:7b
            echo "   ✓ qwen2.5:7b 다운 완료"
        fi
    fi
else
    echo "   건너뜀"
fi

# ─── 5. 작동 확인 ────────────────────────────────────────────────
echo ""
echo "5️⃣  작동 확인..."
echo ""
echo "   Node.js:    $(node --version)"
echo "   npm:        $(npm --version)"
echo "   Claude Code: $(claude --version 2>/dev/null || echo '미설치')"
command -v openclaw &> /dev/null && echo "   OpenClaw:   $(openclaw --version 2>/dev/null)"
command -v ollama &> /dev/null && echo "   Ollama:     $(ollama --version 2>/dev/null | head -1)"

echo ""
echo "✅ 설치 완료!"
echo ""
echo "다음 단계:"
echo "  1. claude    # Claude Code 첫 실행 (브라우저 로그인)"
echo "  2. docs/03-claude-code.md 문서 참조"
echo ""
echo "막히면:"
echo "  - docs/troubleshooting.md"
echo "  - https://github.com/wildeconforce/agents-set-kit/issues"
