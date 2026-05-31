# dotfiles

## 포함된 설정
- **shell**: bash, zsh, fish
- **nvim**: LazyVim 기반 커스텀 설정 (lazy.nvim)
- **git**: gitconfig
- **alias**: .aliasrc

---

## 사전 요구사항 (수동 설치 필요)

### 필수
| 항목 | 설치 방법 | 비고 |
|------|-----------|------|
| `git` | `sudo apt install git` | |
| `python3` | `sudo apt install python3 python3-pip` | hererocks 설치에 필요 |
| `nix` | [Determinate Nix](https://install.determinate.systems) | neovim 설치에 사용. 설치 후 **셸 재시작 필요** |
| `neovim 0.11+` | `nix profile install nixpkgs#neovim` | nix 재시작 후 실행 |
| `oh-my-bash` | `bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" "" --unattended` | .bashrc 테마/플러그인 의존성 |
| `zoxide` | `nix profile install nixpkgs#zoxide` | cd 대체 탐색 도구 |
| `rustup` | `nix profile install nixpkgs#rustup && rustup default stable` | .cargo/env 의존성 |

### 선택
| 항목 | 설치 방법 | 비고 |
|------|-----------|------|
| `fish` | `sudo apt install fish` | fish shell 쓸 경우 |
| `fzf` | `sudo apt install fzf` | 파일 탐색 |
| `bat` | `sudo apt install bat` | fzf 미리보기 |
| `luarocks 3.x` | 아래 참고 | neorg 의존성 |

### luarocks 3.x 수동 설치 (apt 버전은 2.x라 안 됨)
> `lua5.1` 헤더가 없을 경우 `lua5.3`으로 대체

```bash
sudo apt install -y lua5.3 liblua5.3-dev
curl -sL https://luarocks.org/releases/luarocks-3.11.1.tar.gz -o /tmp/luarocks.tar.gz
tar -C /tmp -xzf /tmp/luarocks.tar.gz
cd /tmp/luarocks-3.11.1
./configure --prefix=$HOME/.local --with-lua-include=/usr/include/lua5.3
make && make install
```

### hererocks 설치 (neorg rocks 의존성 자동 설치용)
```bash
python3 -m pip install hererocks
```

---

## 설치

```bash
git clone https://github.com/qwe179/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh`는 심볼릭 링크 생성 + neovim/hererocks 자동 설치까지 해줘요.
단, `oh-my-bash`, `zoxide`, `rustup`은 위 사전 요구사항에서 **먼저** 설치해야 해요.

---

## 설치 후

1. 터미널 재시작
2. `nvim` 실행 → lazy.nvim이 플러그인 자동 설치
3. nvim 안에서 `:Lazy sync` 로 플러그인 동기화

---

## 주의사항

- **github.com 접근이 막힌 서버**: `nix profile install nixpkgs#neovim` 실패할 수 있음
  - 대안: nix store에 이미 neovim이 있다면 `nix profile install /nix/store/<hash>-neovim-x.x.x` 으로 직접 설치
- **glibc 2.31 이하 서버**: neovim 공식 바이너리(.tar.gz) 사용 불가, nix로 설치해야 함
- `.env`, `.ssh` 등 민감한 파일은 이 레포에 포함되지 않음
