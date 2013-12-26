# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="_mine"

# Plugins
plugins=( \
    archlinux \
    cp \
    debian \
    extract \
    #last-working-dir \
    mercurial \
    python \
    sbt \
    scala \
    screen \
    vi-mode \
    wakeonlan \
)

source $ZSH/oh-my-zsh.sh

# Stuff 'n Stuff
HISTSIZE=100000
SAVEHIST=100000

setopt extendedglob

set -o vi
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

alias apt-get="sudo apt-get"
alias apt-search="apt-cache search"
alias apt-find="apt-search"
alias apt-install="apt-get install"
alias apt-upgrade="apt-get upgrade"
alias apt-update="apt-get update"
alias apt-remove="apt-get remove"
alias apt-list="dpkg --list-selections"
alias apt-filesearch="apt-find search"
alias vnc="vncviewer 192.168.2.42"
alias dmesg="dmesg -L auto"
alias fzf="fzf -x"
alias pdf="open-pdf"
open-pdf() {
    local PREFIX=$(eval echo "${1:-.}")
    local FILE="$(cd $PREFIX;
        find . -name '*.pdf' \
        | fzf )";
    if [[ -n "$FILE" ]]; then
        zathura "$PREFIX/$FILE"
        echo -n "$PREFIX/$FILE"
    fi
}

# greeter
if command -v fortune > /dev/null; then
    fortune -s;
    echo;
fi

if command -v fzf > /dev/null; then
    if [[ -e .fzf.zsh ]]; then
        source .fzf.zsh
    fi
fi

if [[ -e .zshrc_local ]]; then
    source .zshrc_local
fi
