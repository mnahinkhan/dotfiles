#!/usr/bin/env bash

# Check current time and set Terminal profile accordingly
currenttime=$(date +%H)
if [[ "10#$currenttime" -gt 17 ]] || [[ "10#$currenttime" -lt 6 ]]; then
    ~/bin/setTerm dark;
    tmux source-file ~/.tmux/dark.conf;
else
    ~/bin/setTerm light;
    tmux source-file ~/.tmux/light.conf;
fi
