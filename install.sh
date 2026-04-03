#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

echo "==> Installing dotfiles..."

# 심볼릭 링크 생성
files=(.aliasrc .bashrc .zshrc .zshenv .gitconfig .vimrc .profile .bash_local)
for f in "${files[@]}"; do
    if [ -f "$DOTFILES/$f" ]; then
        ln -sf "$DOTFILES/$f" "$HOME/$f"
        echo "  linked $f"
    fi
done

# config 폴더
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
echo "  linked nvim config"
ln -sf "$DOTFILES/fish" "$HOME/.config/fish"
echo "  linked fish config"

# nix 설치 확인
if ! command -v nix &>/dev/null; then
    echo "==> Installing Nix (Determinate)..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

# neovim 설치
if ! [ -f "$HOME/.nix-profile/bin/nvim" ]; then
    echo "==> Installing neovim via nix..."
    nix profile install nixpkgs#neovim
fi

# hererocks 설치 (neorg 의존성)
if ! command -v hererocks &>/dev/null; then
    echo "==> Installing hererocks..."
    python3 -m pip install hererocks
fi

echo ""
echo "Done! 터미널 재시작 후 nvim 실행하면 플러그인 자동 설치돼요."
