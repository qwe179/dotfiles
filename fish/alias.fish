alias tree='tree -C'
alias v='~/.nix-profile/bin/nvim'
alias v.='~/.nix-profile/bin/nvim .'
alias nvim='~/.nix-profile/bin/nvim'

alias g='git'

function vf
    ~/.nix-profile/bin/nvim (fzf -m --preview 'bat --style=numbers --color=always {}')
end

function zf
    set dir (find . -type d -print | fzf) || return
    z $dir
end


bind \cf zf
