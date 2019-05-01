#!/bin/sh

#################
#  global init  #
#################
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

#############
#  Keyring  #
#############
# dbus-update-activation-environment --systemd DISPLAY
# eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# export GPG_AGENT_INFO SSH_AUTH_SOCK

#################
#  other files  #
#################
if [ -f ~/.Xresources ]; then
  xrdb -merge ~/.Xresources
fi

if [ -f ~/.xprofile ]; then
  . ~/.xprofile
fi

if [ -f ~/.xsession ]; then
  . ~/.xsession
fi

#NOTE: xmodmap moved to ~/.xsession

####################
#  Window Manager  #
####################
exec "$@"
