 #!/usr/bin/env bash

STATE_FILE="$HOME/.config/waybar/state.txt"

DEFAULT_CONFIG="$HOME/.config/waybar/bar/config"
DEFAULT_STYLE="$HOME/.config/waybar/bar/style.css"

BAR2_CONFIG="$HOME/.config/waybar/bar2/config"
BAR2_STYLE="$HOME/.config/waybar/bar2/style.css"

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

if [ "$STATE" != "default" ] && [ "$STATE" != "bar2" ]; then
    STATE="default"
fi

if [ "$STATE" == "default" ]; then
    CONFIG="$DEFAULT_CONFIG"
    STYLE="$DEFAULT_STYLE"
else
    CONFIG="$BAR2_CONFIG"
    STYLE="$BAR2_STYLE"
fi

if pidof waybar >/dev/null; then
    pkill waybar
fi

echo $CONFIG
echo $STYLE

waybar --log-level error --config "$CONFIG" --style "$STYLE" & disown

save_state "$STATE"

