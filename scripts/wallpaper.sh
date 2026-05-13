#!/usr/bin/env bash

# this script needs the user to run the classifier script once (./clustering.py ~/hyprflake/assets/wallpapers --clusters 6)

# Config and Path
set -euo pipefail
wallpapers="$HOME/hyprflake/assets/wallpapers"
cache_dir="$HOME/.cache/wallpaper-script"
classifier="$HOME/hyprflake/assets/wallpapers/clustering.py"

THUMB_WIDTH="500"
THUMB_HEIGHT="280"

# Make the thumb dir if it's not exist
mkdir -p "$cache_dir"

# Generate thumbnail
generate_thumbnail(){
    local input="$1"
    local output="$2"
    magick "$input" -thumbnail "${THUMB_WIDTH}x${THUMB_HEIGHT}^" \
        -gravity center -extent "${THUMB_WIDTH}x${THUMB_HEIGHT}" "$output"
}

# Generate menu with thumbnails
generate_menu(){
    # Find all images and sort naturally
    while IFS= read -r img; do
        [[ -f "$img" ]] || continue
        ext="${img##*.}"
        thumb="$cache_dir/$(basename "${img%.*}").$ext"

        # Generate thumbnail if missing or outdated
        if [[ ! -f "$thumb" ]] || [[ "$img" -nt "$thumb" ]]; then
            generate_thumbnail "$img" "$thumb"
        fi

        # Output for wofi
        echo -en "img:$thumb\x00info:$(basename "$img")\x1f$img\n"
    done < <(find "$wallpapers" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort -V)
}


# Run wofi with thumbnails
choice=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMB_WIDTH}x${THUMB_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf ~/.config/wofi/config-wallpaper \
    --style ~/.config/wofi/style.css
)

[ -z "$choice" ] && exit 0
name=$(basename "$choice")
primary="$wallpapers/$name"

# Detect connected monitors. The first one gets the primary wallpaper
# (set by matugen via its [config.wallpaper] command); the rest get
# color-matched wallpapers picked by the classifier.
mapfile -t monitors < <(hyprctl monitors -j | jq -r '.[].name')
num_secondary=$(( ${#monitors[@]} - 1 ))

# -----------------------------------------------------
# Set wallpaper & generate conf files with matugen
# -----------------------------------------------------
echo "Changing theme..."
matugen image --source-color-index 0 "$primary"

secondaries=()
if (( num_secondary > 0 )); then
    mapfile -t secondaries < <("$classifier" --match "$primary" --count "$num_secondary")
    for i in "${!secondaries[@]}"; do
        echo "${monitors[$((i+1))]}"
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

echo "Done."