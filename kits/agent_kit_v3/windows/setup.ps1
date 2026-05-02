# =====================================================================
# Vericum Agent 원클릭 설치 스크립트 v3.0
# 대상: 강의 수강생 (클린 PC, Windows 10+)
# 모델: Gemini 3.1 Pro Preview (무료, Google AI Studio)
# 채널: Telegram
# 베이스: openclaw-desktop v0.7.0+openclaw.2026.4.2 (공식 .exe)
# =====================================================================

# === 콘솔 인코딩 (한글 출력 깨짐 방지) ===
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding  = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding           = [System.Text.UTF8Encoding]::new($false)
chcp 65001 > $null

# === 헬퍼 ===
function ok    { param($m) Write-Host ("  [완료] " + $m) -ForegroundColor Green }
function info  { param($m) Write-Host ("  [진행] " + $m) -ForegroundColor Cyan }
function warn  { param($m) Write-Host ("  [주의] " + $m) -ForegroundColor Yellow }
function err   { param($m) Write-Host ("  [오류] " + $m) -ForegroundColor Red }
function step  { param($m) Write-Host ("`n  ===== " + $m + " =====") -ForegroundColor Magenta }
function fail  { param($m) err $m; Write-Host ""; Read-Host "  Enter 키를 눌러 종료"; exit 1 }
function done0 { Write-Host ""; Read-Host "  Enter 키를 눌러 종료"; exit 0 }

# === 글로벌 에러 트랩 ===
trap {
    Write-Host ""
    Write-Host "  ============================================================" -ForegroundColor Red
    Write-Host "   예기치 못한 오류로 스크립트가 중단되었습니다." -ForegroundColor Red
    Write-Host "  ============================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  오류 메시지:" -ForegroundColor Yellow
    Write-Host ("    " + $_.Exception.Message) -ForegroundColor Red
    Write-Host ""
    Write-Host "  강사한테 위 화면 캡처해서 보내주세요." -ForegroundColor Cyan
    Write-Host ""
    Read-Host "  Enter 키를 눌러 종료"
    exit 1
}

# === 헤더 ===
Clear-Host
Write-Host ""
Write-Host "  ================================================" -ForegroundColor Cyan
Write-Host "    Vericum Agent 원클릭 설치 v3.0" -ForegroundColor Cyan
Write-Host "    Gemini 3.1 Pro Preview + Telegram" -ForegroundColor Gray
Write-Host "  ================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  진행 순서:" -ForegroundColor Yellow
Write-Host "    1. Windows 환경 확인" -ForegroundColor White
Write-Host "    2. OpenClaw Desktop 설치" -ForegroundColor White
Write-Host "    3. 마법사로 Gemini + Telegram 셋팅 (강사가 옆에서 안내)" -ForegroundColor White
Write-Host "    4. 봇 페어링" -ForegroundColor White
Write-Host "    5. 동작 확인" -ForegroundColor White
Write-Host ""
Write-Host "  미리 준비할 것 (강사가 함께 발급해드립니다):" -ForegroundColor Yellow
Write-Host "    - Google 계정 (Gemini API 키 발급용)" -ForegroundColor White
Write-Host "    - Telegram 계정 (봇 만들기용)" -ForegroundColor White
Write-Host ""
Read-Host "  준비됐으면 Enter 키"

# === STEP 1: Windows ===
step "STEP 1/5  Windows 환경 확인"
$osVer = [System.Environment]::OSVersion.Version
if ($osVer.Major -lt 10) {
    Write-Host "  업그레이드 필요: https://www.microsoft.com/ko-kr/software-download/windows10" -ForegroundColor Yellow
    fail "Windows 10 이상이 필요합니다."
}
ok ("Windows " + $osVer.Major + " 확인")

