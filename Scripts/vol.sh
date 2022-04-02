#! /bin/bash
# see https://unix.stackexchange.com/questions/132230/read-out-pulseaudio-volume-from-commandline-i-want-pactl-get-sink-volume
if [ "$1" == "inc" ]
then
        pactl set-sink-volume $(pactl get-default-sink) +3%
        NOW=$(pactl get-sink-volume $(pactl get-default-sink) | grep -Eo '[[:digit:]]{1,3}%' | sed 's/%//g' | uniq)
elif [ "$1" == "dec" ]
then
        pactl set-sink-volume $(pactl get-default-sink) -3%
        NOW=$(pactl get-sink-volume $(pactl get-default-sink) | grep -Eo '[[:digit:]]{1,3}%' | sed 's/%//g' | uniq)
else
        echo "invalid parameter"
        exit 1
fi
if [ "$NOW" -le 20 ]
then
        ICON="audio-volume-low-symbolic"
elif [ "$NOW" -le 60 ]
then
        ICON="audio-volume-medium-symbolic"
else
        ICON="audio-volume-high-symbolic"
fi
notify-send.py  --replaces-process "vol.sh"  "Volume" "$NOW%" --hint int:has-percentage:$NOW string:image-path:"$ICON"
