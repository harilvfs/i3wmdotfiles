#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch the bar named "toph"
echo "---" | tee -a /tmp/polybar1.log
polybar toph 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."

