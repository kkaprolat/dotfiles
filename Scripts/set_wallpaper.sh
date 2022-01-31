#!/bin/bash
# machine specific code
# hostname requires inetutils
pkill swaybg
if [ $(hostname) == Magnesium ]
then
        wallpaperlocation="$HOME/Wallpapers"
        wallpaper1=$(find -L $wallpaperlocation -type f | sort -R | head -n 1)
        swaybg -m fill -o 'eDP-1' --image $wallpaper1
        echo $wallpaper1 > /tmp/session_wallpapers
elif [ $(hostname) == Technetium ]
then
        wallpaperlocation="/run/media/kay/D0-P1/Bibliotheken/Bilder/Wallpaper/dump"
        wallpaper1=$(find -L $wallpaperlocation -type f | sort -R | head -n 1)
        wallpaper2=$(find -L $wallpaperlocation -type f | sort -R | head -n 1)
        swaybg -m fill -o 'HDMI-0' --image $wallpaper1
        swaybg -m fill -o 'DP-0' --image $wallpaper2
        echo $wallpaper1 > /tmp/session_wallpapers
        echo $wallpaper2 >> /tmp/session_wallpapers
fi

