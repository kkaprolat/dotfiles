#! /bin/bash
# for MPD
mpc toggle
notify-send --urgency=low --hint=string:x-dunst-stack-tag:song "Now playing" "$(mpc current)"
# for Clementine
# clementine --play-pause
