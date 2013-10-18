#!/bin/sh

##############
#  Settings  #
##############
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
#setxkbmap de # moved to xorg.conf.d
xmodmap ~/.Xmodmap
( sleep 60 ; /usr/bin/laptop_mode force ) &
# No beeping
xset -b
# Disable Touchpad when typing
syndaemon -t -k -i 1.5 -d

##############
#  Programs  #
##############
( sleep 8 ; start-pulseaudio-x11 ) &
( sleep 8 ; dropboxd ) &
redshift -l 52.52:13.38 -t 6300:5300 &

##############
#  Programs  #
##############
exec xmonad
