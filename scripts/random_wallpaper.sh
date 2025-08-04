#!/usr/bin/env bash

# ----------------------------------------------------- 
# Select random wallpaper, set it and create color scheme
# ----------------------------------------------------- 

# Get a random wallpaper file from the wallpapers directory
wallpaper_dir="$HOME/hyprflake/assets/wallpapers"
selected=$(find "$wallpaper_dir" -type f | shuf -n 1)

# Generate color scheme and set wallpaper
matugen image "$selected"

# ----------------------------------------------------- 
# Get wallpaper image name (filename only)
# ----------------------------------------------------- 
newwall=$(basename "$selected")

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
notify-send "Colors and Wallpaper updated" "With image: $newwall"

echo "DONE!"
