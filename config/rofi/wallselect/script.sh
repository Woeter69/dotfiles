#!/bin/bash

# Define the wallpaper directory
WALL_DIR="$HOME/Pictures/Wallpapers"

# Check if the wallpaper directory exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Error: Wallpaper directory not found at $WALL_DIR"
    exit 1
fi

# Use rofi to select a wallpaper
# - We pipe the output of 'find' to rofi
# - The 'while read' loop formats the output for rofi's icon mode
SELECTED=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
    | while read -r img; do echo -en "$img\0icon\x1f$img\n"; done \
    | rofi -dmenu -p "Select Wallpaper" -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

# Exit if rofi was cancelled (no wallpaper selected)
if [ -z "$SELECTED" ]; then
    echo "No wallpaper selected."
    exit 0
fi

# Stop any running hyprpaper instance
# We check if it's running before trying to kill it
if pgrep -x "hyprpaper" > /dev/null; then
    hyprctl hyprpaper unload all
    killall -q hyprpaper
    # Wait for the process to fully terminate
    sleep 0.1
fi

# Define the config file path
CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"

# Write the new configuration
# - Overwrite config file with 'preload'
echo "preload = $SELECTED" > "$CONFIG_PATH"
# - Append 'wallpaper' setting. Using ', $SELECTED' applies to all monitors.
echo "wallpaper = , $SELECTED" >> "$CONFIG_PATH"
# - Append other settings
echo "splash = off" >> "$CONFIG_PATH"
# - 'ipc = on' is needed for hyprctl commands to work
echo "ipc = on" >> "$CONFIG_PATH"

# Start hyprpaper in the background
# - Redirect stdout/stderr to /dev/null to run it cleanly as a daemon
hyprpaper &> /dev/null &

echo "Wallpaper set to $SELECTED"
