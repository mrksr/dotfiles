# Clone repos
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.hg_ext
hg clone http://bitbucket.org/sjl/hg-prompt/ ~/.hg_ext/hg-prompt

# Symlinks
ln -s ~/.zsh-theme ~/.oh-my-zsh/themes/_mine.zsh-theme
