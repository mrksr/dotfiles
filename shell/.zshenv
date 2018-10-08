# folder variables
hash -d uni=~/repos/uni
hash -d bac=~/repos/uni/13ba/code
hash -d bat=~/repos/uni/13ba/thesis
hash -d tutor=~/repos/tutor

hash -d idp=~/repos/uni/14ss/powerdiagrams
hash -d idpt=~/repos/uni/14ss/powerdiagrams.tex

# variables
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/bin/vendor_perl:$PATH
export EDITOR=vim
export BROWSER=firefox

# local stuff
export LD_LIBRARY_PATH=$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

if [[ -e $HOME/.zshenv_local ]]; then
    source $HOME/.zshenv_local
fi
