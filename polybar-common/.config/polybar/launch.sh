#!/bin/bash -
#===============================================================================
#
#          FILE: launch.sh
#
#         USAGE: ./launch.sh
#
#   DESCRIPTION: Script to launch polybar on all monitors.
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

set -o nounset                              # Treat unset variables as an error

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars
for m in $(polybar --list-monitors | cut -d":" -f1); do
    echo "Lauching bar on $m"
    # Change `/dev/null` to `/tmp/polybar_$m.log` to have the log.
    MONITOR=$m polybar --reload -c $HOME/.config/polybar/config bottom 2>/dev/null &
done

echo "Bars launched..."
