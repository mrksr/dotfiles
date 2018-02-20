#################################
#  Ensure Oh-My-ZSH is present  #
#################################
[[ -d "$HOME/.oh-my-zsh" ]] || git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

#################################
#  Oh-My-ZSH pre-configuration  #
#################################
ZSH=$HOME/.oh-my-zsh

# Hack to use the theme in $HOME
ZSH_THEME="../../"
plugins=( \
    colored-man-pages \
    docker \
    docker-compose \
    extract \
    fasd \
    git \
    gitignore \
    mercurial \
    mosh \
    pass \
    pip \
    python \
    screen \
    tmux \
    vi-mode \
    wakeonlan \
)

####################
#  Oh-My-ZSH load  #
####################
source $ZSH/oh-my-zsh.sh

#################
#  Colorscheme  #
#################
. $HOME/.base16-eighties.dark.sh

################
#  Own config  #
################
# Faster switching of vi modes
KEYTIMEOUT=1
# All the history...
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_SPACE
# ...and all the globs
setopt extendedglob

########################
#  Alias and Commands  #
########################
alias apt-get="sudo apt-get"
alias apt-search="apt-cache search"
alias apt-find="apt-search"
alias apt-install="apt-get install"
alias apt-upgrade="apt-get upgrade"
alias apt-update="apt-get update"
alias apt-remove="apt-get remove"
alias apt-list="dpkg --list-selections"
alias apt-filesearch="apt-find search"

alias dmesg="dmesg --color=auto"
alias fzf="fzf -x"

if command -v exa > /dev/null; then
    alias ls="exa --group-directories-first"
    alias ll="ls --long --group --header --git"
    alias l="ll --all"

    alias tree="exa --long --tree"
else
    alias ls="ls --color=tty --group-directories-first -h"
fi
alias lsd="ls -lhd */"

alias vga="xrandr --output DP2 --right-of eDP1 --auto"
alias novga="xrandr --output DP2 --off"

alias bl="set-backlight"
set-backlight() {
    xbacklight -set $1
}

alias open="open-background"
open-background() {
    xdg-open "$@" >/dev/null 2>&1 &!
}
alias pdf="open-pdf"
open-pdf() {
    local PREFIX=${2:-.}
    local FILE="$(cd $PREFIX;
        find . -name '*.pdf' \
        | fzf -x --select-1 -q "$1" )";
    if [[ -n "$FILE" ]]; then
        open "$PREFIX/$FILE" > /dev/null
        echo "$PREFIX/$FILE"
    fi
}

alias texdoco="online-texdoc"
online-texdoc() {
    DOC_FILE="${TMPDIR:-/tmp}/online_texdoc.${1}.pdf"
    if [[ ! -f "$DOC_FILE" ]]; then
        wget http://texdoc.net/pkg/${1} -O "$DOC_FILE"
    fi
    open-background "$DOC_FILE"
}

alias mail="mbsync-update"
mbsync-update() {
    SET="${1:-auto}"
    mbsync $SET
    notmuch new
}

##################
#  zsh bindings  #
##################
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bell_before_command() {
    echo -ne '\a'
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions bell_before_command)

#############
#  Startup  #
#############
if command -v fortune > /dev/null; then
    fortune -s;
    echo;
fi

if command -v fzf > /dev/null; then
    if [[ -e .fzf.zsh ]]; then
        source .fzf.zsh
    fi
fi

##################
#  Local .zshrc  #
##################
if [[ -e .zshrc_local ]]; then
    source .zshrc_local
fi
