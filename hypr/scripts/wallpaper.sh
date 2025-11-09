#!/usr/bin/env bash
# -----------------------------------------------
# wallpaper.sh – Change wallpaper and sync colors
# -----------------------------------------------

set -euo pipefail

# ---------------- User Settings ----------------
WALLPAPER_DIR="$HOME/Downloads/wallpapers"
WAYBAR_CSS="$HOME/.cache/wal/colors-waybar.css"
KITTY_THEME="$HOME/.config/kitty/current-theme.conf"
WAL_CACHE="$HOME/.cache/wal/colors.json"
# -----------------------------------------------

# Pick a random wallpaper
WALLPAPER="$(find "$WALLPAPER_DIR" -type f | shuf -n 1)"
echo "Selected wallpaper: $WALLPAPER"

# Start swww daemon if not running
if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon &
    sleep 1
fi

# Set wallpaper with smooth transition
swww img "$WALLPAPER" --transition-type any --transition-step 90 --transition-fps 60

# Generate Pywal colors
wal -i "$WALLPAPER" -n

# reload Waybar
kiall -9 waybar
waybar &

# ---------------- Notification ----------------
notify-send "Wallpaper & Theme Applied" \
"Waybar, Kitty, and Hyprland borders updated."

exit 0

