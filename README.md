# Backlight Keyboard LEDs - with Wayland and Systemd

This service searches for keyboard backlight LEDs from their Wayland folder and forces them to turn on periodically.

## Installation

1. Clone the repository:

```bash
git clone https://github.com/ShehaanN/backlight-keyboard-leds.git
cd backlight-keyboard-leds
```

2. Run the installer:

```bash
sudo chmod +x src/install.sh
sudo ./src/install.sh
```

## Usage

To toggle LEDs on/off:

```bash
sudo /opt/backlight-keyboard-leds/switching.sh
```

You can add this command to keyboard shortcuts for easier access.

## Uninstallation

```bash
sudo chmod +x src/uninstall.sh
sudo ./src/uninstall.sh
```
