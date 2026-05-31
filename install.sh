#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}  ✓ $1${NC}"; }
step() { echo -e "\n${YELLOW}==> $1${NC}"; }
warn() { echo -e "${RED}  ! $1${NC}"; }

# ─── 패키지 매니저 감지 ──────────────────────────────────────
detect_pkg_manager() {
    if command -v apt-get &>/dev/null; then echo "apt"
    elif command -v dnf &>/dev/null;     then echo "dnf"
    elif command -v yum &>/dev/null;     then echo "yum"
    elif command -v pacman &>/dev/null;  then echo "pacman"
    else echo "unknown"
    fi
}

install_pkgs() {
    case "$PKG_MGR" in
        apt)
            sudo apt-get update -qq
            sudo apt-get install -y -qq "$@"
            ;;
        dnf)
            sudo dnf install -y -q "$@"
            ;;
        yum)
            sudo yum install -y -q "$@"
            ;;
        pacman)
            sudo pacman -S --noconfirm --quiet "$@"
            ;;
        *)
            warn "Unknown package manager — skipping: $*"
            ;;
    esac
}

PKG_MGR=$(detect_pkg_manager)
ok "Package manager: $PKG_MGR"

# ─── apt 패키지 ──────────────────────────────────────────────
step "Installing system packages..."
case "$PKG_MGR" in
    apt)
        install_pkgs git curl python3 python3-pip fzf bat build-essential
        # Ubuntu에서 bat은 batcat으로 설치됨
        if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
            mkdir -p "$HOME/.local/bin"
            ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
            ok "bat → batcat symlinked"
        fi
        # lua: 5.4 → 5.3 → 5.1 순으로 시도
        LUA_PKG=""
        for v in lua5.4 lua5.3 lua5.1; do
            if apt-cache show "$v" &>/dev/null 2>&1; then
                LUA_PKG="$v"
                break
            fi
        done
        if [ -n "$LUA_PKG" ]; then
            install_pkgs "$LUA_PKG" "lib${LUA_PKG}-dev"
            ok "lua: $LUA_PKG"
        else
            warn "lua not found in apt — luarocks install may fail"
        fi
        ;;
    dnf|yum)
        install_pkgs git curl python3 python3-pip fzf bat gcc make lua lua-devel
        ;;
    pacman)
        install_pkgs git curl python python-pip fzf bat base-devel lua
        ;;
esac
ok "system packages"

# ─── lua include 경로 자동 감지 ──────────────────────────────
detect_lua_include() {
    for path in \
        /usr/include/lua5.4 \
        /usr/include/lua5.3 \
        /usr/include/lua5.1 \
        /usr/include/lua \
        /usr/local/include/lua5.4 \
        /usr/local/include/lua5.3 \
        /usr/local/include/lua
    do
        [ -f "$path/lua.h" ] && echo "$path" && return
    done
    echo ""
}

# ─── nix ─────────────────────────────────────────────────────
if ! command -v nix &>/dev/null; then
    step "Installing Nix (Determinate)..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
    ok "nix installed"
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
    . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# ─── nix 패키지 ──────────────────────────────────────────────
step "Installing nix packages..."
declare -A NIX_PKGS=( ["neovim"]="nvim" ["zoxide"]="zoxide" ["rustup"]="rustup" )
for pkg in "${!NIX_PKGS[@]}"; do
    bin="${NIX_PKGS[$pkg]}"
    if ! [ -f "$HOME/.nix-profile/bin/$bin" ]; then
        echo "  installing $pkg..."
        nix profile install "nixpkgs#$pkg" || warn "Failed to install $pkg via nix"
    fi
done
ok "nix packages"

# ─── rust stable ─────────────────────────────────────────────
if ! [ -f "$HOME/.cargo/bin/rustc" ]; then
    step "Setting up Rust stable toolchain..."
    RUSTUP_BIN="$HOME/.nix-profile/bin/rustup"
    [ -f "$RUSTUP_BIN" ] && "$RUSTUP_BIN" default stable || warn "rustup not found, skipping"
    ok "rust stable"
fi

# ─── oh-my-bash ──────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-bash" ]; then
    step "Installing oh-my-bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" "" --unattended
    ok "oh-my-bash"
fi

# ─── luarocks 3.x ────────────────────────────────────────────
if ! "$HOME/.local/bin/luarocks" --version 2>/dev/null | grep -q "3\." && \
   ! luarocks --version 2>/dev/null | grep -q "3\."; then
    step "Installing luarocks 3.x..."
    LUA_INCLUDE=$(detect_lua_include)
    if [ -z "$LUA_INCLUDE" ]; then
        warn "lua headers not found — skipping luarocks"
    else
        ok "lua include: $LUA_INCLUDE"
        LRVER="3.11.1"
        curl -sL "https://luarocks.org/releases/luarocks-${LRVER}.tar.gz" -o /tmp/luarocks.tar.gz
        tar -C /tmp -xzf /tmp/luarocks.tar.gz
        cd "/tmp/luarocks-${LRVER}"
        ./configure --prefix="$HOME/.local" --with-lua-include="$LUA_INCLUDE" --quiet
        make -s && make install -s
        cd "$OLDPWD"
        ok "luarocks ${LRVER}"
    fi
fi

# ─── hererocks ───────────────────────────────────────────────
if ! command -v hererocks &>/dev/null; then
    step "Installing hererocks..."
    python3 -m pip install -q hererocks
    ok "hererocks"
fi

# ─── 심볼릭 링크 (oh-my-bash 이후 복구) ─────────────────────
step "Linking dotfiles..."
files=(.aliasrc .bashrc .zshrc .zshenv .gitconfig .vimrc .profile .bash_local)
for f in "${files[@]}"; do
    if [ -f "$DOTFILES/$f" ]; then
        ln -sf "$DOTFILES/$f" "$HOME/$f"
        ok "linked $f"
    fi
done

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim" && ok "linked nvim config"
ln -sf "$DOTFILES/fish" "$HOME/.config/fish" && ok "linked fish config"

mkdir -p "$HOME/obsidian-vault"
ok "obsidian vault directory"

# ─── 완료 ────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Done!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  다음 단계:"
echo "  1. 터미널 재시작"
echo "  2. nvim 실행 → lazy.nvim 플러그인 자동 설치"
echo "  3. :Lazy sync"
echo ""
