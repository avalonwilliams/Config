# My build of st - the simple (suckless) terminal
Fork of [Luke Smith's modifications](https://github.com/LukeSmithxyz/st) (please note I don't endorse or follow his political or ideological views,
in fact, I heavily oppose them).
The [suckless terminal (st)](https://st.suckless.org/) with some additional features:

+ Compatibility with `Xresources` and `pywal` for dynamic colors.
+ Default [gruvbox](https://github.com/morhetz/gruvbox) colors otherwise.
+ Transparency/alpha, which is also adjustable from `~/.Xresources`.
+ Default font is system "mono" at 16pt, meaning the font will match your system font.
+ More terminfo things for apps using nonstandard extensions (i.e. emacs)
+ Keybindings similar to Urxvt's keybindings
  + Zooming
	+ <C-Shift-i> Zoom in
	+ <C-Shift-o> Zoom out
	+ <C-Shift-r> Zoom reset
  + Scrolling
	+ <C-Shift-k> <C-Shift-Up> <C-Shift-PageUp> scroll up
	+ <C-Shift-j> <C-Shift-Down> <C-Shift-PageDown> scroll up
  + Keyboard selection
	+ <C-Shift-ESC> keyboard selection mode
	+ <C-Shift-l> open url using keyboard
  + iso14755
	+ <C-Shift-u> Insert unicode codepoint glyph
  + Copy-paste
	+ <C-Shift-v> Paste from clipboard 
	+ <C-Shift-c> Copy from clipboard
	+ <C-Shift-p> Paste from primary selection

## Installation for newbs

```
make
sudo make install
```

Obviously, `make` is required to build. `fontconfig` is required for the default build, since it asks `fontconfig` for your system monospace font.  It might be obvious, but `libX11` and `libXft` are required as well. Chances are, you have all of this installed already.

Be sure to have a composite manager (`xcompmgr`, `compton`, etc.) running if you want transparency.

## How to configure dynamically with Xresources

For many key variables, this build of `st` will look for X settings set in either `~/.Xdefaults` or `~/.Xresources`. You must run `xrdb` on one of these files to load the settings.

For example, you can define your desired fonts, transparency or colors:

```
st.font:	Liberation Mono:pixelsize=12:antialias=true:autohint=true;
st.alpha: 150
st.color0: #111
...
```

The `alpha` value (for transparency) goes from `0` (transparent) to `255`
(opaque).

### Colors

To be clear about the color settings:

- This build will use gruvbox colors by default and as a fallback.
- If there are Xresources colors defined, those will take priority.
- But if `wal` has run in your session, its colors will take priority.

Note that when you run `wal`, it will negate the transparency of existing windows, but new windows will continue with the previously defined transparency.
