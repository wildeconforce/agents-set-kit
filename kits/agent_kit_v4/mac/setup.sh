#!/usr/bin/env bash
# =====================================================================
# Vericum Agent Kit v4.0 (macOS) — 한국어 OpenClaw + Gemini + Telegram
# 대상: 강의 수강생 (클린 Mac, Intel + Apple Silicon 모두 지원)
# 모델: Gemini 3.1 Pro Preview (무료, Google AI Studio)
# 채널: Telegram (모드 B) 또는 TUI 만 (모드 A, Telegram 추후)
# 베이스: openclaw 공식 install.sh (curl pipe to bash)
#
# v4 변경점 (v3.0.1 대비):
#   - 모드 선택 (A=단계별 / B=원클릭) 분기
#   - 모드 A: provider 셋업 → TUI 동작 확인 → Telegram 선택사항
#   - 모드 B: 현 v3.0.1 흐름 (provider+channel 한 번에)
#
# v3.0.1 hardening (유지):
#   - PATH: Homebrew Apple Silicon (/opt/homebrew) + Intel (/usr/local)
#   - install.sh 실행 로그 캡처 ($HOME/openclaw_install.log)
#   - Homebrew 첫 설치 시 sudo 비밀번호 prompt 사전 안내
#   - 로케일 fallback (ko_KR.UTF-8 미지원 → en_US.UTF-8)
#   - 아키텍처 감지 + 로그
#   - hash -r 로 셸 명령 캐시 갱신
#   - openclaw 명령 절대경로 fallback
# =====================================================================

set -u

# === 로케일 fallback ===
if locale -a 2>/dev/null | grep -qi "ko_KR.UTF-8"; then
    export LANG="ko_KR.UTF-8"
    export LC_ALL="ko_KR.UTF-8"
else
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

# === 색상 ===
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
GRAY='\033[0;90m'
NC='\033[0m'

ok()    { echo -e "  ${GREEN}[완료]${NC} $1"; }
info()  { echo -e "  ${CYAN}[진행]${NC} $1"; }
warn()  { echo -e "  ${YELLOW}[주의]${NC} $1"; }
err()   { echo -e "  ${RED}[오류]${NC} $1"; }
step()  { echo -e "\n  ${MAGENTA}===== $1 =====${NC}"; }

fail() {
    err "$1"
    echo ""
    echo "  설치 로그: $LOG_FILE"
    echo "  강사한테 위 화면 + 로그 파일을 캡처해 보내주세요."
    echo ""
    read -p "  Enter 키를 눌러 종료"
    exit 1
}

# === 로그 파일 ===
LOG_FILE="$HOME/openclaw_install.log"
echo "=== Vericum Agent 설치 로그 시작: $(date) ===" > "$LOG_FILE"
exec 3>&1 4>&2  # 원본 stdout/stderr 백업

# === 에러 트랩 ===
trap 'echo ""; err "예기치 못한 오류로 스크립트가 중단되었습니다."; echo "  로그: $LOG_FILE"; echo "  강사한테 위 화면 + 로그 파일 캡처해 보내주세요."; read -p "  Enter 키를 눌러 종료"; exit 1' ERR

# === 헤더 ===
clear
echo ""
echo -e "  ${CYAN}================================================${NC}"
echo -e "  ${CYAN}  Vericum Agent Kit v4.0 (macOS)${NC}"
echo -e "  ${GRAY}  Gemini 3.1 Pro Preview + Telegram${NC}"
echo -e "  ${CYAN}================================================${NC}"
echo ""
echo -e "  ${YELLOW}미리 준비할 것 (강사가 함께 발급해드립니다):${NC}"
echo "    - Google 계정 (Gemini API 키 발급용)"
echo "    - Telegram 계정 (봇 만들기용, 모드 B 에서만 필요)"
echo ""

