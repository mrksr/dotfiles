#!/usr/bin/env bash

# Some sanity checking
[[ -d "./$1" ]] || (echo "Folder '$1' does not exist."; exit 1)

# Create Folder Structure
echo "###############################"
echo "Ensuring the folders exist in ~"
echo "###############################"
(cd $1 && find . -type d -exec echo "{}" \; -exec mkdir -p "$HOME/{}" \;)

echo "###############"
echo "Running stow $1"
echo "###############"
stow -vv $1
