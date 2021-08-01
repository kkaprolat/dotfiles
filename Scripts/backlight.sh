#!/bin/bash
if [ "$(hostname)" == Magnesium ]
then
        if [ "$1" == "inc" ]
        then
                xbacklight -inc 5
        elif [ "$1" == "dec" ]
        then
                xbacklight -dec 5
        fi
        NOW="$(xbacklight -get)"
        notify-send.py --replaces-process "backlight.sh"  "Brightness" "$NOW%" --hint int:value:$NOW
elif [ "$(hostname)" == Technetium ]
then
        if [ "$1" == "inc" ]
        then
                before=$(ddcutil getvcp 10 | sed 's/ //g' | sed 's/VCPcode0x10(Brightness):currentvalue=//' | sed 's/,maxvalue=100//')
                ddcutil setvcp 10 $((before + 5))
                AFTER=$((before + 5))
        elif [ "$1" == "dec" ]
        then
                before=$(ddcutil getvcp 10 | sed 's/ //g' | sed 's/VCPcode0x10(Brightness):currentvalue=//' | sed 's/,maxvalue=100//')
                ddcutil setvcp 10 $((before-5))
                AFTER=$((before-5))
        fi
        notify-send.py --replaces-process "backlight.sh"  "Brightness" "$AFTER%" --hint int:value:$NOW
fi
