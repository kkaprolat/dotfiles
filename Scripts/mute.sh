#! /bin/bash

pactl set-sink-mute 0 toggle

value=$(pulsemixer --id 0 --get-mute)

if [[ $value = '1' ]]; then
        dunstify -r 25336 --urgency=low "muted"
elif [[ $value = '0' ]]; then
        dunstify -r 25336 --urgency=low "unmuted"
else
        dunstify -r 25336 --urgency=low "Muting error occured"
fi
