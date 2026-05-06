#!/usr/bin/env bash

DISABLE_FILE="$HOME/.config/i3/scripts/.welcome_disabled"
ISSUE_URL="https://github.com/harilvfs/i3wmdotfiles/issues/new/choose"
KEYBINDS_SCRIPT="$HOME/.config/i3/scripts/keybindings.sh"
USER_NAME=$(whoami)

if [[ "$1" != "--manual" && -f "$DISABLE_FILE" ]]; then
    exit 0
fi

TITLE="<span foreground='#81A1C1' size='xx-large'><b>Welcome, $USER_NAME!</b></span>"
LINE="<span foreground='#4C566A'>__________________________________________________</span>"

HELP_TEXT="<span foreground='#A3BE8C'><b>Super + /</b> Keybindings  |  <b>Super + ?</b> This Menu</span>"
INFO="Essential: Super+X (Term) | Super+R (Menu) | Super+Q (Kill)"
CONFIG_PATH="<span size='small' foreground='#616E88'>Config: ~/.config/i3/config</span>"

yad --title="i3wm Quick Start" \
    --width=500 --height=320 \
    --center --fixed --resizable=no \
    --text="$TITLE\n$LINE\n\n$HELP_TEXT\n\n$INFO\n\n$CONFIG_PATH" \
    --text-align=center \
    --button="  Keybindings:2" \
    --button="  Report Issue:3" \
    --button="󰈆  Don't show again:1" \
    --button="Close:0"

EXIT_CODE=$?

case $EXIT_CODE in
    2) bash "$KEYBINDS_SCRIPT" & ;;
    3) xdg-open "$ISSUE_URL" & ;;
    1) 
        mkdir -p "$(dirname "$DISABLE_FILE")"
        touch "$DISABLE_FILE"
        notify-send -u low "i3wm" "Startup popup disabled. Reopen with Super+?"
        ;;
    *) exit 0 ;;
esac
