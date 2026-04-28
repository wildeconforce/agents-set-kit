# 07 — 텔레그램 봇 연동

> **목표**: 폰에서 텔레그램 메시지로 AI한테 명령 → PC가 일하고 답이 폰으로.
> **시간**: 30분.

자동화의 시작. 컴퓨터 앞에 안 앉아 있어도 AI에게 일 시키기.

---

## ✅ 텔레그램 가입 (안 한 경우)

1. 휴대폰에서 텔레그램 앱 설치
2. 휴대폰 번호 입력 → SMS 인증
3. 이름 / 사용자명 입력 → 가입 완료

PC에서도 가능하지만 휴대폰 번호 인증 필수.

---

## ✅ 봇 만들기 — BotFather

1. 텔레그램에서 `@BotFather` 검색 → 채팅 시작
2. 명령:
   ```
   /newbot
   ```
3. 봇 이름 입력 (자유, 예: `MyAIAgent`)
4. 봇 username 입력 — **반드시 `_bot`으로 끝나야** (예: `myaiagent_2026_bot`)
5. **토큰 받음**: `1234567890:ABCdefGhIjKlMnOpQrStUvWxYz` 형식
6. **토큰 복사 → 안전한 곳에 저장**. 다시 못 봅니다.

### 토큰 보안
- 절대 GitHub / 채팅 / 노출된 곳에 X
- 노출 시 BotFather → `/mybots` → 봇 → "Revoke Token" → 새로 발급

---

## ✅ Claude Code Telegram 플러그인 설치

Claude Code 안에서 (`claude` 실행 후):

```
/plugin install plugin:telegram@claude-plugins-official
```

설치 끝나면 슬래시 명령 활성화.

---

## ✅ 토큰 등록

```
/telegram:configure
```

대화형 모드로 토큰 입력 받음. 토큰 붙여넣기 → 저장.

또는 직접 `.env` 파일 편집:
```bash
# 파일: ~/.claude/channels/telegram/.env
TELEGRAM_BOT_TOKEN=1234567890:ABCdefGhIjKlMnOpQrStUvWxYz
```

---

## ✅ 페어링 — 본인 텔레그램 ID 등록

1. 만든 봇 (예: `@myaiagent_2026_bot`) 채팅창 열기
2. `/start` 메시지 보내기
3. Claude Code에서:
   ```
   /telegram:access
   ```
4. 페어링 코드 받음 → 코드를 봇 채팅창에 답장
5. 등록 완료

### 또는 수동 등록
챗 ID 받기:
```
https://api.telegram.org/bot<토큰>/getUpdates
```
→ JSON에서 `"id":` 값이 본인 챗 ID.

`access.json` 편집:
```json
{
  "dmPolicy": "allowlist",
  "allowFrom": ["1234567890"]
}
```
파일 위치: `~/.claude/channels/telegram/access.json`

---

## ⚠️ 중요 — `--channels` 플래그

Claude Code 세션이 텔레그램 채널을 opt-in 해야 동작.

### 자동 적용 (권장)
npm shim에 박아놓기:

**Windows** — `%APPDATA%\npm\claude.cmd`:
```cmd
"%dp0%\node_modules\@anthropic-ai\claude-code\bin\claude.exe" --channels plugin:telegram@claude-plugins-official %*
```

**Mac/Linux** — `~/.npm-global/bin/claude` 또는 비슷한 경로:
```sh
exec "$basedir/node_modules/@anthropic-ai/claude-code/bin/claude.exe" --channels plugin:telegram@claude-plugins-official "$@"
```

### npm 업데이트 후 재패치 필요
claude-code 업데이트되면 shim 재생성 → 패치 사라짐. 재적용 필요.

---

## ✅ 작동 확인

1. Claude Code `/exit` → `claude --continue` (재시작)
2. 텔레그램 봇 채팅에 메시지:
   ```
   안녕? 한국어로 답해줘.
   ```
3. Claude Code 터미널에 메시지 도달:
   ```
   <channel source="plugin:telegram:telegram" chat_id="..." ...>
   안녕? 한국어로 답해줘.
   </channel>
   ```
4. Claude가 응답 → 자동으로 텔레그램에 송신
5. 폰에서 답변 받음

성공.

---

## 💡 활용 — 자동화 시나리오

### 1. 매일 아침 알림
```
매일 8시에 어제 일정 정리해서 텔레그램으로 보내줘.
```
→ Claude Code가 cron 자동 셋업.

### 2. 코드 사진 디버깅
폰에서 코드 사진 → 봇에게 전송 → "이 코드 에러 분석해줘"
→ 봇이 OCR + 분석해서 답.

### 3. 일기 / 회고 자동
"오늘 어떤 일 있었는지 정리해줘" → 봇이 컴퓨터의 노트 / 메일 분석 → 요약.

### 4. 복잡한 작업 백그라운드
"100MB 파일 분석해서 결과 카톡으로 알려줘"
→ Claude Code가 작업 → 끝나면 텔레그램 알림.

---

## 🚧 문제 해결

### 봇 응답 없음 (typing 표시 안 됨)
- 토큰 맞는지 확인 (BotFather → `/mybots` → 봇 → "API Token")
- 봇 username 정확히 입력했는지

### 봇 응답 없음 (typing은 표시됨)
**원인**: `--channels` 플래그 누락 (npm 업데이트 후 흔함)
**해결**: shim 재패치 + Claude Code 재시작
```bash
# 진단
grep "channels" ~/.npm-global/bin/claude  # Mac/Linux
type %APPDATA%\npm\claude.cmd  # Windows
```
→ `--channels` 누락 시 재패치.

### 다른 사람도 봇 쓰게 하려면
`access.json`에 친구 ID 추가:
```json
"allowFrom": ["1234567890", "9876543210"]
```

### 그룹 채팅 등록
```json
{
  "groups": {
    "-1001234567890": {
      "allowFrom": ["1234567890"],
      "requireMention": true
    }
  }
}
```
그룹에서 `@봇이름`으로 멘션해야 응답.

---

## ⚠️ 보안

### 절대 하지 말 것
- 봇 토큰 GitHub에 푸시 (즉시 토큰 탈취됨)
- 모르는 사람 `allowFrom`에 추가
- 봇한테 "내 비밀번호 X" 같은 민감정보

### 하면 좋은 것
- 토큰을 `.env`에만 (`.gitignore`에 `.env` 추가)
- 매월 1회 토큰 회전 (Revoke + 새로 발급)
- `dmPolicy: "allowlist"` 사용 (공개 봇 X)

---

## ✅ 다음 단계

- [08-agents-hq-dashboard.md](08-agents-hq-dashboard.md) — 라이브 작업 모니터링 대시보드
- 또는 본인 자동화 시나리오 시작
