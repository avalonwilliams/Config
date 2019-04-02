# -*- mode: sh; -*-

# zplug plugin manager
source ~/.zplug/init.zsh
  zplug "plugins/pip",               from:oh-my-zsh
  zplug "plugins/go",                from:oh-my-zsh
  zplug "plugins/rust",              from:oh-my-zsh
  zplug "plugins/fzf",               from:oh-my-zsh
  zplug "plugins/command-not-found", from:oh-my-zsh

  zplug "cperrin88/Snappy_zsh_autocompletion"
  zplug "RobSis/zsh-completion-generator"
  
  # Theme
  if [[ "$(tput colors)" -ge 256 ]]; then
    zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
  fi

  zplug "zsh-users/zsh-completions"

  # Fish-like features
  if [[ "$(tput colors)" -gt 8 ]]; then
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zdharma/fast-syntax-highlighting"
  fi
  zplug "zsh-users/zsh-history-substring-search"

  # Install plugin automatic
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "

    if read -q; then
      echo; zplug install
    fi
  fi
zplug load


# Zsh extended filename globbing
setopt extended_glob

# Implicit cd
setopt autocd

# Prevent beep
#
# Note: I would recommend running `rmmod pcspkr` and blacklisting
# the pcspkr kernel module to completely disable the beep,
# if it is enabled in your distro by default
setopt no_beep

# Load some modules
zmodload -i zsh/parameter
zmodload -i zsh/complist
zmodload -i zsh/deltochar
zmodload -i zsh/mathfunc

# For completions with deoplete and vim
zmodload zsh/zpty

autoload -Uz zcalc

# Generate completions
zstyle :plugin:zsh-completion-generator programs chcon

# History settings
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt inc_append_history share_history

# Load as needed
zmodload -a zsh/stat zstat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile

# PAGER
if 1&>/dev/null command -v less; then
  export PAGER=less
else
  export PAGER=more
fi

# Less pager colors
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 15)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'

export GROFF_NO_SGR=1

# Fedora/CentOS's 'vimx'
if command -v vimx 1>/dev/null; then
  alias vim=vimx
fi

# Use vim (or vi, if no emacs (presumably with evil), or vim installed)
if command -v emacs 1>/dev/null && [[ ! "$TERM" = "linux" ]]; then
  export EDITOR="emacs -nw"
  export VISUAL="emacs -nw"
elif command -v vim 1>/dev/null; then
  export EDITOR=vim
  export VISUAL=vim
else
  export EDITOR=vi
  export VISUAL=vi
fi

# Local user bin support + snap support
export PATH="$PATH:$HOME/bin:/snap/bin:$HOME/go/bin"

# Correct vi command (it gets aliased to vim for some reason)
alias vi=/usr/bin/vi

# Ensure grep and ls use colors
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# sl alias
if command -v sl 1>/dev/null; then
  SL_RPATH=$(whence sl)

  sl() {
    $SL_RPATH $@
    ls $@
    return $?
  }
fi

# Human readable du
alias du='du -h'

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
stream_vid() {
  1>/dev/null 2>/dev/null youtube-dl -o - "$1" | mpv - 1>/dev/null 2>/dev/null & disown
}

# Shortenings for common commands
alias c=clear
alias e=exit
if command -v rifle 1>/dev/null; then
  alias o=rifle
else
  alias o=xdg-open
fi

alias rng=ranger

# ls aliases
alias ll="ls -lhF"
alias l="ls -lhaF"

# xclip
alias xclip="xclip -selection clipboard"

fclip() {
  cat $1 | xclip
}

# Fedora names bsd-game's tetris command unintuitively
alias tetris-bsd="bsd-fbg"
alias tetris="bsd-fbg -p"

# power commands
if command -v systemctl 1>/dev/null; then  # systemd
  alias poweroff="systemctl poweroff"
  alias reboot="systemctl reboot"
fi

# pygmentize alias
alias pcat="pygmentize -g"

# thefuck
eval $(thefuck --alias f)

# dircolors
if command -v dircolors 1>/dev/null; then
  eval "$(dircolors)"
fi

# menu for completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# function for the launching a new (seperate) window
launch() {
  1&>/dev/null 2&>/dev/null $@ & disown
}

# Keybindings
bindkey -v

# vi keys completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# history navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Theming
DEFAULT_USER="aidan"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_STATUS_HIDE_SIGNAME=true
POWERLEVEL9K_STATUS_OK=false

POWERLEVEL9K_VI_INSERT_MODE_STRING='I'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND="2"
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="0"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="6"
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="0"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  vi_mode
  status
  dir
  virtualenv
  vcs
)

VIRTUAL_ENV_DISABLE_PROMPT=1
