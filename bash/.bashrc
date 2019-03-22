# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

bind 'TAB':menu-complete

# Prompt
_prompt_error() {
  _error_retcode="$?"
  if [[ ${_error_retcode} -ne 0 ]]; then
    echo "(${_error_retcode}) "
  fi
}

_prompt_user_indicator() {
  if [[ "$(whoami)" = "root" ]]; then
    echo "#"
  else
    echo "\$"
  fi
}

PS1='\[\033[01;31m\]$(_prompt_error)\[\033[00m\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(_prompt_user_indicator) '

# Aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

launch() {
  1&>/dev/null 2&>/dev/null $@ & disown
}

if command -v thefuck 1>/dev/null; then
  eval $(thefuck --alias)
fi

if command -v thefuck 1>/dev/null; then
  eval $(thefuck --alias)
fi

alias vi=/usr/bin/vi

# use emacs if available
if command -v emacs 1>/dev/null && [[ ! "$TERM" = "linux" ]]; then
  export EDITOR="emacs -nw"
  export VISUAL="emacs -nw"
else
  export EDITOR=vi
  export VISUAL=vi
fi

# Local user bin support + snap support
export PATH="$PATH:$HOME/bin:/snap/bin:$HOME/go/bin"

# Generic command aliases (note: these commands are all defined as programs on Ubuntu)
if ! command -v open 1>/dev/null; then
  alias open="xdg-open"
fi

if ! command -v pager 1>/dev/null; then
  alias pager="$PAGER"
fi

if ! command -v edit 1>/dev/null; then
  alias edit="$EDITOR"
fi

# Default flags
alias df="df -h" # Make human readable

# youtube-dl
alias ydl-playlist="youtube-dl -x -o '%(playlist_index)s - %(title)s.%(ext)s'"

# Shortenings for common commands
alias c=clear
alias e=exit
alias o=xdg-open

# alert from Ubuntu bashrc
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Fedora names bsd-game's tetris command unintuitively
alias tetris-bsd="bsd-fbg"
alias tetris="bsd-fbg -p"

# power commands
if command -v systemctl 1>/dev/null; then  # systemd
  alias poweroff="systemctl poweroff"
  alias reboot="systemctl reboot"
fi

# Vi editing mode
set -o vi
