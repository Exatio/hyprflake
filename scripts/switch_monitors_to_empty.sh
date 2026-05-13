#!/usr/bin/env bash

mapfile -t MONS < <(hyprctl monitors -j | jq -r '.[].name')

WS=90
for m in "${MONS[@]}"; do
    hyprctl dispatch moveworkspacetomonitor "$WS" "$m"
    hyprctl dispatch focusmonitor "$m"
    hyprctl dispatch workspace "$WS"
    WS=$((WS+1))
done