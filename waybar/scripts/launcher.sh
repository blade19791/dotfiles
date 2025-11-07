#!/bin/bash

# Choose your launcher here
# Options: wofi, rofi, fuzzel, tofi, anyrun
LAUNCHER="wofi"

case $LAUNCHER in
  wofi)
    wofi --show drun --prompt "Run:" ;;
  rofi)
    rofi -show drun ;;
  fuzzel)
    fuzzel ;;
  tofi)
    tofi-run ;;
  anyrun)
    anyrun ;;
  *)
    echo "No launcher configured"
    ;;
esac

