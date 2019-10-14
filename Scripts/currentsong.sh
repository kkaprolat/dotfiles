#! /bin/bash

notify-send --urgency=low --hint=string:x-dunst-stack-tag-song: "Now Playing" "$(mpc current)"
