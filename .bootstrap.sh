# Clone repos
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# .vim_local for undodir
mkdir -p ~/.vim_local/undodir

# Symlinks
ln -s ~/.zsh-theme ~/.oh-my-zsh/themes/_mine.zsh-theme
