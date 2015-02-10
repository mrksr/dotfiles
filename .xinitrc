#!/bin/sh

[-x "~/.xprofile"] && . "~/.xprofile"

####################
#  Window Manager  #
####################
exec "$@"
