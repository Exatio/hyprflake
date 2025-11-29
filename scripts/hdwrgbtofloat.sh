#!/usr/bin/env bash

INPUT_FILE="$HOME/.config/hypr/hdw.rgb.conf"
OUTPUT_FILE="$HOME/.config/hypr/hdw.conf"

# Safety check: input file must exist
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input file not found at $INPUT_FILE"
  exit 1
fi

awk '
function rgb_to_float(val) {
  return sprintf("%.6f", val / 255)
}

{
  if ($0 ~ /windowrule = match:fullscreen off, darkwindow:shade chromakey bkg=\[[0-9]+ [0-9]+ [0-9]+\]/) {

    match($0, /bkg=\[([0-9]+) ([0-9]+) ([0-9]+)\]/, rgb)

    r = rgb_to_float(rgb[1])
    g = rgb_to_float(rgb[2])
    b = rgb_to_float(rgb[3])

    # Replace with float format
    gsub(/bkg=\[[0-9]+ [0-9]+ [0-9]+\]/,
         "bkg=[" r " " g " " b "]")
  }

  print
}
' "$INPUT_FILE" > "$OUTPUT_FILE"

hyprctl reload
