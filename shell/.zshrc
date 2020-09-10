#################################
#  Ensure Oh-My-ZSH is present  #
#################################
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
fi
if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/fzf-tab" ]]; then
    git clone https://github.com/Aloxaf/fzf-tab $HOME/.oh-my-zsh/custom/plugins/fzf-tab
fi


#####################
#  Version Fallbck  #
#####################
autoload is-at-least
if is-at-least "5.1" $ZSH_VERSION; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
    if [[ -f $HOME/.p10k.zsh ]]; then
        source $HOME/.p10k.zsh
    fi;

    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
else
    # NOTE(mrksr): Fallback to own theme
    ZSH_THEME="../../"
fi


#################
#  Colorscheme  #
#################
source $HOME/.base16-railscasts.sh


#################################
#  Oh-My-ZSH pre-configuration  #
#################################
ZSH=$HOME/.oh-my-zsh

plugins=( \
    # Load vi-mode first to avoid hotkey-breakage...
    vi-mode \
    # ...otherwise order should not matter
    colored-man-pages \
    docker \
    docker-compose \
    extract \
    fasd \
    fzf \
    git \
    gitignore \
    mercurial \
    mosh \
    pass \
    pip \
    python \
    screen \
    tmux \
    wakeonlan \
)
if command -v fzf > /dev/null; then
    plugins+=(fzf-tab)
fi
# DISABLE_MAGIC_FUNCTIONS=true

# Set ls-colors for highlighting if present
if [[ -e .dircolors ]]; then
    eval "$(dircolors .dircolors)"
fi


####################
#  Oh-My-ZSH load  #
####################
source $ZSH/oh-my-zsh.sh


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
setopt null_glob

# Use fzf-tab after second tab press
fzf-tab-partial-and-complete() {
    if [[ $LASTWIDGET = 'fzf-tab-partial-and-complete' ]]; then
        fzf-tab-complete
    else
        zle complete-word
    fi
}

zle -N fzf-tab-partial-and-complete
bindkey '^I' fzf-tab-partial-and-complete


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


########################
#  Alias and Commands  #
########################
alias dmesg="dmesg --color=auto"

if command -v exa > /dev/null; then
    alias ls="exa --group-directories-first"
    alias ll="ls --long --group --header --git"
    alias l="ll --all"

    alias tree="exa --long --tree"
else
    alias ls="ls --color=tty --group-directories-first -h"
fi
alias lsd="ls -lhd */"

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


#############
#  Startup  #
#############
if command -v bat > /dev/null; then
    alias cat="bat"
fi

if command -v nvim > /dev/null; then
    alias vim="nvim"
fi

if command -v aria2c > /dev/null; then
    alias youtube-dl="youtube-dl \
        --external-downloader aria2c \
        --external-downloader-args '-c -j 5 -x 5 -s 5 -k 2M' \
        "
fi


##################
#  Local .zshrc  #
##################
if [[ -e .zshrc_local ]]; then
    source .zshrc_local
fi
