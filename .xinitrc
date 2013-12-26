#!/bin/sh

##############
#  Settings  #
##############
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
#setxkbmap de # moved to xorg.conf.d
xmodmap ~/.Xmodmap
( sleep 45 ; /usr/bin/laptop_mode force ) &
# No beeping
xset -b
# Disable Touchpad when typing
( sleep 10 ; xuserrun syndaemon -k -i 1.5 -d ) &

##############
#  Programs  #
##############
( sleep 5 ; start-pulseaudio-x11 ) &
( sleep 5 ; dropboxd ) &
redshift -l 52.52:13.38 -t 6300:4800 &

####################
#  Window Manager  #
####################
exec xmonad
