#!/bin/bash

# Get the current brightness level and the maximum brightness
BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Check the argument to either increase or decrease brightness
if [[ "$1" == "up" ]]; then
    brightnessctl set +10%
elif [[ "$1" == "down" ]]; then
    brightnessctl set 10%-
fi

# Get the new brightness level
NEW_BRIGHTNESS=$(brightnessctl get)
NEW_PERCENTAGE=$((NEW_BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Display the brightness level
echo "🔅$NEW_PERCENTAGE%"

