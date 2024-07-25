#!/bin/sh

asdf plugin update --all

asdf plugin add bat
asdf plugin add bottom
asdf plugin add delta
asdf plugin add eza
asdf plugin add fzf
asdf plugin add python
asdf plugin add ripgrep
asdf plugin add starship

asdf install bat latest
asdf install bottom latest
asdf install delta latest
asdf install eza latest
asdf install fzf latest
asdf install ripgrep latest
asdf install starship latest

asdf global bat latest
asdf global bottom latest
asdf global delta latest
asdf global eza latest
asdf global fzf latest
asdf global ripgrep latest
asdf global starship latest
