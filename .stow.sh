#!/usr/bin/env bash

for dir in "$@"
do
    echo "###############"
    echo "Directory: $dir"
    echo "###############"
    # Some sanity checking
    if [[ ! -d "./$dir" ]]; then
        echo "Folder '$dir' does not exist."
        continue
    fi

    # Create Folder Structure
    echo "Ensuring the folders exist in ~"
    echo "-------------------------------"
    (cd $dir && find . -type d -exec echo "{}" \; -exec mkdir -p "$HOME/{}" \;)

    echo "Running stow $dir"
    echo "-----------------"
    stow $dir
done
