#!/bin/bash

SOCKET=$(ls /tmp/kitty* 2>/dev/null | head -n1)

if [ -z "$SOCKET" ] || ! pgrep -x kitty >/dev/null; then
    kitty --single-instance
else
    kitty @ --to "unix:$SOCKET" launch --type=tab --cwd=current
    kitty @ --to "unix:$SOCKET" focus-window
fi
