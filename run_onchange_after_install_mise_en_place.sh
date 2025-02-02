#!/bin/sh

curl https://mise.run | MISE_QUIET=1 sh
~/.local/bin/mise self-update --yes
~/.local/bin/mise install --yes
~/.local/bin/mise upgrade --yes