# 기존 OpenClaw 충돌 감지
$existingConfig = "$env:USERPROFILE\.openclaw\openclaw.json"
if (Test-Path $existingConfig) {
    warn "기존 OpenClaw 설치가 감지되었습니다."
    Write-Host "  경로: $existingConfig" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  기존 설정이 자동으로 백업되고 데스크탑이 마이그레이션할 수 있습니다." -ForegroundColor Yellow
    Write-Host "  계속 진행하시려면 Enter, 중단하시려면 Ctrl+C." -ForegroundColor Yellow
    Read-Host
    $ts  = Get-Date -Format "yyyyMMdd-HHmmss"
    $bak = "$existingConfig.bak-$ts"
    Copy-Item $existingConfig $bak -Force
    ok ("기존 설정 백업 완료: $bak")
}

# === STEP 2: OpenClaw Desktop 설치 ===
step "STEP 2/5  OpenClaw Desktop 설치"

$installerName = "OpenClaw-Setup-0.7.0.exe"
$scriptDir     = Split-Path -Parent $MyInvocation.MyCommand.Definition
$localExe      = Join-Path $scriptDir $installerName
$tempExe       = Join-Path $env:TEMP $installerName
$downloadUrl   = "https://github.com/agentkernel/openclaw-desktop/releases/download/v0.7.0%2Bopenclaw.2026.4.2/OpenClaw-Setup-0.7.0.exe"

# 같은 폴더에 .exe 가 있으면 그거 사용 (USB 사전 배포 시나리오)
if (Test-Path $localExe) {
    info "로컬 인스톨러 발견: $localExe (다운로드 생략)"
    $installer = $localExe
} else {
    info "인스톨러 다운로드 중... (약 400MB, 5~15분 소요)"
    Write-Host "  네트워크 환경에 따라 시간 차이가 큽니다." -ForegroundColor Gray
    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $tempExe -UseBasicParsing
    } catch {
        err "다운로드 실패: $($_.Exception.Message)"
        Write-Host "  네트워크 점검 후 재시도하시거나, 수동 다운로드:" -ForegroundColor Yellow
        Write-Host "  $downloadUrl" -ForegroundColor Gray
        fail "다운로드 실패."
    }
    if (-not (Test-Path $tempExe) -or (Get-Item $tempExe).Length -lt 100000000) {
        fail "다운로드 파일 크기가 비정상입니다. 재시도해주세요."
    }
    $installer = $tempExe
    ok "다운로드 완료"
}

info "인스톨러 실행 중..."
Write-Host "  설치 마법사가 뜨면 [Next] / [Install] 진행하세요." -ForegroundColor Gray
Write-Host "  설치 완료 후 자동으로 다음 단계로 넘어갑니다." -ForegroundColor Gray
Start-Process -FilePath $installer -Wait
ok "OpenClaw Desktop 설치 완료"

# === STEP 3: 첫 실행 + 셋팅 마법사 안내 ===
step "STEP 3/5  Gemini + Telegram 셋팅"

Write-Host ""
Write-Host "  지금부터 OpenClaw Desktop 앱이 실행됩니다." -ForegroundColor Cyan
Write-Host "  앱 안의 셋팅 마법사를 따라 진행하세요." -ForegroundColor Cyan
Write-Host ""
Write-Host "  [마법사 단계 안내]" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1단계 - Provider (모델 제공자)" -ForegroundColor White
Write-Host "    선택: Google Gemini" -ForegroundColor Gray
Write-Host "    API 키: AI Studio 에서 발급 (https://aistudio.google.com)" -ForegroundColor Gray
Write-Host "      → Google 로그인 → 좌측 Get API key → Create API key → 복사" -ForegroundColor Gray
Write-Host "    모델: gemini-3.1-pro-preview 또는 google/gemini-3.1-pro" -ForegroundColor Gray
Write-Host ""
Write-Host "  2단계 - Channel (채널)" -ForegroundColor White
Write-Host "    선택: Telegram" -ForegroundColor Gray
Write-Host "    봇 토큰: BotFather 에서 발급" -ForegroundColor Gray
Write-Host "      → Telegram 에서 @BotFather 검색 → /newbot → 봇 이름 입력" -ForegroundColor Gray
Write-Host "      → 봇 username 입력 (끝이 _bot 으로 끝나야 함, 예: my_agent_bot)" -ForegroundColor Gray
Write-Host "      → 토큰 복사" -ForegroundColor Gray
Write-Host ""
Write-Host "  3단계 - Gateway (게이트웨이)" -ForegroundColor White
Write-Host "    Mode: local" -ForegroundColor Gray
Write-Host "    Port: 18789 (기본값 그대로)" -ForegroundColor Gray
Write-Host ""
Write-Host "  마법사가 다 끝나면 시스템 트레이 (오른쪽 아래) 에 OpenClaw 아이콘이 생깁니다." -ForegroundColor Cyan
Write-Host ""

