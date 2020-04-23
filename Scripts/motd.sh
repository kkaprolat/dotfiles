#!/bin/bash
motdfile=$HOME/.motd
: > $motdfile
neofetch >> $motdfile
updatecount=$(checkupdates | wc -l)
if [ $updatecount != 0 ]
then
echo "    There are ${updatecount} updates available." >> $motdfile
fi