# === 모드 선택 (v4 신규) ===
echo -e "  ${YELLOW}진행 방식을 선택해주세요:${NC}"
echo ""
echo -e "  ${CYAN}[B] 빠르게 (원클릭)${NC} — 한 번에 Telegram 까지"
echo -e "      ${GRAY}- 약 10~15분, AI 가 폰 텔레그램에서 답함${NC}"
echo -e "      ${GRAY}- 강의 / 입문자 추천${NC}"
echo ""
echo -e "  ${CYAN}[A] 단계별${NC} — TUI 먼저 동작 확인 → Telegram 은 나중에"
echo -e "      ${GRAY}- 약 15~25분, OpenClaw 자체를 먼저 익힘${NC}"
echo -e "      ${GRAY}- 학습 / 디버깅 / Telegram 안 쓸 사용자 추천${NC}"
echo ""
MODE=""
while [ "$MODE" != "A" ] && [ "$MODE" != "B" ]; do
    read -p "  선택 (A/B) [기본 B]: " MODE
    MODE=$(echo "$MODE" | tr '[:lower:]' '[:upper:]' | tr -d '[:space:]')
    if [ -z "$MODE" ]; then MODE="B"; fi
done
echo ""
if [ "$MODE" = "B" ]; then
    ok "모드 B 선택 — 한 번에 Telegram 까지"
else
    ok "모드 A 선택 — TUI 먼저, Telegram 은 선택사항"
fi
echo "MODE=$MODE" >> "$LOG_FILE"
echo ""

# === 진행 순서 ===
echo -e "  ${YELLOW}진행 순서:${NC}"
echo "    1. Mac 환경 확인 (아키텍처/로케일/기존 설치)"
echo "    2. OpenClaw 설치 (공식 install.sh)"
if [ "$MODE" = "B" ]; then
    echo "    3. 마법사 (onboard) 로 Gemini + Telegram 셋팅"
    echo "    4. 봇 페어링"
    echo "    5. 동작 확인 (텔레그램 봇)"
else
    echo "    3. 마법사 (onboard) 로 Gemini 셋팅 (Channel 단계는 SKIP)"
    echo "    4. TUI 에서 동작 확인"
    echo "    5. (선택) Telegram 추가 안내"
fi
echo ""
echo -e "  ${GRAY}  로그 파일: $LOG_FILE${NC}"
echo ""
read -p "  준비됐으면 Enter 키"

# === STEP 1: Mac 환경 확인 ===
step "STEP 1/5  Mac 환경 확인"

# macOS 버전
MACOS_VER=$(sw_vers -productVersion 2>/dev/null || echo "0")
ok "macOS $MACOS_VER"

# 아키텍처 (Apple Silicon vs Intel)
ARCH=$(uname -m 2>/dev/null || echo "unknown")
case "$ARCH" in
    arm64)
        ARCH_LABEL="Apple Silicon (M1/M2/M3/M4)"
        BREW_PREFIX="/opt/homebrew"
        ;;
    x86_64)
        ARCH_LABEL="Intel"
        BREW_PREFIX="/usr/local"
        ;;
    *)
        ARCH_LABEL="$ARCH (unknown)"
        BREW_PREFIX="/usr/local"
        ;;
esac
ok "$ARCH_LABEL ($ARCH)"
echo "ARCH=$ARCH BREW_PREFIX=$BREW_PREFIX" >> "$LOG_FILE"

# 로케일 표시
ok "LANG=$LANG"

# 기존 OpenClaw 충돌 감지
EXISTING_CONFIG="$HOME/.openclaw/openclaw.json"
if [ -f "$EXISTING_CONFIG" ]; then
    warn "기존 OpenClaw 설정이 감지되었습니다."
    echo "  경로: $EXISTING_CONFIG"
    echo ""
    echo -e "  ${YELLOW}계속 진행하시면 기존 설정이 자동 백업됩니다.${NC}"
    read -p "  Enter 로 진행, Ctrl+C 로 중단: "
    TS=$(date +%Y%m%d-%H%M%S)
    cp "$EXISTING_CONFIG" "$EXISTING_CONFIG.bak-$TS"
    ok "기존 설정 백업 완료: $EXISTING_CONFIG.bak-$TS"
