#!/bin/sh

pgrep dunst > /dev/null || /usr/bin/dunst &

xautolock \
  -time 10 \
  -locker slock \
  -notify 10 \
  -notifier "/usr/bin/notify-send '🔒 Locking soon' 'The screen will lock in 10 seconds...'" &

# it works like:
# startx ~/.xinitrc dwm
# startx ~/.xinitrc i3
#
# don't use this method if you don't use both window managers, if you are only on i3 then just put
# exec i3
# that should work via startx directly

case "$1" in
    i3)
        exec i3
        ;;
    dwm)
        exec dwm
        ;;
    *)
        exec i3
        ;;
esac
