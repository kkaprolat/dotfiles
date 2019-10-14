#! /bin/bash

pactl set-sink-volume 0 +3%
pactl set-sink-volume 1 +3%
notify-send --urgency=low --hint=string:x-dunst-stack-tag:volume "Volume : $(pactl list sink-inputs | grep -A15 -P "(\#|№)$SINK" | grep -P "\d+\s*\/\s*\d+\%" | head -1 | awk "{print \$5}")"
