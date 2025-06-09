#! /bin/bash

echo "Installing LEDs control for Wayland"

# Create base directory
BASE_DIR="/opt/backlight-keyboard-leds"

# Check and create base directory
if [ -d "$BASE_DIR" ]; then
    echo "Folder exists already"
else
    echo "Creating folder"
    sudo mkdir -p "$BASE_DIR"
fi

# Copy all files to the installation directory
sudo cp src/keyboard_leds.sh "$BASE_DIR/"
sudo cp src/switching.sh "$BASE_DIR/"
sudo cp src/erasing_old.sh "$BASE_DIR/"
sudo cp service/keyboard_leds.service "$BASE_DIR/"

# Set executable permissions
sudo chmod +x "$BASE_DIR/keyboard_leds.sh"
sudo chmod +x "$BASE_DIR/switching.sh"
sudo chmod +x "$BASE_DIR/erasing_old.sh"

# Run cleanup script
"$BASE_DIR/erasing_old.sh"

# Install systemd service
sudo cp "$BASE_DIR/keyboard_leds.service" /etc/systemd/system/
sudo sed -i "s|ExecStart=.*|ExecStart=/usr/bin/nice -n 19 $BASE_DIR/keyboard_leds.sh /sys/class/leds/ 0.2|" /etc/systemd/system/keyboard_leds.service

# Set up sudo permissions
echo "ALL ALL=(ALL) NOPASSWD: $BASE_DIR/switching.sh" | sudo tee /etc/sudoers.d/backlight_keyboard
echo "ALL ALL=(ALL) NOPASSWD: $BASE_DIR/keyboard_leds.sh" | sudo tee -a /etc/sudoers.d/backlight_keyboard

# Reload and start service
sudo systemctl daemon-reload
sudo systemctl enable keyboard_leds
sudo systemctl start keyboard_leds

echo "Done!"
echo ""
echo "Now the LEDs should turn on automatically"
echo "To turn off LEDs or turn on again execute:"   
echo "sudo $BASE_DIR/switching.sh"