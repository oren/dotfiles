#!/bin/sh

xset b off &
xrdb -merge ~/.Xdefaults &
setxkbmap dvorak 
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xset r rate 200 60 # typematic delay and rate &
i3
