# 04 — OpenClaw 설치

> **목표**: 무료 모델 여러 개를 한 곳에서 사용.
> **시간**: 30분.

OpenClaw는 Claude Code와 비슷한 인터페이스인데, **여러 모델 / 여러 공급자**를 한 번에 다룹니다. Llama / Qwen / DeepSeek / GPT-OSS 같은 무료 모델 / Claude / GPT / Gemini 다 지원.

이 단계는 **선택 사항** — Claude Code만으로도 일은 됩니다. 비용 절감 / 멀티모델 비교를 원하면.

---

## ✅ 설치

```bash
npm install -g openclaw
```

### 작동 확인
```bash
openclaw --version
```

### 첫 실행
```bash
openclaw
```
처음 실행 시 자동으로 config 파일 생성 (`~/.openclaw/openclaw.json`). ~30초 소요.

---

## ✅ 모델 공급자 등록

OpenClaw는 자체 모델이 없음. 외부 공급자 API 키가 필요. 무료 옵션 추천:

### 옵션 A — OpenRouter 무료 모델 (권장)
- [05-openrouter-free.md](05-openrouter-free.md) 참조
- 결제카드 등록 X
- 일일 한도 있지만 학습용 충분

### 옵션 B — Anthropic 직접 (Claude Code랑 같은 키)
```bash
openclaw config set models.providers.anthropic.apiKey YOUR_ANTHROPIC_KEY
```

### 옵션 C — Ollama 로컬 (무제한 무료)
- [06-ollama-local.md](06-ollama-local.md) 참조
- 본인 PC에서 모델 실행 → 무한정 무료
- 하지만 PC 사양 필요 (16GB+ RAM)

---

## ✅ 모델 설정

### 기본 모델 지정
```bash
# OpenRouter 무료 모델
openclaw models set openrouter/openai/gpt-oss-120b:free

# Claude (Anthropic 키 등록된 경우)
openclaw models set anthropic/claude-sonnet-4-6

# Ollama 로컬
openclaw models set ollama/qwen2.5:7b
```

### Fallback 체인 (다중 안전망)
주 모델이 다운됐을 때 자동으로 다음 모델로 넘어감:
```bash
openclaw models fallbacks add openrouter/qwen/qwen3-coder:free
openclaw models fallbacks add ollama/qwen2.5:7b
```

---

## ✅ 첫 실행

```bash
openclaw
```
Claude Code랑 비슷한 인터페이스. 자연어로 명령.

```
안녕? 한국어로 답해줘.
```

응답 모델이 본인이 지정한 거에서 옴.

### 모델 비교 — 같은 질문 여러 모델에
```bash
# 모델 1로 실행
openclaw models set openrouter/openai/gpt-oss-120b:free
openclaw "한국어로 자기소개"

# 모델 2로 실행
openclaw models set openrouter/qwen/qwen3-coder:free
openclaw "한국어로 자기소개"
```

→ 응답 비교하면 모델별 성격 차이 파악.

---

## 💡 추천 모델 — 무료 + 한국어

| 모델 ID | 특징 |
|---------|------|
| `openrouter/openai/gpt-oss-120b:free` | OpenAI 오픈소스, 균형형 |
| `openrouter/qwen/qwen3-coder:free` | 한국어 native, 코드 강함 |
| `openrouter/google/gemma-3-27b-it:free` | Google Gemma, 빠름 |
| `ollama/qwen2.5:7b` | 로컬, 한국어 native |
| `ollama/deepseek-r1:14b` | 로컬, 추론 강함 (단 tools 지원 X) |

---

## 🚧 문제 해결

### "Unknown model" 에러
OpenClaw 정적 카탈로그에 없는 모델 ID. 사용 가능한 모델 확인:
```bash
openclaw models list --all
```
원하는 모델이 없으면 → custom provider 등록 필요 (고급).

### "rate-limited upstream"
무료 모델은 분당 호출 한도 있음. 잠시 후 재시도.

### Tools 미지원 모델
일부 reasoning 모델 (DeepSeek-R1 등)은 tool calling 미지원.
OpenClaw는 tool calling 기반이라 이런 모델은 에이전트 작업 X.
→ Qwen / GPT-OSS / Llama 같은 tools 지원 모델 사용.

### 한국어 어색
OpenClaw 워크스페이스의 `SOUL.md`에 페르소나 추가:
```bash
echo '## Language: Always respond in Korean by default.' >> ~/.openclaw/workspace/SOUL.md
```
다음 실행부터 한국어 응답 강제.

---

## ✅ 다음 단계

- [05-openrouter-free.md](05-openrouter-free.md) — OpenRouter 무료 모델 자세히
- [06-ollama-local.md](06-ollama-local.md) — 로컬 모델로 진짜 무한 무료
