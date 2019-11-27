#!/bin/bash -
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
#        AUTHOR:  Axel Fahy (axel@fahy.net)
#       COMPANY:
#       VERSION:  1.0
#       CREATED:  29/10/2015 14:20
#      REVISION:  26/11/2019 19:12
#===============================================================================

# Take a screenshot.
scrot -o /tmp/screen_locked.png

# Pixellate it 10x.
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
