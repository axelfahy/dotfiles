# /etc/zsh/zlogin: system-wide .zlogin file for zsh(1)
#
# This file is sourced when starting a shell.

# Print system information.
uname -a
uptime

# Accept messages from other users.
mesg y
