#!/usr/bin/env bash

iDIR="$HOME/hyprflake/assets/apps/dunst/icons"
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$(xdg-user-dir)/Pictures/screenshots"
file="Shot_${time}_${RANDOM}.png"

notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:shot-notify -u low -i ${iDIR}/picture.png"

notify_view() {
	${notify_cmd_shot} "Copied to clipboard."
	if [[ -e "$dir/$file" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
}


if [[ ! $(pidof tofi) ]]; then

	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
	fi	

	option1="Area"
	option2="Fullscreen"
	option3="Window"
	option4="eDP-1"
	option5="DP-1"

	options="$option1\n$option2\n$option3\n$option4\n$option5"

	choice=$(echo -e "$options" | tofi -c ~/.config/tofi/config-screenshot)
	
	if [ -z "$choice" ]; then
		echo "Nothing selected or an error occurred."
		exit 1
	fi

	case $choice in
	    $option1)
		grim -g "$(slurp)" - | swappy -f -
	    ;;
	    $option2)
		sleep 2
		cd ${dir} && grim - | tee "$file" | wl-copy
		notify_view
	    ;;
	    $option3)
		sleep 2
		w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
		w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
		cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
		notify_view
	    ;;
	    $option4)
		sleep 2
		cd ${dir} && grim -o eDP-1 - | tee "$file" | wl-copy
		notify_view
	    ;;
	    $option5)
		sleep 2
		cd ${dir} && grim -o DP-1 - | tee "$file" | wl-copy
		notify_view
	    ;;
	esac

else
	pkill tofi
fi




