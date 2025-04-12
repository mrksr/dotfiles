#!/bin/sh

curl https://mise.run | MISE_QUIET=1 sh
eval "$(~/.local/bin/mise activate)"
mise self-update --yes
mise install --yes
mise upgrade --yes
