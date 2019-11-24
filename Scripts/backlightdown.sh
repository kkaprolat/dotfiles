#!/bin/bash
xbacklight -dec 5
notify-send "Brightness" $(xbacklight -get)
