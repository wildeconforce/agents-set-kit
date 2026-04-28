# SDXL 이미지 프롬프트 (8개 카테고리 헤더 + 1개 히어로)

> **목적**: README 및 docs/01~08 헤더에 들어갈 일러스트.
> **모델**: SDXL Base 1.0 (`sd_xl_base_1.0.safetensors`).
> **생성 위치**: ComfyUI on `RTX 4060 Laptop GPU` (8GB VRAM).
> **출력 폴더**: `/tmp/agents-set-kit/docs/images/` (PNG, 그 후 web에 맞게 압축).

---

## 🎨 스타일 가이드 (모든 이미지 공통)

### 톤 결정
**Modern flat illustration** (Stripe / Vercel / Supabase docs 스타일) — 사실풍 X, 만화풍 X, 미니멀 벡터 일러스트.

### 색상 팔레트 (CONSISTENT — 8장이 한 시리즈로 보여야)
```
Primary:   #6366F1 (indigo-500) — 주조색
Accent:    #10B981 (emerald-500) — 강조
Warm:      #F59E0B (amber-500) — 따뜻한 포인트
Dark:      #1E1B4B (indigo-950) — 어두운 톤
Light:     #F8FAFC (slate-50) — 배경
```

각 카테고리별로 **하나의 메인 색**을 정해 시리즈성 유지:
| 카테고리 | 메인 색 | 보조 색 |
|---------|---------|---------|
| Claude Code | 따뜻한 오렌지 (#F59E0B) | indigo |
| OpenClaw | 인디고 (#6366F1) | emerald |
| Ollama | 에메랄드 (#10B981) | indigo |
| OpenRouter | 보라 (#A855F7) | amber |
| Telegram | 하늘파랑 (#0EA5E9) | indigo |
| 보안 | 진한 인디고 (#1E1B4B) | amber |
| 설치 | 슬레이트 그레이 (#64748B) | emerald |
| Troubleshooting | 빨강 (#EF4444) | indigo |

### 공통 스타일 키워드 (모든 프롬프트에 포함)
```
modern flat illustration, minimalist vector art, soft gradients,
geometric shapes, clean composition, technical documentation aesthetic,
isometric perspective, generous negative space,
pastel color palette with one accent color, no text, no logos, no watermarks
```

### 공통 NEGATIVE 프롬프트 (모든 생성 시)
```
photorealistic, photo, 3D render, ugly, blurry, low quality, jpeg artifacts,
text, letters, words, typography, watermark, signature, logo,
realistic skin, human face details, cluttered, busy background,
grainy, dark, dystopian, scary, anime style, manga, cartoon mascot
```

### SDXL 추천 파라미터
- **Sampler**: `dpmpp_2m_sde` 또는 `euler_a`
- **Scheduler**: `karras`
- **Steps**: 30
- **CFG**: 7.0
- **Resolution**:
  - 카테고리 헤더 (가로형): **1216 × 832** (3:2)
  - 히어로 (와이드): **1536 × 640** (12:5, README 상단용)
  - 정사각형 보조: 1024 × 1024
- **Seed**: 각 시리즈에 고정값 사용해 일관성 유지 (예: 42, 1337, 7777 중 하나)

---

## 0️⃣ HERO — README 최상단

**용도**: README.md 첫 화면 임팩트
**크기**: 1536 × 640 (와이드)
**파일명**: `hero-banner.png`

### 프롬프트
```
A modern flat illustration of an AI agent ecosystem, isometric view,
five glowing orbs connected by flowing energy lines representing different
AI tools, geometric workspace with floating panels and abstract code blocks,
soft purple-indigo gradient background fading to warm amber on the right,
subtle grid pattern, sense of orchestration and connection,
modern flat illustration, minimalist vector art, soft gradients,
geometric shapes, clean composition, technical documentation aesthetic,
isometric perspective, generous negative space, pastel color palette
with indigo and amber accents, no text, no logos, no watermarks
```

---

## 1️⃣ Claude Code (docs/03)

**컨셉**: 터미널이 의인화된 듯한 친근한 도구. 명령어 입력 → 즉각 반응.
**메인색**: amber (#F59E0B)
**파일명**: `01-claude-code.png`

### 프롬프트
```
A friendly minimalist illustration of a glowing terminal window in the center,
warm amber light emanating from the prompt cursor, abstract floating
geometric shapes representing files and code blocks orbiting around it,
soft cream background with warm amber and orange accents, indigo highlights,
sense of conversation and assistance, modern flat illustration,
minimalist vector art, soft gradients, geometric shapes, clean composition,
technical documentation aesthetic, isometric perspective, generous negative
space, no text, no logos, no watermarks
```

---

## 2️⃣ OpenClaw (docs/04)

**컨셉**: 여러 모델이 하나의 인터페이스로 통합. 멀티 라우팅.
**메인색**: indigo (#6366F1)
**파일명**: `02-openclaw.png`

### 프롬프트
```
A minimalist illustration of a central hub with multiple glowing pathways
branching out to different abstract model nodes, each node a different soft
geometric shape (sphere, cube, pyramid) representing different AI models,
indigo gradient background with emerald accent lines connecting nodes,
sense of routing and choice, modern flat illustration, minimalist vector
art, soft gradients, clean composition, technical documentation aesthetic,
isometric perspective, generous negative space, pastel color palette,
no text, no logos, no watermarks
```

---

## 3️⃣ Ollama — 로컬 모델 (docs/06)

**컨셉**: 본인 PC = 안전하고 비공개. 외부와 차단.
**메인색**: emerald (#10B981)
**파일명**: `03-ollama-local.png`

### 프롬프트
```
A minimalist illustration of a glowing laptop on a desk with a soft emerald
green energy field surrounding it, contained inside a translucent dome
representing privacy and local processing, no internet cables or external
connections, abstract llama silhouette subtly integrated into the dome's
geometric pattern, dark indigo background with soft emerald glow, sense of
self-sufficiency and isolation, modern flat illustration, minimalist vector
art, soft gradients, clean composition, technical documentation aesthetic,
isometric perspective, generous negative space, no text, no logos, no
watermarks
```

---

## 4️⃣ OpenRouter — 무료 모델 (docs/05)

**컨셉**: 100+ 모델 카탈로그. 라우터 = 분배.
**메인색**: purple (#A855F7)
**파일명**: `04-openrouter.png`

### 프롬프트
```
A minimalist illustration of a central router device emitting soft purple
light, with multiple thin energy beams fanning out to abstract model cards
floating in space, each card a different pastel color (amber, emerald,
indigo, sky blue), some cards labeled with subtle "FREE" tag indicators
shown only as small star icons, dark navy background with purple gradient,
sense of selection and abundance, modern flat illustration, minimalist
vector art, soft gradients, clean composition, technical documentation
aesthetic, isometric perspective, no text, no logos, no watermarks
```

---

## 5️⃣ Telegram 봇 (docs/07)

**컨셉**: 폰과 PC가 연결됨. 어디서든 명령.
**메인색**: sky blue (#0EA5E9)
**파일명**: `05-telegram.png`

### 프롬프트
```
A minimalist illustration of a smartphone and a laptop connected by flowing
sky-blue energy waves arcing through the air, abstract message bubble shapes
floating between them, sense of remote command and instant response,
soft cream background with sky-blue and indigo accents, paper airplane
silhouette subtly hinted in the energy wave shapes, modern flat illustration,
minimalist vector art, soft gradients, clean composition, technical
documentation aesthetic, isometric perspective, generous negative space,
no text, no logos, no watermarks
```

---

## 6️⃣ 보안 — Token / API Key Safety

**컨셉**: 토큰 = 자물쇠. 안전하게 보관.
**메인색**: deep indigo (#1E1B4B) + amber 강조
**파일명**: `06-security.png`

### 프롬프트
```
A minimalist illustration of a glowing key with abstract lock shape,
surrounded by a shield silhouette made of geometric facets, warm amber
glow at the key's center implying value and warning, deep indigo background
with subtle grid pattern, abstract padlock and circuit elements, sense of
protection and care, modern flat illustration, minimalist vector art, soft
gradients, clean composition, technical documentation aesthetic, isometric
perspective, generous negative space, no text, no logos, no watermarks
```

---

## 7️⃣ 설치 (docs/02)

**컨셉**: 도구 박스. 설치 = 준비 작업.
**메인색**: slate gray (#64748B) + emerald
**파일명**: `07-installation.png`

### 프롬프트
```
A minimalist illustration of an open toolbox with abstract geometric tools
and packages floating up out of it, downward arrow shapes implying
installation, soft slate gray background with emerald accent on key tools,
sense of unpacking and preparing, no actual recognizable tool brands,
modern flat illustration, minimalist vector art, soft gradients, clean
composition, technical documentation aesthetic, isometric perspective,
generous negative space, no text, no logos, no watermarks
```

---

## 8️⃣ Troubleshooting

**컨셉**: 문제 = 길이 막힘. 해결 = 새로운 길.
**메인색**: red-orange (#EF4444) + indigo 보조
**파일명**: `08-troubleshooting.png`

### 프롬프트
```
A minimalist illustration of a winding path with one section blocked by a
red warning shape, but a clear alternate route lit by soft indigo glow
appears beside it, abstract magnifying glass shape hovering above the
blocked section, soft cream background with red-orange warning accents
balanced by calming indigo guidance, sense of solving and redirecting,
not stressful, modern flat illustration, minimalist vector art, soft
gradients, clean composition, technical documentation aesthetic, isometric
perspective, generous negative space, no text, no logos, no watermarks
```

---

## 🎯 생성 순서 추천

1. **Hero 먼저 생성 (3~5장 batch)** — 가장 중요, 시리즈 톤 결정
2. Hero 마음에 들면 그 톤을 기준으로 나머지 8장 생성
3. 각 카테고리당 **3~4장 batch**, 베스트 1장 선택
4. **시드 고정**해서 동일 톤 유지 (예: hero seed 42 → 다른 카테고리도 42 또는 인접값 42, 142, 242 등)

## 🔧 워크플로우 팁

- ComfyUI 기본 SDXL workflow 사용
- Refiner 모델 있으면 사용 (감 잡힐 때까지는 Base만으로 OK)
- 1024×1024로 먼저 빠르게 batch → 좋은 거 골라서 1216×832로 재생성
- Img2img로 시드 고정한 채 약간 variation (denoising 0.4~0.5)

## 📐 후처리

- 파일 크기: PNG → WebP 변환 권장 (~50% 압축)
- 도구: `sharp` (Node), `Pillow` (Python), 또는 https://squoosh.app
- 목표: 각 이미지 200KB 이하

## 📥 README 통합 후

생성 완료된 이미지를 README와 docs/ 안에 임베드:

```markdown
<!-- README.md 상단 -->
![Agents Set Kit](docs/images/hero-banner.webp)

<!-- 각 docs/0X-*.md 상단 -->
![Claude Code](images/01-claude-code.webp)
```

---

## ⚠️ 만약 SDXL 결과가 별로면

대안:
1. **다른 체크포인트 시도**: SDXL Base → SDXL Turbo, JuggernautXL, RealVisXL 등
2. **LoRA 사용**: "FlatDesign LoRA" 또는 "VectorIllustration LoRA" 추가
3. **외부 도구**: Midjourney V7, DALL-E 3, FLUX.1-schnell (빠른 무료 옵션)
4. **벡터 일러스트 라이브러리**: undraw.co, blush.design (CC0/MIT 무료)
