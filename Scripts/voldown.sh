#! /bin/bash
# see https://unix.stackexchange.com/questions/132230/read-out-pulseaudio-volume-from-commandline-i-want-pactl-get-sink-volume
SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
pactl set-sink-volume $SINK -3%
NOW=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
notify-send --urgency=low --hint=string:x-dunst-stack-tag:volume "Volume : $NOW%"
