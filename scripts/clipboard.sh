#!/usr/bin/env bash

if [[ ! $(pidof rofi) ]]; then
    selected=$( (echo -e "Clear history\n" & cliphist list) | rofi -dmenu -p "📋" -theme ~/.config/rofi/choose.rasi )

    if [ -z "$selected" ]; then
        echo "Nothing selected or an error occurred."
        exit 1
    fi

    if [ "$selected" == "Clear history" ] ; then
        cliphist wipe
    else
        echo "$selected" | cliphist decode | wl-copy
    fi
else
	pkill tofi
fi
