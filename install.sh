#!/bin/sh

# This is an automatic setup script written for GitHub codespaces.

# Ensure we have zsh
if ! command -v zsh > /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install | sudo bash -s -- -d /usr/local -e yes
fi

# Setup dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mrksr