# 데스크탑 앱 실행 (설치 후 자동 실행되지 않은 경우 대비)
$desktopExe1 = "$env:LOCALAPPDATA\Programs\openclaw-desktop\OpenClaw.exe"
$desktopExe2 = "$env:LOCALAPPDATA\Programs\openclaw-desktop\openclaw-desktop.exe"
$desktopExe3 = "$env:ProgramFiles\openclaw-desktop\OpenClaw.exe"

$launched = $false
foreach ($p in @($desktopExe1, $desktopExe2, $desktopExe3)) {
    if (Test-Path $p) {
        Start-Process -FilePath $p
        $launched = $true
        ok "앱 실행: $p"
        break
    }
}
if (-not $launched) {
    warn "앱 실행 파일 자동 감지 실패. 시작메뉴에서 'OpenClaw' 검색해 직접 실행하세요."
}

Write-Host ""
Write-Host "  마법사 다 마치고 봇한테 /start 보낸 후 Enter 키 눌러주세요." -ForegroundColor Yellow
Read-Host

# === STEP 4: 페어링 확인 ===
step "STEP 4/5  봇 페어링 확인"

Write-Host ""
Write-Host "  Telegram 본인 봇한테 /start 명령을 보냈나요?" -ForegroundColor Yellow
Write-Host "  봇이 8자리 페어링 코드를 답장했어야 합니다." -ForegroundColor Gray
Write-Host ""
Write-Host "  - 코드를 받으셨으면: OpenClaw Desktop 앱 안에서 코드를 입력 또는" -ForegroundColor White
Write-Host "    PowerShell 에서 'openclaw pairing approve telegram <코드>' 실행" -ForegroundColor White
Write-Host "  - 코드가 안 왔으면: 봇 username 다시 확인 / Telegram 강제 종료 후 재시도" -ForegroundColor White
Write-Host ""
Read-Host "  페어링 완료되면 Enter"

# === STEP 5: 동작 확인 ===
step "STEP 5/5  최종 동작 확인"

Write-Host ""
Write-Host "  Telegram 봇한테 다음 메시지를 보내보세요:" -ForegroundColor Cyan
Write-Host "    안녕! 한국어로 자기소개 해줘" -ForegroundColor White
Write-Host ""
Write-Host "  Gemini 가 한국어로 답하면 = 설치 성공!" -ForegroundColor Green
Write-Host ""
Read-Host "  답이 왔으면 Enter, 안 왔으면 Ctrl+C 후 강사한테 화면 캡처 전송"

# === 마무리 ===
Write-Host ""
Write-Host "  ================================================" -ForegroundColor Green
Write-Host "    축하합니다! 에이전트가 살아났습니다." -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  사용법:" -ForegroundColor Cyan
Write-Host "    - Telegram 봇한테 채팅 = 일반 대화" -ForegroundColor White
Write-Host "    - 봇 명령어: /start, /help, /status" -ForegroundColor White
Write-Host "    - 시스템 트레이 (오른쪽 아래) OpenClaw 아이콘 우클릭 = 메뉴" -ForegroundColor White
Write-Host ""
Write-Host "  [에이전트 권한 (파일 읽기/쓰기/자동화) 활성화는 별도 단계]" -ForegroundColor Yellow
Write-Host "    강사한테 'agentify 진행해주세요' 라고 요청하시면" -ForegroundColor Gray
Write-Host "    파일 읽기/쓰기/터미널 명령 실행 권한을 추가로 부여드립니다." -ForegroundColor Gray
Write-Host ""
Write-Host "  Q&A 는 강의 단톡방에 올려주세요." -ForegroundColor Cyan
Write-Host ""

done0
