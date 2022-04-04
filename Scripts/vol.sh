#! /bin/bash
# see https://unix.stackexchange.com/questions/132230/read-out-pulseaudio-volume-from-commandline-i-want-pactl-get-sink-volume
if [ "$1" == "inc" ]
then
        pactl set-sink-volume $(pactl get-default-sink) +3%
elif [ "$1" == "dec" ]
then
        pactl set-sink-volume $(pactl get-default-sink) -3%
elif [ "$1" == "mute" ]
then
        pactl set-sink-mute $(pactl get-default-sink) toggle
else
        echo "invalid parameter"
        exit 1
fi
NOW=$(pactl get-sink-volume $(pactl get-default-sink) | grep -Eo '[[:digit:]]{1,3}%' | sed 's/%//g' | uniq)
MUTE=$(pactl get-sink-mute $(pactl get-default-sink) | sed 's/Mute: //g' | sed 's/no/unmuted/' | sed 's/yes/muted/')

if [ "$NOW" -le 20 ]
then
        ICON="audio-volume-low-symbolic"
        MSG="$NOW%"
elif [ "$NOW" -le 60 ]
then
        ICON="audio-volume-medium-symbolic"
        MSG="$NOW%"
elif [ "$NOW" -le 100 ]
then
        ICON="audio-volume-high-symbolic"
        MSG="$NOW%"
else
        ICON="audio-volume-overamplified-symbolic"
        MSG="$NOW%"
fi

if [ "$MUTE" == 'muted' ] || [ "$NOW" == 0 ]
then
        ICON="audio-volume-muted-symbolic"
        MSG="muted"
fi
notify-send.py --replaces-process "vol.sh"  "Volume" "$MSG" -i $ICON --hint int:has-percentage:$NOW
