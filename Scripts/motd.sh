#!/bin/bash
motdfile=$HOME/.motd
: > "$motdfile"
neofetch >> "$motdfile"
updatecount=$( (checkupdates; yay -Qu;) | wc -l)
if [ "$updatecount" != 0 ]
then
echo "    There are ${updatecount} updates available." >> "$motdfile"
dunstify Updates "${updatecount} updates are available." --icon="software-update-available-symbolic.symbolic"
fi
pacnewcount=$(find /etc -regextype posix-extended -regex ".+\.pacnew" 2> /dev/null | wc -l)
if [ "$pacnewcount" != 0 ]
then
echo "    There are ${pacnewcount} .pacnew-files to be merged." >> "$motdfile"
fi
sbstate=$( (mokutil --sb-state 2>&1) )
if [ "$sbstate" != "SecureBoot enabled" ]
then
echo "    SecureBoot is disabled!" >> "$motdfile"
fi
