# Changelog

## [v3.0.1] — 2026-05-02

### Agent Kit v3 (신규)

한국어 OpenClaw + Gemini 3.1 Pro Preview + Telegram 봇 통합 키트. Windows + Mac 분리 배포.

**Windows (`kits/agent_kit_v3/windows/`)**
- `01_여기를_더블클릭하세요.bat` — `chcp 65001` + `-ExecutionPolicy Bypass` + pwsh/PowerShell fallback
- `setup.ps1` — Windows 10+ 확인, 기존 OpenClaw 감지/백업, 동봉 .exe 우선 / fallback GitHub 다운, 마법사 단계별 한국어 캡션, 페어링 안내, 동작 확인
- 베이스: agentkernel/openclaw-desktop v0.7.0+openclaw.2026.4.2

**Mac (`kits/agent_kit_v3/mac/`)**
- `01_여기를_더블클릭하세요.command` — UTF-8 로케일 강제 + bash 진입점
- `setup.sh` — macOS / arch (arm64/x86_64) 감지, 로케일 fallback, 기존 OpenClaw 감지/백업, 공식 install.sh 실행, PATH 강제 갱신 (Homebrew Apple Silicon + Intel + npm prefix), `openclaw onboard` 실행, 절대경로 fallback
- 베이스: openclaw 공식 `install.sh` (openclaw.ai)

**v3.0.1 hardening (Mac, Jack 의 Mac 미보유 상태에서 정적 분석으로 강화)**
- PATH 핸들링 강화 (`/opt/homebrew/bin` + `/usr/local/bin` + npm prefix 명시)
- 로케일 fallback (`ko_KR.UTF-8` 미지원 → `en_US.UTF-8`)
- 아키텍처 감지 + 로그 (`uname -m` → arm64 / x86_64)
- install.sh 실행 로그 캡처 (`$HOME/openclaw_install.log`)
- Homebrew 첫 설치 시 sudo 비밀번호 prompt 사전 안내
- `hash -r` 로 셸 명령 캐시 갱신
- `openclaw` 명령 절대경로 fallback (PATH 갱신 실패 시)

### 검증 (2026-05-02 정적)

- ✅ Bash 구문 (`bash -n`)
- ✅ PowerShell 구문 (`Parser.ParseFile`)
- ✅ URL 6개 전부 HTTP 200
- ✅ .exe SHA256 GitHub 공식 일치 (`3334ec2e...1209e`)
- ✅ install.sh 내용 정상 (TLS + `set -euo pipefail`)
- ✅ BOM 없음 (4개 스크립트)
- ✅ Bash `local` 키워드 misuse 없음
- ✅ Zip 무결성 + 파일 카운트
- ✅ Mac arch 분기 정확
- ✅ Windows BAT 안전장치 (chcp 65001, ExecutionPolicy Bypass, NoProfile, pwsh fallback)
- ⚠️ 실제 실행 검증 (end-to-end) 보류 — 베타 테스터 모집

### 라이선스

- 이 키트: **MIT** (이 repo 의 LICENSE)
- OpenClaw Desktop: **GPL-3.0** (agentkernel/openclaw-desktop)
- OpenClaw 본체: **MIT** (openclaw/openclaw)

---

## [Pre-v3 hotfixes] — 2026-04-30

- `300b86c` PowerShell ExecutionPolicy 우회 (PSSecurityException 해결)
- `8717daa` Windows CMD 명령 추가 (PowerShell + CMD 병행 지원)
- `11b575f` Win/Mac 한 줄 명령 추가 (config 폴더+파일 자동생성)
- `87094a9` OpenClaw 2026.4.27 baseUrl 필수 필드 누락 에러 해결법

## [Initial] — 2026-04-28~29

- 레포 초기 publish (README KR/EN, docs/01~08, scripts/install-windows.ps1, install-mac.sh)
- SDXL 헤더 이미지 9장
