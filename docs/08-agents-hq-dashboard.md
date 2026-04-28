# 08 — Agents HQ 대시보드 (선택)

> **목표**: 에이전트 작업을 라이브로 시각화 + 텔레그램 푸시.
> **시간**: 30분.

이 단계는 **고급 / 선택 사항**. AI 에이전트가 뭘 하고 있는지 실시간 모니터링하고 싶을 때.

---

## 핵심 기능

- 에이전트 카드 그리드 (역할별 캐릭터 아바타)
- 라이브 transcript (사용자 명령 / 도구 호출 / 결과)
- 텔레그램 푸시 (3초마다 상태 업데이트)
- Public URL (cloudflared 터널)

---

## ✅ 셋업

이 키트는 [agents-hq](https://github.com/wildeconforce/agents-hq) (별도 레포)를 사용합니다.

### 빠른 시작
```bash
git clone https://github.com/wildeconforce/agents-hq.git
cd agents-hq
python serve.py
```
→ http://localhost:8787/dashboard.html 접속.

### 자동화 (Windows Startup)
- `agents-hq/startup.bat` 실행
- 또는 Startup 폴더에 .lnk 추가

### Cloudflared 터널 (외부 접속)
```bash
cloudflared tunnel --url http://localhost:8787
```
→ 공개 URL 발급 (`https://xxxx.trycloudflare.com`).

---

## 작동 원리

1. Claude Code 훅 (`SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `Stop`)
2. `status_writer.py`가 훅 이벤트 받아서 `state.json` 업데이트
3. `dashboard.html`이 500ms마다 폴링 + 렌더
4. `telegram_status.py`가 같은 데이터를 텔레그램 봇으로 edit-in-place 푸시

---

## 자세한 셋업

이 키트 범위 밖. 별도 레포 [github.com/wildeconforce/agents-hq](https://github.com/wildeconforce/agents-hq) 참조.

---

## 활용 시나리오

- 코딩 라이브 스트림 — 시청자가 작업 흐름 보면서 채팅
- 교육 / 워크샵 — 강사 화면을 수강생들이 같이 봄
- 본인 작업 모니터링 — 에이전트 막히면 알림

자세히는 [Wildeconforce LIVE 프로젝트](https://wildeconforce.com/projects/wef-live) 참조.
