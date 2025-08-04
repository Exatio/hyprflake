#!/usr/bin/env bash

STATE_FILE="$HOME/.config/wlogout/state.txt"

DEFAULT_STYLE="$HOME/.config/wlogout/style.css"
ANOTHER_STYLE="$HOME/.config/wlogout/style_1.css"

read_state() {
    if [ -f "$STATE_FILE" ]; then
        STATE=$(cat "$STATE_FILE")
    else
        STATE="default"
    fi
}

save_state() {
    echo "$1" > "$STATE_FILE"
}

if [ "$#" -gt 0 ]; then
    STATE="$1"
else
    read_state
fi

if [ "$STATE" != "default" ] && [ "$STATE" != "another" ]; then
    STATE="default"
fi

if [ "$STATE" == "default" ]; then
    A_1080=600
    B_1080=600
    resolution=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .height / .scale' | awk -F'.' '{print $1}')
    hypr_scale=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .scale')
    
    STYLE="$DEFAULT_STYLE"
    BUTTONS_PER_ROW=4
    top_margin=$(awk "BEGIN {printf \"%.0f\", $A_1080 * 1080 * $hypr_scale / $resolution}")
    bot_margin=$(awk "BEGIN {printf \"%.0f\", $B_1080 * 1080 * $hypr_scale / $resolution}")
else
    STYLE="$ANOTHER_STYLE"
    BUTTONS_PER_ROW=2
    top_margin=250
    bot_margin=250
    left_margin=500
    right_margin=500
fi

save_state "$STATE"

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Build the arguments (only use margins if defined)
CMD_ARGS="-C $STYLE -b $BUTTONS_PER_ROW --protocol layer-shell"

[ -n "$top_margin" ] && CMD_ARGS+=" -T $top_margin"
[ -n "$bot_margin" ] && CMD_ARGS+=" -B $bot_margin"
[ -n "$left_margin" ] && CMD_ARGS+=" -L $left_margin"
[ -n "$right_margin" ] && CMD_ARGS+=" -R $right_margin"

# Start wlogout
wlogout $CMD_ARGS &

