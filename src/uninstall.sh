#!/bin/bash

echo "Uninstalling LED's routines and services..."

# Stop service
sudo systemctl stop keyboard_leds
pid=$(pgrep keyboard_leds)
[ ! -z "$pid" ] && kill -SIGKILL $pid

# Remove installed files
sudo rm -rf /opt/backlight-keyboard-leds/

# Remove systemd service
[ -f /etc/systemd/system/keyboard_leds.service ] && \
    sudo rm /etc/systemd/system/keyboard_leds.service

# Remove sudo permissions
[ -f /etc/sudoers.d/backlight_keyboard ] && \
    sudo rm /etc/sudoers.d/backlight_keyboard

# Reload systemd
sudo systemctl daemon-reload

echo "Done!"
echo "LEDs routines uninstalled"