else
    ok "기존 OpenClaw 설치 없음 (클린 환경)"
fi

# === STEP 2: OpenClaw 설치 (공식 install.sh) ===
step "STEP 2/5  OpenClaw 설치 (공식 install.sh)"

# Homebrew 사전 체크 + 안내
if ! command -v brew &> /dev/null; then
    warn "Homebrew 가 설치되어 있지 않습니다."
    echo ""
    echo -e "  ${YELLOW}install.sh 가 자동으로 Homebrew + Node.js 를 설치합니다.${NC}"
    echo -e "  ${YELLOW}이때 macOS 비밀번호 입력을 요구할 수 있습니다.${NC}"
    echo ""
    echo "  - Mac 로그인 비밀번호 입력 (입력해도 화면엔 표시 안 됨)"
    echo "  - 첫 Homebrew 설치는 5~10분 소요"
    echo ""
    read -p "  준비됐으면 Enter (또는 Ctrl+C 로 중단)"
fi

info "OpenClaw 공식 인스톨러 실행 중..."
echo "  명령: curl -fsSL https://openclaw.ai/install.sh | bash"
echo "  로그: $LOG_FILE 에 실시간 기록"
echo ""

# install.sh 실행 + 로그 캡처 (tee 로 화면 + 로그 동시)
if ! curl -fsSL https://openclaw.ai/install.sh 2>>"$LOG_FILE" | bash 2>&1 | tee -a "$LOG_FILE"; then
    err "공식 인스톨러 실행 실패."
    echo ""
    echo -e "  ${YELLOW}대체 방법 (수동):${NC}"
    echo "    1. Homebrew 설치 (없을 시):"
    echo '       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    echo "    2. Node.js 설치:"
    echo "       brew install node@22"
    echo "    3. OpenClaw 설치:"
    echo "       npm install -g openclaw@latest"
    echo "    4. 이 스크립트 다시 실행"
    fail "설치 실패."
fi

# PATH 강제 갱신 (Homebrew Apple Silicon + Intel + npm prefix)
ADDED_PATHS=""
for p in "/opt/homebrew/bin" "/usr/local/bin" "$HOME/.npm-global/bin" "$HOME/.npm/global/bin"; do
    if [ -d "$p" ] && [[ ":$PATH:" != *":$p:"* ]]; then
        export PATH="$p:$PATH"
        ADDED_PATHS="$ADDED_PATHS $p"
    fi
done

# npm prefix 가 별도면 추가
if command -v npm &> /dev/null; then
    NPM_PREFIX=$(npm prefix -g 2>/dev/null || echo "")
    if [ -n "$NPM_PREFIX" ] && [ -d "$NPM_PREFIX/bin" ] && [[ ":$PATH:" != *":$NPM_PREFIX/bin:"* ]]; then
        export PATH="$NPM_PREFIX/bin:$PATH"
        ADDED_PATHS="$ADDED_PATHS $NPM_PREFIX/bin"
    fi
fi

# 셸 명령 캐시 비우기 (이전에 없던 명령 새로 인식)
hash -r 2>/dev/null || true

[ -n "$ADDED_PATHS" ] && echo "PATH 추가:$ADDED_PATHS" >> "$LOG_FILE"

# openclaw 명령 가능한지 검증 (절대경로 fallback 포함)
OPENCLAW_BIN=""
if command -v openclaw &> /dev/null; then
    OPENCLAW_BIN="$(command -v openclaw)"
else
    # 절대경로 후보 검색
    for cand in "/opt/homebrew/bin/openclaw" "/usr/local/bin/openclaw" "$HOME/.npm-global/bin/openclaw" "$HOME/.npm/global/bin/openclaw"; do
        if [ -x "$cand" ]; then
            OPENCLAW_BIN="$cand"
            export PATH="$(dirname "$cand"):$PATH"
            break
        fi
    done
