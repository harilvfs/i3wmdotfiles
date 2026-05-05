#!/usr/bin/env bash

# =============================================================================
#  i3wm Welcome Script
#  To re-enable after disabling: rm ~/.config/i3/scripts/.welcome_disabled
# =============================================================================

DISABLE_FILE="$HOME/.config/i3/scripts/.welcome_disabled"
KEYBINDS_URL="https://github.com/harilvfs/i3wmdotfiles?tab=readme-ov-file#keybinds"
ISSUE_URL="https://github.com/harilvfs/i3wmdotfiles/issues/new/choose"
USERNAME=$(whoami)

[[ -f "$DISABLE_FILE" ]] && exit 0

if ! command -v yad &>/dev/null; then
    notify-send -u normal -t 8000 \
        "Welcome to i3wm" \
        "Hey $USERNAME, thanks for using my config!\nKeybindings reference:\n$KEYBINDS_URL"
    exit 0
fi

disable_popup() {
    mkdir -p "$(dirname "$DISABLE_FILE")"
    touch "$DISABLE_FILE"
    notify-send -u low -t 6000 \
        "i3wm Welcome" \
        "Startup popup disabled.\n\nTo re-enable, run:\nrm ~/.config/i3/scripts/.welcome_disabled"
}

yad \
    --title="Welcome to i3wm" \
    --width=520 \
    --height=340 \
    --fixed \
    --center \
    --image="dialog-information" \
    --image-on-top \
    --text="\n<b><big>Hey $USERNAME, welcome!</big></b>\n\
<i>Thanks for using my i3wm config.</i>\n\n\
Here are a few things to get you started:\n\n\
<tt><b>Key Combo            Action</b>
──────────────────────────────────────
Super + R            →  App Launcher (Rofi)
Super + X            →  Terminal (Alacritty)
Super + B            →  Browser
Super + Q            →  Close Window
Super + Shift + Q    →  Exit i3 Session</tt>\n\n\
If something went wrong, please open an issue.\n" \
    --text-align=left \
    --button="Open Keybindings:2" \
    --button="Report an Issue:3" \
    --button="Don't show again:1" \
    --button="Close:0"

EXIT_CODE=$?

case $EXIT_CODE in
    2)
        xdg-open "$KEYBINDS_URL" &
        ;;
    3)
        xdg-open "$ISSUE_URL" &
        ;;
    1)
        disable_popup
        ;;
esac
