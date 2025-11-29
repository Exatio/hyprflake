#!/usr/bin/env bash

iDIR="$HOME/hyprflake/assets/apps/dunst/icons"
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/screenshots"

notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:shot-notify -u low -i ${iDIR}/picture.png"

if [[ ! $(pidof tofi) ]]; then

	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
	fi	

	option1="Area"
	option2="Fullscreen"
	option3="Window"
	option4="Monitor"

	options="$option1\n$option2\n$option3\n$option4"

	choice=$(echo -e "$options" | tofi --config ~/.config/tofi/config --prompt-text "Screenshot: ")
	
	if [ -z "$choice" ]; then
		echo "Nothing selected or an error occurred."
		exit 1
	fi

	case $choice in
	    $option1)
		grim -g "$(slurp)" - | swappy -f -
	    ;;
	    $option2)
		file="Shot_${time}_FS.png"
		sleep 2
		cd ${dir} && grim - | tee "$file" | wl-copy
	    ;;
	    $option3)
		file="Shot_${time}_Win.png"
		sleep 2
		w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
		w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
		cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
	    ;;
		$option4)
		options_mon=$(hyprctl monitors | grep '^Monitor ' | awk '{print $2}')
		choice_mon=$(echo -e "$options_mon" | tofi --config ~/.config/tofi/config --prompt-text "Monitor: ")
		file="Shot_${time}_Mon_${choice_mon}.png"
		sleep 2
		cd ${dir} && grim -o "$choice_mon" - | tee "$file" | wl-copy
	    ;;
	esac

	if [[ -e "$dir/$file" && "$choice" != "$option1" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	fi

else
	pkill tofi
fi




