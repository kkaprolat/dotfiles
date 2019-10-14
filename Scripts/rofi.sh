#!/bin/sh
 
rofi -show combi -normal-window &
# rofi -show run -font "Source Code Pro 10" --terminal konsole -normal-window -fullscreen &
 
sleep 0.4s
 
xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $(xdotool search -name rofi | grep $(xdotool getactivewindow) )
