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
  zplug "agkozak/agkozak-zsh-prompt"

  zplug "zsh-users/zsh-completions"

  # Fish-like features
  zplug "zsh-users/zsh-autosuggestions", if:"[[ $(tput colors) -gt 8 ]]"

  zplug "zdharma/fast-syntax-highlighting"
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

# Keybindings
set -o vi

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

# function for the launching a new (seperate) window
launch() {
  1&>/dev/null 2&>/dev/null $@ & disown
}

# Theming
PROMPT='%(?..%B%F{red}(%?%)%f%b )'
PROMPT+='%(!.%S%B.%B%F{green})%n@%m%1v%(!.%b%s.%f%b):'
PROMPT+=$'%B%F{blue}%2v%f%b'
PROMPT+='%(4V.>.%(!.%#.$)) '

RPROMPT='%(3V.%F{yellow}%3v%f.)'

