#!/usr/bin/env bash

def="Default bar"
bar2="Secondary bar"

if [[ ! $(pidof tofi) ]]; then
    
    selected=$((echo -e "$def\n$bar2") | tofi -c ~/.config/tofi/config-search)

    if [ -z "$selected" ]; then
        echo "Nothing selected or an error occurred."
        exit 1
    fi

    if [ "$selected" == "$def" ] ; then
        ~/hyprflake/scripts/status_bar.sh bar &
    elif [ "$selected" == "$bar2" ] ; then
        ~/hyprflake/scripts/status_bar.sh bar2 &
    fi
else
	pkill tofi
fi
