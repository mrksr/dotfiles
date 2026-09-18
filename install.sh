#!/bin/sh

# This is an automatic setup script for Linuxy operating systems

# Ensure we have root
SUDO=""
if [ "$EUID" -ne 0 ]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo "ERROR: If not run as root, this script needs sudo."
    exit
  fi
fi

# Setup minimal environment for chezmoi
if command -v pacman >/dev/null 2>&1; then
  $SUDO pacman -Syu --noconfirm
  $SUDO pacman -S --noconfirm curl git zsh
fi
if command -v apt-get >/dev/null 2>&1; then
  $SUDO apt-get update
  $SUDO apt-get install --yes curl git zsh
fi

curl -fsSL https://mise.run | sh
export PATH=$HOME/.local/bin:$PATH

# Setup dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mrksr

# Install the rest of the environment
mise bootstrap
