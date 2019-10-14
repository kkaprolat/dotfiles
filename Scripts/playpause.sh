#! /bin/bash

mpc toggle
notify-send --urgency=low --hint=string:x-dunst-stack-tag:song "Now playing" "$(mpc current)"