fi

if [ -z "$OPENCLAW_BIN" ]; then
    err "openclaw 명령을 찾을 수 없습니다."
    echo ""
    echo "  Terminal 을 완전히 종료한 후 새로 띄우고, .command 파일을 다시 더블클릭하세요."
    echo "  또는 다음 한 줄을 실행한 후 재실행:"
    echo "    source ~/.zshrc"
    echo ""
    fail "PATH 갱신 필요."
fi

OC_VER=$("$OPENCLAW_BIN" --version 2>&1 | head -1 || echo "unknown")
ok "OpenClaw $OC_VER 설치 완료 ($OPENCLAW_BIN)"
echo "OPENCLAW_BIN=$OPENCLAW_BIN OC_VER=$OC_VER" >> "$LOG_FILE"

# === STEP 3: Onboard (대화형 마법사) ===
step "STEP 3/5  마법사 셋팅 (onboard)"

echo ""
echo -e "  ${CYAN}지금부터 OpenClaw 의 onboard 마법사가 시작됩니다.${NC}"
echo -e "  ${CYAN}각 질문에 다음과 같이 응답하세요:${NC}"
echo ""
echo -e "  ${YELLOW}[Provider 선택]${NC}"
echo "    → Google (Gemini)"
echo "    → API 키: AI Studio 에서 발급 (https://aistudio.google.com)"
echo "      Google 로그인 → Get API key → Create API key → 복사"
echo "    → 모델: gemini-3.1-pro-preview"
echo ""
if [ "$MODE" = "B" ]; then
    echo -e "  ${YELLOW}[Channel 선택] [모드 B: 진행]${NC}"
    echo "    → Telegram"
    echo "    → 봇 토큰: BotFather 에서 발급"
    echo "      Telegram 에서 @BotFather → /newbot → 봇 이름 → username (끝 _bot) → 토큰 복사"
else
    echo -e "  ${YELLOW}[Channel 선택] [모드 A: SKIP]${NC}"
    echo "    → 'Skip' / '나중에' / 'No channel' 선택 (또는 Channel 단계에서 그냥 Enter)"
    echo "    → 만약 토큰 입력 강제되면 가짜 토큰 (예: '0:0') 입력 → 에러 무시"
    echo "    → Telegram 은 STEP 5 에서 별도 추가 (선택사항)"
fi
echo ""
echo -e "  ${YELLOW}[Gateway]${NC}"
echo "    → Mode: local"
echo "    → Port: 18789 (기본값)"
echo ""
read -p "  준비됐으면 Enter 키"

"$OPENCLAW_BIN" onboard

# === STEP 4 (모드별): 동작 확인 ===
if [ "$MODE" = "B" ]; then
    step "STEP 4/5  봇 페어링 확인"

    echo ""
    echo -e "  ${YELLOW}Telegram 본인 봇한테 /start 명령을 보냈나요?${NC}"
    echo "  봇이 8자리 페어링 코드를 답장했어야 합니다."
    echo ""
    echo "  - 코드를 받으셨으면: 터미널에서"
    echo "      openclaw pairing approve telegram <코드>"
    echo "    또는 onboard 마법사가 페어링까지 처리했다면 스킵"
    echo ""
    read -p "  페어링 완료되면 Enter"

    # === STEP 5 (모드 B): 동작 확인 ===
    step "STEP 5/5  최종 동작 확인 (Telegram 봇)"

    echo ""
    echo -e "  ${CYAN}Telegram 봇한테 다음 메시지를 보내보세요:${NC}"
    echo "    안녕! 한국어로 자기소개 해줘"
    echo ""
    echo -e "  ${GREEN}Gemini 가 한국어로 답하면 = 설치 성공!${NC}"
    echo ""
    read -p "  답이 왔으면 Enter, 안 왔으면 Ctrl+C 후 강사한테 화면 + 로그 캡처 전송"
