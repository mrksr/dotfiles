#!/bin/sh

setxkbmap de
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
/usr/bin/VBoxClient-all
exec xmonad
