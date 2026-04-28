# 02 — Node.js 설치

> **목표**: `node --version` 명령이 작동.
> **시간**: 5분.

Claude Code는 Node.js 위에서 돌아갑니다. 다른 거 하기 전에 이거부터.

---

## ✅ Windows

### 단계
1. https://nodejs.org/ko 접속
2. 왼쪽 큰 버튼 **LTS 버전** 클릭 (예: v22.x.x LTS)
3. `.msi` 파일 다운로드 → 더블클릭
4. 설치 마법사: **Next** 계속 (기본 설정)
5. 마지막에 **Install** 클릭
6. **새** PowerShell 창 열기 (시작 메뉴 → "PowerShell" 검색)
7. 작동 확인:
   ```powershell
   node --version
   npm --version
   ```
   → `v22.x.x` 같은 출력이면 OK

### 함정
- **인식 안 됨**: 설치 전부터 열려 있던 PowerShell은 옛 PATH 사용. **반드시 새 창** 열기.
- **권한 거부**: 일반 PowerShell로 안 되면 **관리자 권한**으로 다시 (마우스 우클릭 → "관리자 권한으로 실행")

---

## ✅ Mac

### 단계 1 — 공식 설치 프로그램
1. https://nodejs.org/ko 접속
2. **LTS macOS Installer** 다운로드 (.pkg)
3. 더블클릭 → 설치 마법사 진행
4. Spotlight (Cmd+Space) → "Terminal"
5. 작동 확인:
   ```bash
   node --version
   npm --version
   ```

### 단계 2 — Homebrew 사용 (대안)
```bash
brew install node
```
Homebrew 없으면 https://brew.sh

### 단계 3 — nvm 사용 (개발자 권장)
nvm = Node Version Manager. 여러 버전 설치 / 전환:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts
nvm use --lts
```

---

## ✅ Linux (Ubuntu / Debian)

```bash
# NodeSource 저장소 추가
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# 설치
sudo apt-get install -y nodejs

# 확인
node --version
npm --version
```

---

## 🔍 작동 확인 체크리스트

```bash
node --version
# → v22.x.x (LTS 버전이면 OK)

npm --version
# → 10.x.x 또는 그 이상

# 기본 동작 테스트
node -e "console.log('hello from node')"
# → hello from node
```

---

## 🚧 문제 해결

### "command not found: node" (Mac)
```bash
# PATH 확인
echo $PATH

# Homebrew 설치된 경우 PATH에 추가
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### "node is not recognized" (Windows)
- 제어판 → 시스템 → 고급 시스템 설정 → 환경 변수
- Path에 `C:\Program Files\nodejs\` 있는지 확인
- 없으면 추가
- 새 PowerShell 창 열어서 다시 확인

### npm이 매우 느림 (한국)
한국 npm 미러 사용:
```bash
npm config set registry https://registry.npmmirror.com/
```
원래대로:
```bash
npm config set registry https://registry.npmjs.org/
```

---

## ✅ 다음 단계

Node.js 작동 확인 끝났으면 → [03-claude-code.md](03-claude-code.md) — Claude Code 설치.
