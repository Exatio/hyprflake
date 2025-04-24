#!/usr/bin/env bash

# Get the current Mullvad VPN status
status=$(mullvad status | head -n 1 | awk '{print $1}')

if [ "$status" == "Connected" ]; then
    echo "Currently connected. Disconnecting..."
    mullvad disconnect
elif [ "$status" == "Disconnected" ]; then
    echo "Currently disconnected. Connecting..."
    mullvad connect
else
    echo "Unable to determine status: $status"
fi
sleep 2
pkill -SIGRTMIN+10 waybar