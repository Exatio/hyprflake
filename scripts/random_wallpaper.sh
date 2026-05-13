#!/usr/bin/env bash

# ----------------------------------------------------- 
# Select random wallpaper, set it and create color scheme | this script needs the user to run the classifier script once (./clustering.py ~/hyprflake/assets/wallpapers --clusters 6)
# -----------------------------------------------------
set -euo pipefail
# Get a random wallpaper file from the wallpapers directory
wallpaper_dir="$HOME/hyprflake/assets/wallpapers"
classifier="$HOME/hyprflake/assets/wallpapers/clustering.py"

primary=$(find "$wallpaper_dir" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | shuf -n 1)

# Detect connected monitors. The first one gets the primary wallpaper
# (set by matugen); the rest get color-matched wallpapers.
mapfile -t monitors < <(hyprctl monitors -j | jq -r '.[].name')
num_secondary=$(( ${#monitors[@]} - 1 ))

# Generate color scheme and set primary wallpaper
matugen image --source-color-index 0 "$primary"

secondaries=()
if (( num_secondary > 0 )); then
    mapfile -t secondaries < <("$classifier" --match "$primary" --count "$num_secondary")
    for i in "${!secondaries[@]}"; do
        awww img --outputs "${monitors[$((i+1))]}" \
            --transition-type grow --transition-fps 60 \
            --transition-pos "854, 977" --transition-step 90 \
            "${secondaries[$i]}"
    done
fi

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
msg="Primary: $(basename "$primary")"
for s in "${secondaries[@]}"; do
    msg="$msg
Secondary: $(basename "$s")"
done
notify-send "Colors and Wallpaper updated" "$msg"

echo "DONE!"
