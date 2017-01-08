# folder variables
hash -d uni=~/repos/uni
hash -d tutor=~/repos/tutor

hash -d bac=~/repos/uni/13ba/code
hash -d bat=~/repos/uni/13ba/thesis

hash -d idp=~/repos/uni/14ss/powerdiagrams
hash -d idpt=~/repos/uni/14ss/powerdiagrams.tex

hash -d mac=~/repos/uni/16ma/16ma.code/
hash -d mat=~/repos/uni/16ma/16ma.tex/thesis

# variables
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/.cabal/bin:$PATH
export EDITOR=vim
export BROWSER=firefox

if [[ -e $HOME/.zshenv_local ]]; then
    source $HOME/.zshenv_local
fi
