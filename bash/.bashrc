# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

bind 'TAB':menu-complete

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

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

if [[ ! -f ~/.polyglot ]]; then
  curl https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh > ~/.polyglot
fi

source ~/.polyglot
