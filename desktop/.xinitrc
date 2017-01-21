#!/bin/sh

#############
#  Keyring  #
#############
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

#################
#  other files  #
#################
if [ -x ~/.xprofile ]; then
  . ~/.xprofile
fi

if [ -x ~/.xsession ]; then
  . ~/.xsession
fi

####################
#  Window Manager  #
####################
exec "$@"
