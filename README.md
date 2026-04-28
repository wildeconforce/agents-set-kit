# Agents Set Kit

> **Zero → working AI agent stack**, in one afternoon.
> Claude Code · OpenClaw · Ollama · Telegram 봇 — 처음부터 끝까지.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/status-active-brightgreen.svg)]()

---

## 🎯 이게 뭔가요

AI 도구 처음 쓰는 사람도 따라하면 **자기 컴퓨터에서 AI 에이전트 풀스택**이 돌아갑니다.

**최종 결과**:
- 터미널에서 자연어로 AI한테 명령
- 무료 모델 여러 개를 한 곳에서 사용 (Llama / Qwen / GPT-OSS)
- 텔레그램으로 어디서든 AI에게 일 시키기
- 라이브 대시보드로 에이전트 작업 모니터링

**대상**:
- AI 처음 쓰는 사람 — 클릭 위치까지 명시
- "Claude.ai만 써봤는데 그 이상 가고 싶다"
- 커스텀 자동화 / 챗봇을 만들고 싶다

---

## 🚀 빠른 시작 (5분 — Quick Path)

### 사전 요구사항
- 노트북 (Windows / Mac / Linux)
- 인터넷 연결
- 이메일 계정 (가입용)
- (선택) 휴대폰 (텔레그램 봇용)

### 5분 안에 Claude Code 동작까지

```bash
# 1. Node.js 설치 (https://nodejs.org/ko 에서 LTS)

# 2. Claude Code 설치
npm install -g @anthropic-ai/claude-code

# 3. 작동 확인
claude --version

# 4. 첫 실행 (브라우저 로그인 자동)
claude

# 5. Claude Code 안에서:
안녕? 한국어로 답해줘.
```

여기까지 됐으면 → [docs/03-claude-code.md](docs/03-claude-code.md) 읽고 더 깊이 들어가기.

---

## 📚 단계별 가이드

순서대로 따라하면 됩니다. 각 단계 10~30분.

| 단계 | 내용 | 시간 | 필수도 |
|-----|------|------|--------|
| [01](docs/01-ai-services-signup.md) | AI 서비스 가입 (Claude / ChatGPT / Gemini) | 15분 | 필수 |
| [02](docs/02-nodejs-install.md) | Node.js 설치 | 5분 | 필수 |
| [03](docs/03-claude-code.md) | Claude Code 설치 + 첫 명령 | 15분 | 필수 |
| [04](docs/04-openclaw.md) | OpenClaw — 멀티모델 셋업 | 30분 | 권장 |
| [05](docs/05-openrouter-free.md) | OpenRouter 무료 모델 | 20분 | 권장 |
| [06](docs/06-ollama-local.md) | Ollama — 로컬 모델 (선택) | 30분 | 선택 |
| [07](docs/07-telegram-bot.md) | 텔레그램 봇 연동 | 30분 | 권장 |
| [08](docs/08-agents-hq-dashboard.md) | 라이브 대시보드 (선택) | 30분 | 선택 |
| [00](docs/troubleshooting.md) | 막힐 때 | — | 참조 |

---

## 🛠️ 자동 설치 스크립트

### Windows (PowerShell)
```powershell
# 관리자 권한으로 PowerShell 실행 후:
iwr -useb https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-windows.ps1 | iex
```

### Mac / Linux
```bash
curl -sSL https://raw.githubusercontent.com/wildeconforce/agents-set-kit/main/scripts/install-mac.sh | bash
```

스크립트는:
- Node.js 확인 (없으면 설치 안내)
- Claude Code 설치
- OpenClaw 설치 (선택)
- 모든 단계 검증

설치 후:
```bash
# 검증
bash scripts/verify.sh   # Mac
.\scripts\verify.ps1     # Windows
```

---

## 💡 작동 원리 (개략)

```
[당신]
  ├─ 브라우저 → Claude.ai / ChatGPT / Gemini  (가벼운 사용)
  ├─ 터미널 → Claude Code  (메인 워크스페이스)
  │            ├─ 파일 / 코드 직접 만짐
  │            ├─ 자동화 워크플로우
  │            └─ Telegram 플러그인 → 폰에서도 명령
  └─ 터미널 → OpenClaw  (무료 모델 백업)
              ├─ OpenRouter (원격 무료)
              └─ Ollama (로컬 무료)
```

---

## 🤔 자주 묻는 질문

**Q: 비용 들어요?**
A: 100% 무료로 시작 가능. Claude / ChatGPT / Gemini 무료 한도 + OpenRouter 무료 모델 + Ollama 로컬 = 월 $0.

**Q: Mac이랑 Windows 둘 다 되나요?**
A: 네. 명령어 거의 동일. 가이드는 양쪽 다 명시.

**Q: 영어 잘 못해도 돼요?**
A: 네. 한국어로 자연스럽게 명령 가능. 가이드도 한국어로 작성.

**Q: 설치 도중 막히면?**
A: [docs/troubleshooting.md](docs/troubleshooting.md) 먼저 확인. 그래도 안 되면 [Issues](https://github.com/wildeconforce/agents-set-kit/issues)에 등록.

**Q: 회사 노트북에서도 되나요?**
A: 권한 정책에 따라 다름. `npm install -g`가 막히면 IT 부서 협의 필요.

---

## 🧰 이 키트가 만들어진 배경

[wildeconforce.com](https://wildeconforce.com) 운영자가 5개월간 AI 에이전트 스택을 직접 빌드하면서 만난 함정 / 회피 / 셋업 패턴을 모아놨습니다.

**관련 글**:
- [에이전트 셋업 7번의 함정과 탈출](https://wildeconforce.com/posts/2026-04-27-agent-setup-7-traps)
- [텔레그램 양방향 복구기](https://wildeconforce.com/posts/2026-04-28-telegram-recovery)
- [V4.2 → V4.3.1 백테 일지](https://wildeconforce.com/posts/2026-04-27-v42-v431-grid-search-overfit)

---

## 📜 라이선스

MIT License — 자유롭게 fork / 수정 / 재배포 가능.

기여 환영 — Pull Request, Issue, 또는 [@wildeconforce](https://x.com/wildeconforce) DM.

---

## ⭐ 도움이 됐다면

레포에 ⭐ 부탁드립니다. 다른 사람도 찾기 쉬워집니다.

빌드하면서 만든 거 [#agents_set_kit](https://x.com/hashtag/agents_set_kit)으로 공유해주시면 RT.
