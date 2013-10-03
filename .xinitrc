#!/bin/sh

# Settings
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap de
xmodmap ~/.Xmodmap
xset -b

# Programs
start-pulseaudio-x11

# WM
exec xmonad
