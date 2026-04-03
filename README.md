# dotfiles

## 포함된 설정
- **shell**: bash, zsh, fish
- **nvim**: LazyVim 기반 커스텀 설정
- **git**: gitconfig
- **alias**: .aliasrc

## 새 서버에서 설치

```bash
git clone https://github.com/qwe179/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## install.sh 가 하는 것
1. 설정파일 심볼릭 링크 생성
2. Nix 설치 (없을 경우)
3. neovim 설치 (`~/.nix-profile/bin/nvim`)
4. hererocks 설치 (neorg 의존성)
