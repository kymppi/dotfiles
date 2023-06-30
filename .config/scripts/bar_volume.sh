#!/bin/bash

# Get the volume value
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')

# Remove the decimal point and convert to integer
volume=$(echo "$volume * 100" | bc)
volume=${volume%.*} # Remove decimal part

echo "  $volume%"
