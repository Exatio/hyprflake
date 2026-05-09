#!/usr/bin/env bash

iDIR="$HOME/hyprflake/assets/apps/dunst/icons"
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/screenshots"

notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:shot-notify -u low -i ${iDIR}/picture.png"

if [[ ! $(pidof rofi) ]]; then

	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir"
	fi	

option1=""
option2=""
option3=""
option4=""
option5=""

	options="$option1\n$option2\n$option3\n$option4\n$option5"

  rofi_cmd() {
    	rofi -theme-str "window {width: 670px;}" \
        -theme-str "listview {columns: 5; lines: 1;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "Screenshot" \
        -markup-rows \
        -theme /home/exatio/.config/rofi/screenshot.rasi
  }

	choice=$(echo -e "$options" | rofi_cmd)
	
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
		choice_mon=$(echo -e "$options_mon" | rofi -dmenu -p "Monitor" -theme ~/.config/rofi/choose.rasi)
		if [ -z "$choice_mon" ]; then
      echo "Nothing selected or an error occurred."
      exit 1
    fi
		file="Shot_${time}_Mon_${choice_mon}.png"
		sleep 2
		cd ${dir} && grim -o "$choice_mon" - | tee "$file" | wl-copy
	    ;;
	    $option5)
	  for sec in $(seq 5 -1 1); do
      dunstify -t 1000 --replace=699 "Taking shot in : $sec"
      sleep 1
    done
    file="Shot_${time}_FS.png"
		sleep 2
		cd ${dir} && grim - | tee "$file" | wl-copy
	esac

	if [[ -e "$dir/$file" && "$choice" != "$option1" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	fi

else
	pkill rofi
fi




