#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/config"
STYLE="$HOME/.config/waybar/style.css"

if pidof waybar >/dev/null; then
        pkill waybar
fi

waybar --bar main-bar --log-level error --config ${CONFIG} --style ${STYLE} &disown
