#!/bin/sh

curl https://mise.run | MISE_QUIET=1 sh
~/.local/bin/mise install --yes
