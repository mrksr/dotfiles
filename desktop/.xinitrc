#!/bin/sh

#############
#  Keyring  #
#############
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

#############
#  X stuff  #
#############
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

##############
#  xprofile  #
##############
if [ -x ~/.xprofile ]; then
  . ~/.xprofile
fi

#############
#  Autorun  #
#############
dex -a &

####################
#  Window Manager  #
####################
compton -b
exec "$@"
