#! /bin/bash

pactl set-sink-mute @DEFAULT_SINK@ toggle

value=$(pulsemixer --id 0 --get-mute)

if [[ $value = '1' ]]; then
        notify-send "muted"
elif [[ $value = '0' ]]; then
        notify-send "unmuted"
else
        notify-send "Muting error occured"
fi
