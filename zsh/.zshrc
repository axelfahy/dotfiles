# /etc/zsh/zshrc: system-wide .zshrc file for zsh(1)
#
# Main configuration file for zsh.

#-----------------------------
# History
#-----------------------------
export HISTFILE=$HOME/.history
export HISTORY=1000000
export SAVEHIST=1000000
export HISTFILESIZE=1000000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
unsetopt HIST_BEEP               # Remove beep when accessing nonexistent history.
unsetopt BEEP
unsetopt LIST_BEEP
setopt AUTO_REMOVE_SLASH         # Remove trailing `/` if space is press.
setopt CHASE_LINKS               # Handles sym links.
unsetopt HUP                     # Don't close background jobs when exiting the shell.
setopt AUTO_CD                   # Auto cd if nothing is provided, e.g. for `..`.
setopt AUTO_PUSHD                # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS         # Don’t push multiple copies of the same directory onto the directory stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME             # Have pushd with no arguments act like ‘pushd $HOME’.

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#-----------------------------
# Alias
#-----------------------------
# Confirmation before removing files.
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive'

# Shortcuts for `ls`
alias ls='ls --color -F'
alias ll='ls --color -lh'
alias la='ls --color -a'
alias lla='ls --color -alh'

# Others.
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'

# Find, for Ubuntu
alias fd='fdfind'

# Octave - without gui by default
alias octave="octave --no-gui"

#-----------------------------
# Keybindings
#-----------------------------
bindkey -v                              # vi mode
typeset -g -A key
bindkey ''    beginning-of-line       # Home
bindkey "\e[1~" beginning-of-line
bindkey "\e[H"  beginning-of-line
bindkey ''    end-of-line             # End
bindkey "\e[4~" end-of-line
bindkey "\e[F"  end-of-line
bindkey ''    delete-char             # Del
bindkey '[3~' delete-char
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn
bindkey '^R'    history-incremental-pattern-search-backward

#------------------------------
# Completion
#------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

setprompt() {
  setopt prompt_subst

  # Color changes if on server or not.
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    p_host='%F{blue}%M%f'
  else
    p_host='%F{white}%M%f'
  fi

  # Color changes if root or normal user.
  PS1=${(j::Q)${(Z:Cn:):-$'
    %B
    %F{cyan}%T" "
    %(!.%F{magenta}%n%f.%F{red}%n%f)
    %F{yellow}@%f
    ${p_host}
    " "%F{green}%~%f
    " "%(!.%F{red}%#%f.%F{yellow}%#%f)
    %b
    " "
  '}}

  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

#------------------------------
# fzf
#------------------------------
fzfshare="/usr/share/fzf"
# Thanks Ubuntu for doing things differently...
if [ ! -d $fzfshare ]; then
    fzfshare="/usr/share/doc/fzf/examples"
fi
if [ -d $fzfshare ]; then
  source "$fzfshare/key-bindings.zsh"
  source "$fzfshare/completion.zsh"
fi

# Set fd instead of find.
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
