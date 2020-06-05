#!/usr/bin/env bash

function run {
        if ! pgrep -f $1 ;
        then
                $@&
        fi
}

# color profiles
dispwin -d 1 $HOME/.color/profile.icm
dispwin -d 1 $HOME/.color/24g2u.icc
dispwin -d 2 $HOME/.color/p2214h.icm
# Network-Manager im Tray
run nm-applet
# # Polybar
# $HOME/.config/polybar/launch.sh
# Numlock an
run numlockx on
# Firefox
run firefox
# Steam
run steam
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
run udiskie --smart-tray --automount --file-manager=dolphin
# Farben für Glava
$HOME/Scripts/glavawal.sh &
# Farben für BSPWM
$HOME/Scripts/bspccolors.sh &
# Cursor richtig
run xsetroot -cursor_name left_ptr
# KDEConnect
run /usr/lib/kdeconnectd
# Sperrbildschirm
# run locker
run gnome-screensaver
run xss-lock "gnome-screensaver-command -l"
# Wacom-Setup
# xsetwacom set "Wacom Pen and multitouch sensor Finger touch" Gesture off
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Button 2 3
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Button 1 1
xsetwacom -s set "Wacom Pen and multitouch sensor Pen stylus" Threshold 1
# Batterieindikator
run cbatticon
# Bluetooth Tray
run blueman-tray
# syncthing
run syncthing-gtk
