#!/bin/bash
motdfile=$HOME/.motd
: > "$motdfile"
neofetch >> "$motdfile"
