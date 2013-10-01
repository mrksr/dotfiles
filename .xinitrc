#!/bin/sh

# Settings
setxkbmap de
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# Daemons
/usr/bin/VBoxClient-all &
devmon &
dropboxd &

# WM
exec xmonad
