#!/bin/bash
if [ $(hostname) == Magnesium ]
then
        xbacklight -inc 5
        notify-send "Brightness" $(xbacklight -get)
fi
if [ $(hostname) == Technetium ]
then
        before=$(ddcutil getvcp 10 | sed 's/ //g' | sed 's/VCPcode0x10(Brightness):currentvalue=//' | sed 's/,maxvalue=100//')
        ddcutil setvcp 10 $(($before + 5))
        after=$(($before + 5))
        notify-send "Brightness" $after
fi


