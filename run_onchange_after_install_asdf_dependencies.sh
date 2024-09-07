#!/bin/sh

export ASDF_DIR=~/.asdf
. ~/.asdf/asdf.sh

asdf plugin update --all

asdf plugin add bat
asdf plugin add bottom
asdf plugin add chezmoi
asdf plugin add delta
asdf plugin add dust
asdf plugin add eza
asdf plugin add fd
asdf plugin add fzf
asdf plugin add python
asdf plugin add ripgrep
asdf plugin add starship

asdf install bat latest &
asdf install bottom latest &
asdf install chezmoi latest &
asdf install delta latest &
asdf install dust latest &
asdf install eza latest &
asdf install fd latest &
asdf install fzf $(asdf list all fzf | tail -n 1) &
asdf install ripgrep latest &
asdf install starship latest &

wait

asdf global bat latest
asdf global bottom latest
asdf global chezmoi latest
asdf global delta latest
asdf global dust latest
asdf global eza latest
asdf global fd latest
asdf global fzf $(asdf list all fzf | tail -n 1)
asdf global ripgrep latest
asdf global starship latest
