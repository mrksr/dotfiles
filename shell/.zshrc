### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
    print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# NOTE(mrksr): Disable compinit unsecure folder security feature to avoid
# annoying issues with sudo.
ZINIT[COMPINIT_OPTS]="-C -i"

# P10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# vi-mode
zinit lucid for \
    atinit"KEYTIMEOUT=1" \
        OMZP::vi-mode


# Colors and theme
zinit lucid for \
    atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
        trapd00r/LS_COLORS \
    atload"base16_railscasts" \
        chriskempson/base16-shell

zinit depth'1' light-mode for \
    atload'source ~/.p10k.zsh' \
        romkatv/powerlevel10k


# Ensure fzf
zinit pack"bgn-binary+keys" for fzf


# oh-my-zshell config
zinit wait lucid for \
    OMZL::correction.zsh \
    atinit"setopt auto_cd" \
        OMZL::directories.zsh \
    atinit"
        HISTSIZE=1000000
        SAVEHIST=1000000
    " \
    OMZL::history.zsh \
    OMZL::spectrum.zsh \
    OMZL::termsupport.zsh


# Plugins
zinit wait lucid for \
    OMZP::colored-man-pages \
    OMZP::extract \
    OMZP::fasd \
    OMZP::git \
    OMZP::gitignore \
    OMZP::mosh \
    OMZP::screen

zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    atinit"
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*:git-checkout:*' sort false
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always \$realpath'
    " \
    atload"
        # Use fzf-tab after second tab press
        fzf-tab-partial-and-complete() {
            if [[ \$LASTWIDGET = 'fzf-tab-partial-and-complete' ]]; then
                fzf-tab-complete
            else
                zle complete-word
            fi
        }

        zle -N fzf-tab-partial-and-complete
        bindkey '^I' fzf-tab-partial-and-complete
    " \
    Aloxaf/fzf-tab \
    MichaelAquilina/zsh-autoswitch-virtualenv


# Own config
# ...and all the globs
setopt extendedglob
setopt null_glob

if command -v exa > /dev/null; then
    alias ls="exa --icons --group-directories-first"
    alias ll="ls --long --group --header --git"
    alias l="ll --all"

    alias tree="exa --long --tree"
else
    alias ls="ls --color=tty --group-directories-first -h"
fi
alias lsd="ls -lhd */"

alias open="open-background"
open-background() {
    xdg-open "$@" &>/dev/null &!
}

alias texdoco="online-texdoc"
online-texdoc() {
    DOC_FILE="${TMPDIR:-/tmp}/online_texdoc.${1}.pdf"
    if [[ ! -f "$DOC_FILE" ]]; then
        wget http://texdoc.net/pkg/${1} -O "$DOC_FILE"
    fi
    open-background "$DOC_FILE"
}

if command -v bat > /dev/null; then
    alias cat="bat"
fi

if command -v nvim > /dev/null; then
    alias vim="nvim"
    export MANPAGER="nvim -c 'set ft=man'"
fi

if command -v aria2c > /dev/null; then
    alias youtube-dl="youtube-dl \
        --external-downloader aria2c \
        --external-downloader-args '-c -j 5 -x 5 -s 5 -k 2M' \
        "
fi