else
    # === STEP 4 (모드 A): TUI 동작 확인 ===
    step "STEP 4/5  TUI 동작 확인"

    echo ""
    echo -e "  ${CYAN}터미널에서 OpenClaw 챗을 직접 시작합니다:${NC}"
    echo "    $ openclaw chat"
    echo ""
    echo -e "  ${CYAN}대화창이 뜨면 다음 메시지를 입력해보세요:${NC}"
    echo "    안녕! 한국어로 자기소개 해줘"
    echo ""
    echo -e "  ${GREEN}Gemini 가 한국어로 답하면 = OpenClaw + Gemini 셋업 성공!${NC}"
    echo ""
    echo -e "  ${GRAY}  (챗 빠져나오기: 'exit' 또는 Ctrl+D)${NC}"
    echo ""
    read -p "  TUI 챗 동작 확인 후 Enter (또는 안 되면 Ctrl+C 후 강사한테)"

    # === STEP 5 (모드 A): Telegram 추가 (선택사항) ===
    step "STEP 5/5  Telegram 추가 (선택사항)"

    echo ""
    echo -e "  ${YELLOW}Telegram 봇 연동을 추가할까요?${NC}"
    echo -e "  ${CYAN}[Y]${NC} 네, 지금 추가"
    echo -e "  ${CYAN}[N]${NC} 아니요, TUI 만 사용 (나중에 추가 가능)"
    echo ""
    read -p "  선택 (Y/N) [기본 N]: " ADD_TG
    ADD_TG=$(echo "$ADD_TG" | tr '[:lower:]' '[:upper:]' | tr -d '[:space:]')
    if [ "$ADD_TG" = "Y" ]; then
        echo ""
        echo -e "  ${YELLOW}[Telegram 추가 절차]${NC}"
        echo "    1. Telegram 에서 @BotFather → /newbot → 봇 토큰 복사"
        echo "    2. 터미널:"
        echo "         openclaw channels add --channel telegram --token <토큰>"
        echo "    3. 봇한테 /start → 8자리 페어링 코드 받음"
        echo "    4. 터미널:"
        echo "         openclaw pairing approve telegram <코드>"
        echo "    5. 봇한테 메시지 보내서 답 오는지 확인"
        echo ""
        read -p "  Telegram 추가 완료되면 Enter (또는 그만하려면 Ctrl+C)"
    else
        ok "TUI 모드 유지 — 나중에 Telegram 추가 가능"
    fi
fi

# === 마무리 ===
echo ""
echo -e "  ${GREEN}================================================${NC}"
echo -e "  ${GREEN}  축하합니다! 에이전트가 살아났습니다.${NC}"
echo -e "  ${GREEN}================================================${NC}"
echo ""
echo -e "  ${CYAN}사용법:${NC}"
if [ "$MODE" = "B" ]; then
    echo "    - Telegram 봇한테 채팅 = 일반 대화"
    echo "    - 봇 명령어: /start, /help, /status"
else
    echo "    - 터미널에서 'openclaw chat' = TUI 챗"
fi
echo "    - 게이트웨이 상태 확인: openclaw gateway status"
echo "    - 종합 진단: openclaw doctor"
echo ""
echo -e "  ${YELLOW}[에이전트 권한 (파일 읽기/쓰기/자동화) 활성화는 별도 단계]${NC}"
echo "    강사한테 'agentify 진행해주세요' 라고 요청하시면"
echo "    파일 읽기/쓰기/터미널 명령 실행 권한을 추가로 부여드립니다."
echo ""
echo -e "  ${CYAN}Q&A 는 강의 단톡방에 올려주세요.${NC}"
echo -e "  ${GRAY}  설치 로그: $LOG_FILE${NC}"
echo ""
read -p "  Enter 키를 눌러 종료"
