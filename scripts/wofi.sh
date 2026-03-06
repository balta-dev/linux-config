#!/bin/bash
if pgrep -x "wofi" > /dev/null; then
    pkill -x wofi
else
    wofi --show drun --hide-on-focus-lost &
fi
