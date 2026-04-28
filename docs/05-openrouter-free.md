# 05 — OpenRouter 무료 모델

> **목표**: 결제카드 없이 진짜 무료로 100가지 AI 모델 사용.
> **시간**: 20분.

OpenRouter는 여러 AI 공급자(OpenAI / Anthropic / Google / Meta / Qwen / DeepSeek 등)를 한 API로 묶어줍니다. **무료 모델 풍부 + 결제카드 등록 안 받음**.

---

## ✅ 가입

1. https://openrouter.ai 접속
2. **Sign in** → Google / GitHub
3. 가입 즉시 사용 가능

### 결제 카드?
**등록 안 합니다.** 한도 초과하면 자동 차단되고 청구 X. → 결제 폭탄 절대 없음.

(Gemini Free Trial 같은 함정과 다름 — Gemini는 한도 넘으면 자동 paid 전환됨!)

---

## ✅ API 키 발급

1. https://openrouter.ai/keys 접속
2. **Create Key** 클릭
3. 이름 입력 (예: "claude-code") → Create
4. 키 복사 (`sk-or-v1-...`)
5. **안전한 곳에 저장** — 다시 못 봄

### 키 보안
- 절대 GitHub / 채팅에 공개 X
- 노출 시 즉시 Revoke + 새로 발급
- `.env` 파일에만 저장 → `.gitignore`에 `.env` 추가

---

## ✅ Claude Code 또는 OpenClaw에 등록

### 환경변수로 (Mac/Linux)
```bash
export OPENROUTER_API_KEY="sk-or-v1-여기에키"
```
영구 적용:
```bash
echo 'export OPENROUTER_API_KEY="sk-or-v1-여기에키"' >> ~/.zshrc
source ~/.zshrc
```

### 환경변수로 (Windows PowerShell)
```powershell
setx OPENROUTER_API_KEY "sk-or-v1-여기에키"
```
**새** PowerShell 창 열어야 적용.

### OpenClaw 직접 등록
```bash
openclaw config set models.providers.openrouter.apiKey "sk-or-v1-여기에키"
```

---

## ✅ 무료 모델 사용

### OpenClaw에서 무료 모델 지정
```bash
openclaw models set openrouter/openai/gpt-oss-120b:free
```

### 추천 무료 모델

| 모델 | 컨텍스트 | 특징 |
|------|----------|------|
| `openai/gpt-oss-120b:free` | 128k | OpenAI 오픈소스, 안정적 |
| `openai/gpt-oss-20b:free` | 128k | 작고 빠름 |
| `qwen/qwen3-coder:free` | 256k | 한국어 + 코드 강함 |
| `google/gemma-3-27b-it:free` | 128k | Google Gemma, 빠름 |
| `meta-llama/llama-3.3-70b-instruct:free` | 65k | Meta 대형 모델 |
| `nvidia/nemotron-nano-9b-v2:free` | 128k | NVIDIA 추론 |
| `z-ai/glm-4.5-air:free` | 128k | Z.AI, 한국어 |

### 모델 목록 보기
```bash
# 모든 모델
openclaw models list --all | grep ":free"
```

또는 웹: https://openrouter.ai/models?max_price=0 → "Free" 필터.

---

## 💡 무료 모델 한도

각 모델은 **분당 / 일당 / 토큰** 한도 있음. 한도는 모델마다 다름.

### 일반적 한도
- 분당 5~20 호출
- 일당 50~500 호출
- 한도 초과 시 → 429 에러 → 잠시 후 재시도

### 한도 늘리려면
1. OpenRouter 잔고에 **$10+** 충전 → "Tier 1" 자격 → 일부 모델 한도 ↑
2. 본인 API 키 (OpenAI / Anthropic) 추가 → 그쪽 한도 사용

---

## 🚧 문제 해결

### "Provider returned error 429"
한도 초과. 다른 모델로 전환 또는 잠시 대기.

### Fallback 체인 활용
주 모델 한도 초과 시 자동으로 다음 모델:
```bash
openclaw models fallbacks add openrouter/qwen/qwen3-coder:free
openclaw models fallbacks add openrouter/openai/gpt-oss-20b:free
```

### "No endpoints found"
모델이 OpenRouter에서 일시 비활성. 다른 모델 사용.

### 응답이 영어로만
무료 모델 중 일부 (gpt-oss 등)는 영어 편향. 한국어 강제:
- 시스템 프롬프트에 "한국어로 답변" 명시
- OpenClaw `SOUL.md`에 룰 추가

---

## 💰 비용 시뮬

### 무료만 사용
- 24/7 가벼운 사용 → **$0**
- 무거운 사용 → 한도 초과 시 차단, 다음날 갱신
- 결제 폭탄 위험 0

### Tier 1 ($10 한 번 충전)
- 한도 ↑ (모델마다 다름)
- 무료 모델 + paid 모델 같이 사용 가능

### Pay-as-you-go
- gpt-4o: $2.5/1M tokens
- claude-sonnet-4: $3/1M tokens
- 가벼운 사용 → 월 $1~5

---

## ✅ 다음 단계

OpenRouter 셋업 끝났으면:
- [06-ollama-local.md](06-ollama-local.md) — 로컬 모델로 진짜 무한 무료
- [07-telegram-bot.md](07-telegram-bot.md) — 폰에서 명령
