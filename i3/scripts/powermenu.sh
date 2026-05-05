#!/bin/bash

lock="󰌾 Lock"
logout="󰍃 Logout"
suspend="󰒲 Suspend"
reboot="󰑓 Reboot"
shutdown="󰐥 Shutdown"

options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

theme="~/.config/rofi/themes/powermenu.rasi"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme "$theme")

case "$chosen" in
    "$lock") ~/.config/i3/scripts/i3exit.sh lock ;;
    "$logout") ~/.config/i3/scripts/i3exit.sh logout ;;
    "$suspend") ~/.config/i3/scripts/i3exit.sh suspend ;;
    "$reboot") ~/.config/i3/scripts/i3exit.sh reboot ;;
    "$shutdown") ~/.config/i3/scripts/i3exit.sh shutdown ;;
esac
