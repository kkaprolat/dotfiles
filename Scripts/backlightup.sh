#!/bin/bash
xbacklight -inc 5
notify-send "Brightness" $(xbacklight -get)
