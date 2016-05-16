# folder variables
hash -d uni=~/repos/uni
hash -d bac=~/repos/uni/13ba/code
hash -d bat=~/repos/uni/13ba/thesis
hash -d tutor=~/repos/tutor

hash -d idp=~/repos/uni/14ss/powerdiagrams
hash -d idpt=~/repos/uni/14ss/powerdiagrams.tex

# variables
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/.cabal/bin:$PATH
export EDITOR=vim
export BROWSER=firefox

if [[ -e .zshenv_local ]]; then
    source .zshenv_local
fi
