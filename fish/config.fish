if status is-interactive

    set -g fish_greeting "Welcome back, $USER 🐟"
    # Commands to run in interactive sessions can go here

    zoxide init fish | source

    alias vim 'nvim'
    alias ll 'ls -la'
    alias la 'ls -la'


# --- Exports ---
set -x PATH $HOME/.cargo/bin $BUN_INSTALL/bin $PATH
set -x BUN_INSTALL $HOME/.bun
set -x EDITOR nvim

# --- Aliases ---
alias c 'clear'
alias l 'eza -lh --icons=auto'
alias ls 'eza -1 --icons=auto'
alias ll 'eza -lha --icons=auto --sort=name --group-directories-first'
alias ld 'eza -lhD --icons=auto'
alias lt 'eza --icons=auto --tree'

alias un '$aurhelper -Rns'
alias up '$aurhelper -Syu'
alias pl '$aurhelper -Qs'
alias pa '$aurhelper -Ss'
alias pc '$aurhelper -Sc'
alias po '$aurhelper -Qtdq | $aurhelper -Rns -'

alias vc 'code'
alias vim 'nvim'
alias aa 'startx'
alias rm 'trash -v'
alias hx 'helix'

alias .. 'cd ..'
alias ... 'cd ../..'
alias .3 'cd ../../..'
alias .4 'cd ../../../..'
alias .5 'cd ../../../../..'

alias mkdir 'mkdir -p'

function cdf
    set dir (find . -maxdepth 3 -type d | fzf)
    if test -n "$dir"
        cd "$dir"
    end
end

function lazyg
    git add .
    git commit -m "$argv"
    git push
end

end
