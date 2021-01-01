# Variables
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/bin/vendor_perl:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

export EDITOR=vim
export BROWSER=firefox

# Python
if command -v pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# Local extensions
if [[ -e $HOME/.zshenv_local ]]; then
    source $HOME/.zshenv_local
fi
