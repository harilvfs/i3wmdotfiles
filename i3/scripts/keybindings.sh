#!/usr/bin/env bash

THEME="$HOME/.config/rofi/themes/keybindings.rasi"

keybinds=$(cat <<'EOF'
 Super + X                →   Open terminal (Alacritty)
 Super + R                →   App launcher (Rofi drun)
 Super + E                →   File manager (Thunar)
 Super + B                →   Open browser
 Super + /                →   Show this keybindings list
 Super + ?                →   Show welcome/help menu
 Alt + Tab                →   Window switcher (Rofi)
 Super + Shift + P        →   Screenshot region → ~/Pictures/Screenshots
 Super + P                →   Screenshot fullscreen → ~/Pictures/Screenshots
 Super + Q                →   Kill focused window
 Super + F                →   Toggle fullscreen
 Super + Shift + Space    →   Toggle floating
 Super + Space            →   Focus float / tiling toggle
 Super + A                →   Focus parent
 Super + H                →   Split horizontal
 Super + V                →   Split vertical
 Super + J                →   Focus left
 Super + K                →   Focus down
 Super + L                →   Focus up
 Super + Ö                →   Focus right
 Super + Left             →   Focus left
 Super + Down             →   Focus down
 Super + Up               →   Focus up
 Super + Right            →   Focus right
 Super + Shift + J        →   Move window left
 Super + Shift + K        →   Move window down
 Super + Shift + L        →   Move window up
 Super + Shift + Ö        →   Move window right
 Super + Shift + Left     →   Move window left
 Super + Shift + Down     →   Move window down
 Super + Shift + Up       →   Move window up
 Super + Shift + Right    →   Move window right
 Super + 1 … 9 / 0        →   Switch to workspace 1–10
 Super + Shift + 1 … 9/0  →   Move container to workspace 1–10
 Super + I                →   Toggle bar visibility
 Super + Shift + I        →   Hide bar
 Super + Shift + B        →   Brightness +5%
 Super + Shift + T        →   Brightness -5%
 XF86 Brightness Up       →   Brightness +1 (fn key)
 XF86 Brightness Down     →   Brightness -1 (fn key)
 XF86 Volume Up           →   Volume +10%
 XF86 Volume Down         →   Volume -10%
 XF86 Mute                →   Toggle speaker mute
 XF86 Mic Mute            →   Toggle mic mute
 Super + U                →   Lock screen (i3lock)
 Super + Shift + W        →   Random wallpaper (feh)
 Super + Shift + J        →   [resize] Shrink width -10px
 K                        →   [resize] Grow height +10px
 L                        →   [resize] Shrink height -10px
 Ö                        →   [resize] Grow width +10px
 Left / Down / Up / Right →   [resize] ±1px fine resize
 Super + Shift + G        →   Enter gaps mode
 O                        →   [gaps] Outer gaps submenu
 I                        →   [gaps] Inner gaps submenu
 + / -                    →   [gaps] Increase / decrease gap (current)
 0                        →   [gaps] Reset gap to 0 (current)
 Shift + + / -            →   [gaps] Increase / decrease gap (all)
 Shift + 0                →   [gaps] Reset gap to 0 (all)
 Return / Escape          →   [gaps/resize] Exit mode
 Super + Shift + C        →   Reload i3 config
 Super + Shift + R        →   Restart i3
 Super + Shift + Q        →   Power menu
EOF
)

echo "$keybinds" | rofi \
    -dmenu \
    -i \
    -p "  Keybinds" \
    -mesg "  Type to filter" \
    -theme "$THEME" \
    -no-custom \
    -format i

exit 0
