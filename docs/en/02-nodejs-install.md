# 02 — Install Node.js

> **Goal**: `node --version` works.
> **Time**: 5 min.

Claude Code runs on Node.js. Get this in place first.

---

## ✅ Windows

### Steps
1. Go to https://nodejs.org
2. Click the big **LTS version** button on the left (e.g. v22.x.x LTS)
3. Download the `.msi` → double-click
4. Setup wizard: **Next** through (defaults are fine)
5. **Install** at the end
6. Open a **new** PowerShell window (Start → search "PowerShell")
7. Verify:
   ```powershell
   node --version
   npm --version
   ```
   → Output like `v22.x.x` means OK

### Traps
- **Not recognized**: a PowerShell that was already open uses the old PATH. **Always open a new window.**
- **Permission denied**: if normal PowerShell fails, open it as **Administrator** (right-click → "Run as Administrator")

---

## ✅ Mac

### Option 1 — Official installer
1. Go to https://nodejs.org
2. Download **LTS macOS Installer** (.pkg)
3. Double-click → run setup
4. Spotlight (Cmd+Space) → "Terminal"
5. Verify:
   ```bash
   node --version
   npm --version
   ```

### Option 2 — Homebrew
```bash
brew install node
```
No Homebrew? → https://brew.sh

### Option 3 — nvm (recommended for devs)
nvm = Node Version Manager. Install / switch multiple versions:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts
nvm use --lts
```

---

## ✅ Linux (Ubuntu / Debian)

```bash
# Add NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Install
sudo apt-get install -y nodejs

# Verify
node --version
npm --version
```

---

## 🔍 Verification checklist

```bash
node --version
# → v22.x.x (LTS is fine)

npm --version
# → 10.x.x or higher

# Basic smoke test
node -e "console.log('hello from node')"
# → hello from node
```

---

## 🚧 Troubleshooting

### "command not found: node" (Mac)
```bash
# Check PATH
echo $PATH

# If installed via Homebrew, add to PATH
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### "node is not recognized" (Windows)
- Control Panel → System → Advanced System Settings → Environment Variables
- Verify `C:\Program Files\nodejs\` is in Path
- Add it if missing
- Open a new PowerShell window and verify again

### npm is very slow (Korea)
Use a Korean npm mirror:
```bash
npm config set registry https://registry.npmmirror.com/
```
Restore default:
```bash
npm config set registry https://registry.npmjs.org/
```

---

## ✅ Next

Node.js verified? → [03-claude-code.md](03-claude-code.md) — install Claude Code.
