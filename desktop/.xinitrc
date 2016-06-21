#!/bin/sh

if [ -x ~/.xprofile ]; then
  . ~/.xprofile
fi

####################
#  Window Manager  #
####################
compton -b
exec "$@"
