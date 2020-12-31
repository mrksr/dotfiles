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
### End of Zinit's installer chunk


# P10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Colors
zinit lucid for \
    atload"base16_railscasts" \
        chriskempson/base16-shell \


# Theme
zinit depth'1' light-mode for \
    atload'source ~/.p10k.zsh' \
        romkatv/powerlevel10k


# Programs
zinit light zinit-zsh/z-a-patch-dl
zinit pack"binary+keys" for fzf


# oh-my-zshell config
zinit wait lucid for \
    OMZL::correction.zsh \
    atinit"setopt auto_cd" \
        OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::spectrum.zsh \
    OMZL::termsupport.zsh \


# Plugins
zinit lucid for \
    atinit"
        ZSH_TMUX_FIXTERM=true
    " \
    OMZP::tmux

zinit wait lucid for \
    OMZP::vi-mode \
    OMZP::colored-man-pages \
    OMZP::extract \
    OMZP::git \
    OMZP::gitignore \
    OMZP::mosh \
    OMZP::screen

zinit wait as"completion" lucid for \
    OMZP::docker/_docker \
    OMZP::docker-compose/_docker-compose

zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    atinit" \
        zstyle ':autocomplete:*' min-delay 1
        zstyle ':autocomplete:tab:*' insert-unambiguous yes
        zstyle ':autocomplete:tab:*' widget-style menu-select
        zstyle ':autocomplete:tab:*' fzf-completion yes
    " \
        marlonrichert/zsh-autocomplete

zinit wait lucid for \
    atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
        trapd00r/LS_COLORS


# Own config
# Faster switching of vi modes
KEYTIMEOUT=1
# All the history...
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_SPACE
# ...and all the globs
setopt extendedglob
setopt null_glob

if command -v exa > /dev/null; then
    alias ls="exa --group-directories-first"
    alias ll="ls --long --group --header --git"
    alias l="ll --all"

    alias tree="exa --long --tree"
else
    alias ls="ls --color=tty --group-directories-first -h"
fi
alias lsd="ls -lhd */"
