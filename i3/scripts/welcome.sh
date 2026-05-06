#!/usr/bin/env bash

DISABLE_FILE="$HOME/.config/i3/scripts/.welcome_disabled"
KEYBINDS_URL="https://github.com/harilvfs/i3wmdotfiles?tab=readme-ov-file#keybinds"
ISSUE_URL="https://github.com/harilvfs/i3wmdotfiles/issues/new/choose"
CONFIG_DIR="$HOME/.config/i3"
USERNAME=$(whoami)

[[ -f "$DISABLE_FILE" ]] && exit 0

TEXT_CONTENT="
<span foreground='#81A1C1' size='14500'><b>  Hey $USERNAME, welcome!  </b></span>
<span foreground='#4C566A'>──────────────────────────────────────────────</span>

<span font_desc='JetBrains Mono Nerd Font 10'><i>Thanks for using my i3wm config.</i>

Here are a few things to get you started:

<b>  󰘳 Key Combo               󱓞 Action          </b>
<span foreground='#4C566A'>──────────────────────────────────────────────</span>
  Super + R            →    App Launcher (Rofi)  
  Super + X            →    Terminal (Alacritty) 
  Super + B            →    Browser              
  Super + Q            →    Close Window         
  Super + Shift + Q    →    Powermenu            
<span foreground='#4C566A'>──────────────────────────────────────────────</span></span>

<span size='small' foreground='#A3BE8C'><i>If something went wrong, please open an issue.</i></span>"

yad --title="Welcome to i3wm" \
    --window-icon="preferences-desktop-keyboard-shortcuts" \
    --width=580 --height=480 --center --fixed --resizable=no \
    --text="$TEXT_CONTENT" \
    --text-align=center \
    --button="󰈹 Open Keybindings:2" \
    --button=" Report an Issue:3" \
    --button=" Edit Config:4" \
    --button="󰚰 System Update:5" \
    --button="󰈆 Don't show again:1" \
    --button="󰗼 Close:0" \
    --buttons-layout=center

EXIT_CODE=$?

case $EXIT_CODE in
    2) xdg-open "$KEYBINDS_URL" & ;;
    3) xdg-open "$ISSUE_URL" & ;;
    4) alacritty -e nvim "$CONFIG_DIR/config" & ;;
    5) alacritty -e sudo pacman -Syu & ;;
    1) 
        mkdir -p "$(dirname "$DISABLE_FILE")"
        touch "$DISABLE_FILE"
        notify-send -u low -t 6000 "i3wm Welcome" "Startup popup disabled.\n\nTo re-enable, run:\nrm $DISABLE_FILE"
        ;;
    *) exit 0 ;;
esac
