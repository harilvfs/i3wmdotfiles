#!/usr/bin/env bash

STEP=5

get_brightness() {
    brightnessctl -m | cut -d, -f4
}

case "$1" in
    up)
        brightnessctl set +${STEP}% >/dev/null
        ;;
    down)
        brightnessctl set ${STEP}%- >/dev/null
        ;;
esac

echo "$(get_brightness)"
