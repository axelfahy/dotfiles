#!/bin/sh -e
#===============================================================================
#
#          FILE:  lock.sh
#
#         USAGE:  ./lock.sh
#
#   DESCRIPTION:  Script to take a screenshot and use it for the lock screen.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Axel Fahy (), axel@fahy.net
#       COMPANY:
#       VERSION:  1.0
#       CREATED:  10/29/2015 02:20:20 PM CET
#      REVISION:  ---
#===============================================================================

#!/bin/sh -e

# Take a screenshot
scrot /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
