#!/bin/sh

# Settings
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
#setxkbmap de # moved to xorg.conf.d
xmodmap ~/.Xmodmap
xset -b
( sleep 60 ; /usr/bin/laptop_mode force ) &

# Programs
( sleep 5 ; start-pulseaudio-x11 ) &
dropboxd &
redshift -l 52.52:13.38 -t 6300:5300 &

# WM
exec xmonad
