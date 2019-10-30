#!/bin/bash
xbacklight -dec 10
notify-send "Brightness" $(xbacklight -get)
