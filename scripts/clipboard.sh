#!/usr/bin/env bash

if [[ ! $(pidof tofi) ]]; then
    selected=$((echo -e "Clear history\n" & cliphist list) | tofi --config ~/.config/tofi/config --padding-left="5%" --prompt-text "Clipboard: " )
    
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
