#!/bin/bash
motdfile=$HOME/.motd
: > $motdfile
neofetch >> $motdfile
updatecount=$((checkupdates; yay -Qu;) | wc -l)
if [ $updatecount != 0 ]
then
echo "    There are ${updatecount} updates available." >> $motdfile
notify-send.py Updates "${updatecount} updates are available." --hint string:image-path:software-update-available
fi
pacnewcount=$(find /etc -regextype posix-extended -regex ".+\.pacnew" 2> /dev/null | wc -l)
if [ $pacnewcount != 0 ]
then
echo "    There are ${pacnewcount} .pacnew-files to be merged." >> $motdfile
fi
