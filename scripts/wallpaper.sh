#!/usr/bin/env bash

# ----------------------------------------------------- 
# Select wallpaper
# ----------------------------------------------------- 
selected=$(ls -1 ~/hyprflake/assets/wallpapers | grep "jpg\|png\|gif" | tofi --config ~/.config/tofi/config --padding-left="5%" --prompt-text "Wallpaper: ")

if [[ -z $selected ]]; then return; fi

echo "Changing theme..."
# ----------------------------------------------------- 
# Set wallpaper & generate conf files with matugen
# ----------------------------------------------------- 
matugen image ~/hyprflake/assets/wallpapers/$selected

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
notify-send "Colors and Wallpaper updated" "with image $selected"

echo "Done."
