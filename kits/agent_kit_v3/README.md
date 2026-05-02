# 🤖 Agent Kit v3.0.1 — 한국어 OpenClaw + Gemini + Telegram 원클릭

> 🚧 **BETA** — 정적 검증 12개 항목 모두 PASS, 실제 환경 베타 테스터 모집 중.

Windows / Mac 노트북에 OpenClaw + Gemini 3.1 Pro Preview + Telegram 봇 기반 에이전트를 약 15~20분 안에 셋업하는 한국어 키트.

| | Windows | Mac |
|---|---|---|
| 폴더 | `windows/` | `mac/` |
| 진입점 | `01_여기를_더블클릭하세요.bat` | `01_여기를_더블클릭하세요.command` |
| 베이스 | openclaw-desktop .exe (마법사 GUI) | openclaw 공식 install.sh + onboard CLI |
| 크기 | 약 400MB (.exe 별도 다운) | 약 6KB |
| 호환 | Windows 10 이상 | macOS 10.15 (Catalina) 이상, Apple Silicon + Intel |

## 빠른 시작

### Windows
1. `windows/` 폴더 통째로 노트북에 복사
2. [공식 GitHub Release](https://github.com/agentkernel/openclaw-desktop/releases/tag/v0.7.0%2Bopenclaw.2026.4.2) 에서 `OpenClaw-Setup-0.7.0.exe` 다운받아 같은 폴더에 넣기
3. `01_여기를_더블클릭하세요.bat` 더블클릭
4. 화면 안내 따라 Gemini API 키 + Telegram 봇 토큰 입력
5. 봇한테 한국어로 인사 → 답 확인

### Mac
1. `mac/` 폴더 통째로 노트북에 복사
2. 터미널 열고 `chmod +x mac/01_여기를_더블클릭하세요.command mac/setup.sh` (처음 1회)
3. `01_여기를_더블클릭하세요.command` 더블클릭 (또는 우클릭 → "열기")
4. install.sh 가 Homebrew + Node.js + OpenClaw 자동 설치 (sudo 비밀번호 요구할 수 있음)
5. onboard 마법사에서 Gemini + Telegram 셋팅
6. 봇한테 한국어로 인사 → 답 확인

## 미리 준비

- Google 계정 (Gemini API 키 발급 — https://aistudio.google.com)
- Telegram 계정 (BotFather 봇 만들기)
- 인터넷 연결

## 동작 원리

### Windows (`setup.ps1`)
1. Windows 10+ 확인
2. 기존 OpenClaw 감지 → 백업
3. .exe 인스톨러 실행 (마법사 GUI)
4. 한국어 캡션으로 마법사 단계 안내
5. 페어링 → 동작 확인

### Mac (`setup.sh`)
1. macOS / 아키텍처 (arm64/x86_64) 감지
2. 로케일 fallback (ko_KR.UTF-8 → en_US.UTF-8)
3. 기존 OpenClaw 감지 → 백업
4. `curl -fsSL https://openclaw.ai/install.sh | bash` 실행
5. PATH 강제 갱신 (Homebrew Apple Silicon + Intel + npm prefix)
6. `openclaw onboard` 실행 (대화형 마법사)
7. 페어링 → 동작 확인

## v3.0.1 검증 결과

- ✅ Bash 구문 (`setup.sh`)
- ✅ PowerShell 구문 (`setup.ps1`)
- ✅ URL 6개 전부 200
- ✅ .exe SHA256 GitHub 공식 일치
- ✅ install.sh 정상 (TLS + set -euo pipefail)
- ✅ BOM 없음
- ✅ Mac arch 분기 (arm64 / x86_64)
- ✅ Windows BAT 안전장치 (chcp 65001 + ExecutionPolicy Bypass)

상세: [CHANGELOG.md](../../CHANGELOG.md)

## 베타 테스터 환영

이 키트는 정적 검증은 통과했지만 실제 다양한 환경 (회사 PC / 회사 Mac / 한글 사용자명 / 공유 네트워크 등) 검증이 부족합니다. 시도해보시고:

- 끝까지 성공 → Issue 에 환경 + 소요 시간 보고
- 어디선가 막힘 → Issue 등록 + 화면 캡처 + 로그 (`~/openclaw_install.log` Mac, 화면 PowerShell 출력 Windows)

이슈 템플릿: `.github/ISSUE_TEMPLATE/beta_test_report.md`

## License

이 키트: **MIT**
OpenClaw Desktop 본체: **GPL-3.0** (agentkernel/openclaw-desktop)
OpenClaw 본체: **MIT** (openclaw/openclaw)

## Credits

- [OpenClaw 공식](https://github.com/openclaw/openclaw) — 본체 + install.sh
- [openclaw-desktop](https://github.com/agentkernel/openclaw-desktop) — Windows 마법사 GUI
- 한국어 wrapper / 단계별 캡션 / Mac+Windows 통합: this project (wildeconforce/agents-set-kit)
