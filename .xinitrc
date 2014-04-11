#!/bin/sh

##############
#  Settings  #
##############
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap -layout de -variant nodeadkeys
xmodmap ~/.Xmodmap
( sleep 45 ; /usr/bin/laptop_mode force ) &
# No beeping
xset -b
# Disable Touchpad when typing
( sleep 0.5 ; syndaemon -k -t -i 1 -d ) &
( sleep 1 ; synclient TouchpadOff=1 ) &
( sleep 1 ; synclient PalmDetect=1 ) &
# Use GPG-agent
eval $(gpg-agent --daemon)

##############
#  Programs  #
##############
( sleep 5 ; start-pulseaudio-x11 ) &
#( sleep 5 ; dropboxd ) &
redshift -l 52.52:13.38 -t 6300:4800 &

####################
#  Window Manager  #
####################
exec xmonad
