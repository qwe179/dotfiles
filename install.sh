#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}  ✓ $1${NC}"; }
step() { echo -e "\n${YELLOW}==> $1${NC}"; }

# ─── apt 패키지 ───────────────────────────────────────────────
step "Installing apt packages..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
    git curl python3 python3-pip \
    fzf bat \
    lua5.3 liblua5.3-dev \
    build-essential
ok "apt packages"

# ─── nix ─────────────────────────────────────────────────────
if ! command -v nix &>/dev/null; then
    step "Installing Nix (Determinate)..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
    ok "nix installed — sourcing profile"
fi
# nix PATH 활성화
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# ─── nix 패키지 ──────────────────────────────────────────────
step "Installing nix packages (neovim, zoxide, rustup)..."
for pkg in neovim zoxide rustup; do
    bin="${pkg}"
    [ "$pkg" = "neovim" ] && bin="nvim"
    if ! [ -f "$HOME/.nix-profile/bin/$bin" ]; then
        echo "  installing $pkg..."
        nix profile install "nixpkgs#$pkg"
    fi
done
ok "nix packages"

# ─── rust stable ─────────────────────────────────────────────
if ! [ -f "$HOME/.cargo/bin/rustc" ]; then
    step "Setting up Rust stable toolchain..."
    "$HOME/.nix-profile/bin/rustup" default stable
    ok "rust stable"
fi

# ─── oh-my-bash ──────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-bash" ]; then
    step "Installing oh-my-bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" "" --unattended
    ok "oh-my-bash"
fi

# ─── luarocks 3.x ────────────────────────────────────────────
if ! command -v luarocks &>/dev/null || ! luarocks --version 2>/dev/null | grep -q "3\."; then
    step "Installing luarocks 3.x..."
    LRVER="3.11.1"
    curl -sL "https://luarocks.org/releases/luarocks-${LRVER}.tar.gz" -o /tmp/luarocks.tar.gz
    tar -C /tmp -xzf /tmp/luarocks.tar.gz
    cd "/tmp/luarocks-${LRVER}"
    ./configure --prefix="$HOME/.local" --with-lua-include=/usr/include/lua5.3 --quiet
    make -s && make install -s
    cd "$OLDPWD"
    ok "luarocks ${LRVER}"
fi

# ─── hererocks ───────────────────────────────────────────────
if ! command -v hererocks &>/dev/null; then
    step "Installing hererocks..."
    python3 -m pip install -q hererocks
    ok "hererocks"
fi

# ─── 심볼릭 링크 ─────────────────────────────────────────────
step "Linking dotfiles..."

# oh-my-bash가 .bashrc를 덮어쓰므로 마지막에 심볼릭 링크 복구
files=(.aliasrc .bashrc .zshrc .zshenv .gitconfig .vimrc .profile .bash_local)
for f in "${files[@]}"; do
    if [ -f "$DOTFILES/$f" ]; then
        ln -sf "$DOTFILES/$f" "$HOME/$f"
        ok "linked $f"
    fi
done

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
ok "linked nvim config"
ln -sf "$DOTFILES/fish" "$HOME/.config/fish"
ok "linked fish config"

# ─── obsidian vault ──────────────────────────────────────────
mkdir -p "$HOME/obsidian-vault"
ok "obsidian vault directory"

# ─── 완료 ────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Done! 설치 완료${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  다음 단계:"
echo "  1. 터미널 재시작"
echo "  2. nvim 실행 → lazy.nvim 플러그인 자동 설치"
echo "  3. nvim 안에서 :Lazy sync"
echo ""
