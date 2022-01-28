#!/bin/sh

updatecount=$((checkupdates; yay -Qu;) | wc -l)
if [ updatecount > 0 ]
then
        echo $updatecount
fi
