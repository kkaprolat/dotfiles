#! /bin/bash
# see https://unix.stackexchange.com/questions/132230/read-out-pulseaudio-volume-from-commandline-i-want-pactl-get-sink-volume
if [ "$1" == "inc" ]
then
        NOW=$(amixer sset 'Master' 3%+ | grep 'Front Left:' | tr -d '[:space:]' | sed 's/FrontLeft:Playback[0-9]*\[//g' | sed 's/%\]\[[a-z]*\]//g')
fi
if [ "$1" == "dec" ]
then
        NOW=$(amixer sset 'Master' 3%- | grep 'Front Left:' | tr -d '[:space:]' | sed 's/FrontLeft:Playback[0-9]*\[//g' | sed 's/%\]\[[a-z]*\]//g')
fi
notify-send.py --replaces-process "vol.sh"  "Volume : $NOW%" --hint int:value:$NOW
