#################################
#  Oh-My-ZSH pre-configuration  #
#################################
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="_mine"
plugins=( \
    # archlinux \
    # cp \
    # debian \
    extract \
    #last-working-dir \
    mercurial \
    git \
    python \
    # sbt \
    # scala \
    screen \
    tmux \
    vi-mode \
    wakeonlan \
)

####################
#  Oh-My-ZSH load  #
####################
source $ZSH/oh-my-zsh.sh

################
#  Own config  #
################
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_SPACE

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
alias syc="synergyc --crypto-pass 9ff70869157819ffddb6a2acbfd0ee64 192.168.2.42"
alias dmesg="dmesg -L auto"
alias fzf="fzf -x"

alias ls="ls --color=tty --group-directories-first -h"
alias lsd="ls -lhd */"

alias vga="xrandr --output VGA-0 --right-of LVDS-0 --auto"
alias novga="xrandr --output VGA-0 --off"

alias imap="offlineimap -u basic -o"

alias open="open-background"
open-background() {
    xdg-open "$@" >/dev/null 2>&1 &!
}
alias pdf="open-pdf"
open-pdf() {
    local PREFIX=$(eval echo "${1:-.}")
    local FILE="$(cd $PREFIX;
        find . -name '*.pdf' \
        | fzf -x )";
    if [[ -n "$FILE" ]]; then
        open "$PREFIX/$FILE" > /dev/null
        echo "$PREFIX/$FILE"
    fi
}

bell_before_command() {
    echo -ne '\a'
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions bell_before_command)

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