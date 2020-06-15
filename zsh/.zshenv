# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1)
#
# This file is sourced for every instance of zsh.

# Define the PATH.
export PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/usr/sbin"

# Add SQLServer to PATH.
PATH=$PATH:$HOME/.local/bin:/opt/mssql-tools/bin

# Set vim as default editor.
export VISUAL=vim
export EDITOR=vim

# Add coloration for grep command.
export GREP_OPTIONS='--color=auto'

# Add coloration for less command.
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')
