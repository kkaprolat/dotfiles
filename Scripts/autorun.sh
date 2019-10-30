#!/usr/bin/env bash

function run {
        if ! pgrep -f $1 ;
        then
                $@&
        fi
}

# Farbprofil
dispwin -d 1 $HOME/.color/profile.icm &
# Network-Manager im Tray
run nm-applet
# # Polybar
# $HOME/.config/polybar/launch.sh
# Compositor
compton -c -f --backend glx --blur-method kawase --blur-strength 10 --config $HOME/.config/compton/compton.conf &
# Numlock an
numlockx on &
# Firefox
GTK_USE_PORTAL=1 firefox &
# Steam
run steam-native
# Policykit
run /usr/bin/lxqt-policykit-agent
# Redshift
run redshift-gtk
# Thunderbird
run thunderbird
# NCMPCPP (Music)
# run alacritty --class "ncmpcpp" -t "ncmpcpp" -e ncmpcpp
# Clementine (Music)
run clementine
# Keepass
run keepassxc
# Dunst (Notifications)
# run dunst
# Udiskie (automount)
run udiskie --smart-tray
# Farben für Glava
$HOME/Scripts/glavawal.sh &
# Farben für BSPWM
$HOME/Scripts/bspccolors.sh &
# Flashfocus
run flashfocus
# Cursor richtig
xsetroot -cursor_name left_ptr &
# KDEConnect
run /usr/lib/kdeconnectd
# Sperrbildschirm
run light-locker
# Wacom-Setup
xsetwacom set "Wacom Pen and multitouch sensor Finger touch" Gesture off
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Button 2 3
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Button 1 1
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Threshold 1
# Batterieindikator
run cbatticon
# Compressor
run pulseeffects
