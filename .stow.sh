#!/usr/bin/env bash

# If stow does not exist on the system, get it from
# http://ftp.download-by.net/gnu/gnu/stow/stow-latest.tar.gz

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
