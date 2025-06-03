#!/usr/bin/env zsh

curl https://mise.run | MISE_QUIET=1 sh
eval "$(~/.local/bin/mise activate zsh)"
mise self-update --yes
mise upgrade --yes
mise prune --yes
