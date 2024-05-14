#!/usr/bin/env bash
# ----------------------------------------------------- 
# Select random wallpaper and create color scheme
# ----------------------------------------------------- 
wal -q -i ~/hyprflake/assets/wallpapers/

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"

# -----------------------------------------------------
# Copy selected wallpaper into .cache folder
# ----------------------------------------------------- 
cp $wallpaper ~/.cache/current_wallpaper.jpg

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|/home/exatio/hyprflake/assets/wallpapers/||g")

# ----------------------------------------------------- 
# Set the new wallpaper
# ----------------------------------------------------- 
swww img $wallpaper \
    --transition-fps=60 \
    --transition-type="grow" \
    --transition-pos "0.854, 0.977" \
    --transition-step 90 \

~/hyprflake/scripts/status_bar.sh
cp -f ~/.cache/wal/colors-cava ~/.config/cava/config
pywalfox update

sleep 1

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
notify-send "Colors and Wallpaper updated" "with image $newwall"

echo "DONE!"

