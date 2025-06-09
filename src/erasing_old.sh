#!/bin/bash

OLD_FILES=(
    "/usr/local/bin/keyboard_leds.sh"
    "/usr/local/bin/keyboard_switch.sh"
    "/etc/systemd/system/keyboard_leds.service"
    "/etc/sudoers.d/leds_wayland"
)

for file in "${OLD_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "Old file detected: $file"
        echo "erasing file"
        sudo rm "$file"
    fi
done