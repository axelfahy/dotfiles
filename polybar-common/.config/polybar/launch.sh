#!/bin/bash -
#===============================================================================
#
#          FILE: launch.sh
#
#         USAGE: ./launch.sh
#
#   DESCRIPTION: Script to launch polybar on all monitors.
#                The system tray is only run on the primary monitor.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Axel Fahy (axel@fahy.net)
#  ORGANIZATION:
#       CREATED: 27.11.19 13:31
#      REVISION:  ---
#===============================================================================

# Treat unset variables as an error.
set -o nounset

# Terminate already running bar instances.
killall -q polybar

# Wait until the processes have been shut down.
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars
for m in $(polybar --list-monitors | cut -d":" -f1); do
    echo "Lauching bar on $m"
    # Check if this is the primary monitor.
    if [[ $(polybar --list-monitors | grep $m | cut -d "(" -f2 | cut -d ")" -f1) == "primary" ]]; then
        echo "$m is the primary monitor"
        tray=right
    else
        tray=none
    fi
    # Change `/dev/null` to `/tmp/polybar_$m.log` to have the log.
    MONITOR=$m TRAY_POSITION=$tray polybar --reload -c $HOME/.config/polybar/config bottom 2>/dev/null &
done

echo "Bars launched..."
