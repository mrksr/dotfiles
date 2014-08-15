#!/bin/sh

##############
#  Settings  #
##############
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap -layout de -variant nodeadkeys
xmodmap ~/.Xmodmap
# No beeping
xset -b
# Disable Touchpad when typing
( sleep 0.5 ; syndaemon -k -t -i 1 -d ) &
( sleep 1 ; synclient TouchpadOff=1 ) &
( sleep 1 ; synclient PalmDetect=1 ) &

############
#  Daemons #
############
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

##############
#  Programs  #
##############
( sleep 5 ; start-pulseaudio-x11 ) &
#( sleep 5 ; dropboxd ) &
redshift -l 59.20:18.3 -t 6300:4800 &

####################
#  Window Manager  #
####################
exec xmonad
