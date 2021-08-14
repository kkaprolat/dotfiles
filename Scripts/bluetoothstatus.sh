#!/bin/sh
if [ "$(hostname)" == Magnesium ]
then
        status=$(rfkill list bluetooth | grep "Soft blocked" | tr -d "[:space:]" | sed "s/Softblocked://g")

        if [ "$status" == 'yes' ] # bluetooth off
        then
                echo ""
        else # bluetooth on
                data=$(bluetoothctl -- info)
                if [ "$data" != "Missing device address argument" ]
                then
                        echo "" # connected
                else
                        echo "" # disconnected
                fi
        fi
fi
