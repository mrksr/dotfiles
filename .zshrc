# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="_mine"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=( \
    archlinux \
    cp \
    debian \
    extract \
    last-working-dir \
    mercurial \
    python \
    sbt \
    scala \
    screen \
    vi-mode \
    wakeonlan \
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
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

# folder variables
repos=~/repos
uni=~/repos/uni
ba=~/repos/uni/13ba
bac=~/repos/uni/13ba/code
bat=~/repos/uni/13ba/thesis
tutor=~/repos/tutor
ds=~/repos/tutor/13ws.ds
dsha=~/repos/tutor/13ws.ds.ha
ml=~/repos/uni/13ws/machinelearning
auto=~/repos/uni/13ws/automata

# greeter
command -v fortune > /dev/null
if [ $? = 0 ]; then
    fortune -s;
    echo;
fi

# export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$HOME/.cabal/bin:/opt/procfun/sbt/bin:$PATH
export EDITOR=vim
export BROWSER=firefox

if [ -e .zshrc_local ]; then
    source .zshrc_local
fi
