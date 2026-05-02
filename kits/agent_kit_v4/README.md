# 🤖 Agent Kit v4.0 — 한국어 OpenClaw + Gemini + Telegram (모드 선택)

> 🚧 **BETA** — 정적 검증 통과, 실제 환경 베타 테스터 모집 중.

Windows / Mac 노트북에 OpenClaw + Gemini 3.1 Pro Preview + Telegram 봇 기반 에이전트를 셋업하는 한국어 키트. **v4 부터 모드 선택** (A=단계별 / B=원클릭) 추가.

| | Windows | Mac |
|---|---|---|
| 폴더 | [`windows/`](windows/) | [`mac/`](mac/) |
| 진입점 | `01_여기를_더블클릭하세요.bat` | `01_여기를_더블클릭하세요.command` |
| 베이스 | openclaw-desktop .exe (마법사 GUI) | openclaw 공식 install.sh + onboard CLI |
| 크기 | 약 400MB (.exe 별도 다운) | 약 6KB |
| 호환 | Windows 10 이상 | macOS 10.15 (Catalina) 이상, Apple Silicon + Intel |

## 모드 선택 (v4 신규)

스크립트 시작 시 두 가지 모드 중 선택:

| | **모드 B (원클릭)** | **모드 A (단계별)** |
|---|---|---|
| 흐름 | 한 번에 Telegram 까지 | TUI 먼저 → Telegram 은 선택 |
| 시간 | 10~15분 | 15~25분 |
| 입력 | API 키 + 봇 토큰 + 페어링 코드 | API 키만 (Telegram 추가시 +봇토큰+코드) |
| 추천 | 입문자 / 강의 | 학습 / 디버깅 / Telegram 안 쓸 사람 |
| 결과 | 폰에서 AI 챗 | 데스크탑/터미널에서 AI 챗 |

스크립트가 실행되면 자동으로 묻습니다:
```
[B] 빠르게 (원클릭) — 한 번에 Telegram 까지
[A] 단계별 — TUI 먼저 동작 확인 → Telegram 은 나중에
선택 (A/B) [기본 B]:
```

기본값은 **B** (Enter 만 누르면 원클릭).

## 빠른 시작

### Windows
1. `windows/` 폴더 통째로 노트북에 복사
2. [공식 GitHub Release](https://github.com/agentkernel/openclaw-desktop/releases/tag/v0.7.0%2Bopenclaw.2026.4.2) 에서 `OpenClaw-Setup-0.7.0.exe` 다운받아 같은 폴더에 넣기
3. `01_여기를_더블클릭하세요.bat` 더블클릭
4. **모드 선택** (A 또는 B, 기본 B)
5. 화면 안내 따라 Gemini API 키 입력 (모드 B 면 Telegram 봇 토큰도)
6. 동작 확인

### Mac
1. `mac/` 폴더 통째로 노트북에 복사
2. 터미널: `chmod +x mac/01_여기를_더블클릭하세요.command mac/setup.sh` (처음 1회)
3. `01_여기를_더블클릭하세요.command` 더블클릭 (또는 우클릭 → "열기")
4. install.sh 가 Homebrew + Node.js + OpenClaw 자동 설치 (sudo 비밀번호 요구 가능)
5. **모드 선택** (A 또는 B, 기본 B)
6. onboard 마법사에서 Gemini 셋팅 (모드 B 면 Telegram 도)
7. 동작 확인

## 미리 준비

- Google 계정 (Gemini API 키 발급 — https://aistudio.google.com)
- Telegram 계정 (모드 B 또는 모드 A 에서 추가시; BotFather 봇 만들기)
- 인터넷 연결

## 동작 원리

### Windows (`setup.ps1`)
1. Windows 10+ 확인
2. 기존 OpenClaw 감지 → 백업
3. .exe 인스톨러 실행 (마법사 GUI)
4. **모드별 분기**:
   - B: provider + channel + gateway 한 번에
   - A: provider + gateway 만, channel 단계 SKIP
5. 모드 B → 페어링 → 봇 답 확인
6. 모드 A → TUI 챗 동작 확인 → (선택) Telegram 추가

### Mac (`setup.sh`)
1. macOS / 아키텍처 (arm64/x86_64) 감지
2. 로케일 fallback (ko_KR.UTF-8 → en_US.UTF-8)
3. 기존 OpenClaw 감지 → 백업
4. `curl -fsSL https://openclaw.ai/install.sh | bash`
5. PATH 강제 갱신 + openclaw 절대경로 fallback
6. **모드별 분기**:
   - B: `openclaw onboard` 모든 단계 진행
   - A: `openclaw onboard` 에서 Channel 단계 SKIP
7. 모드 B → 페어링 → 봇 답 확인
8. 모드 A → `openclaw chat` TUI 동작 확인 → (선택) Telegram 추가

## v4 검증 결과 (2026-05-02)

- ✅ Bash 구문 (`setup.sh`)
- ✅ PowerShell 구문 (`setup.ps1`)
- ✅ 모드 분기 흐름 검증 (양 모드 다 logical 흐름 OK)
- ✅ Mac arch 분기 정확 (arm64 / x86_64)
- ✅ Windows BAT 안전장치 (chcp 65001 + ExecutionPolicy Bypass + pwsh fallback)
- ⚠️ 실제 실행 검증 (end-to-end) 보류 — 베타 테스터 모집

상세: [CHANGELOG.md](../../CHANGELOG.md)

## 베타 테스터 환영

이 키트는 정적 검증은 통과했지만 실제 다양한 환경 (회사 PC / 회사 Mac / 한글 사용자명 / 공유 네트워크 등) 검증이 부족합니다. 시도해보시고:

- 끝까지 성공 → Issue 에 환경 + 모드 + 소요 시간 보고
- 어디선가 막힘 → Issue 등록 + 화면 캡처 + 로그 (`~/openclaw_install.log` Mac, 화면 PowerShell 출력 Windows)

이슈 템플릿: [.github/ISSUE_TEMPLATE/beta_test_report.md](../../.github/ISSUE_TEMPLATE/beta_test_report.md)

## License

이 키트: **MIT**
OpenClaw Desktop 본체: **GPL-3.0** (agentkernel/openclaw-desktop)
OpenClaw 본체: **MIT** (openclaw/openclaw)

## Credits

- [OpenClaw 공식](https://github.com/openclaw/openclaw) — 본체 + install.sh
- [openclaw-desktop](https://github.com/agentkernel/openclaw-desktop) — Windows 마법사 GUI
- 한국어 wrapper / 단계별 캡션 / 모드 분기 / Mac+Windows 통합: this project (wildeconforce/agents-set-kit)
