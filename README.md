![screenshot](/docs/st_ban.png)
# st - simple terminal
Fork of the [suckless terminal (st)](https://st.suckless.org/) with additional patches.

## Applied Patches:
- [scrollback](https://st.suckless.org/patches/scrollback/)
- [xresources](https://st.suckless.org/patches/xresources/)
- [disable bold italic fonts](https://st.suckless.org/patches/disable_bold_italic_fonts/)
- [anygeometry](https://st.suckless.org/patches/anygeometry/)
- [blinkingcursor](https://aur.archlinux.org/cgit/aur.git/tree/st-blinking-cursor-20180605.diff?h=st-patched-git)
- [font2](https://st.suckless.org/patches/font2/)
- [boxdraw](https://st.suckless.org/patches/boxdraw/)
- [right click to plumb](https://st.suckless.org/patches/right_click_to_plumb/)

## Requirements
In order to build **st** you need the Xlib header files.

## Installation

`git clone https://github.com/feloniousBonk/st-bonk.git` 

Clone this repository into desired directory e.g. `~/.local/share/` or `~/.config/`

Enter the following command to build and install **st**:
```bash
sudo make clean install
```
After installation, the file `config.h` will be created, you can use this file for any further configuration and simply run the command:

```bash
sudo make install
```
and this will recompile **st** with your updated changes. You can keep `config.def.h` as is, so you always have the inital configuration file on hand if needed. 

**NOTE**: There are several different ways to manage config files; some people use `config.def.h` for making changes and create a new `config.h` file each time; If you choose this way make sure to remove `config.h` and then create the new one before recompiling like so:
```bash
rm config.h

sudo make config.h

sudo make install
```
do whatever works best for you!

## Xresources
Take `config.h`/`config.def.h` out of the equation! 

Various options can be configured from `~/.Xresources` using the syntax `st.option: value` :
- `font`
- `color0 ` to `color15`
- `foreground`
- `background`
- `cursor` - cursor color
- `reverseCursor` - reverse cursor color
- `termname`
- `shell`
- `xfps` - frames per second **st** should at maximum draw to the screen
- `actionfps`
- `blinktimeout` - blinking timeout (set to 0 to disable blinking) for the terminal blinking attribute
- `bellvolume`
- `tabspaces`
- `borderpx`
- `cwscale` - Kerning / character bounding-box multipliers
- `chscale`

After updating `~/.Xresources`, remember to execute the command:
```bash
xrdb ~/.Xresources
```
or else your changes will not show up.

**NOTE**: If you already have a `~/.Xresources` file, any universal variables you have may affect **st** upon installation.

  For example: `*.foreground: #FFFFFF` will make your foreground color white even though it does not have the prefix **st**, such as: `st.foreground: #FFFFFF`. 

## Right click to plumb

Inspired by plan9's acme and plumber: right-click some selected text to send it to the plumbing program of your choosing:
  
- open an URL in a browser
- view an image, PDF, ...
- jump from logs to editor, at the specified line/col
- etc

You can set the command to execute in the `config.h` variable (`static char *plumber_cmd = " "`), The default is `"xdg-open %s"`, which opens a file or URL in the user's preferred application.

## Font2
This patch allows you to configure a secondary font. This can be used to display glyphs that may not be present in your primary font. In this fork your primary font is set as `mono`, so it will match your system font. `Font2` is set as `Inconsolata` by default since it is a very common font. Change the variable (`static char *font2`) in `config.h` to whatever glyph supporting font you have on your system.

To search what fonts you have enter the following command:
```bash
fc-list :fontformat=TrueType -f "%{family}\n" | sort -u | less
```
**NOTE**: `Fira Code` fonts work well for `Font2` in my experience. | **Package**: `ttf-fira-code` on Arch-based systems.

## Disable Bold and Italic fonts
Get rid of bold, italic, and roman fonts for a cleaner looking prompt by setting the following `config.h` variables to (**1**):

  * `int disablebold = 1;`

  * `int disableitalic = 1;`

  * `int disableroman = 1;`

\* set to (**0**) to enable each if desired.

## Blinking cursor
Edit: (`static unsigned int cursorshape = [1-6]`) in your `config.h` file to set any of the following cursors: 

  1. Blinking Block ("█")
  2. Block ("█")
  3. Blinking Underline ("_")
  4. Underline ("_")
  5. Blinking Bar ("\|")
  6. Bar ("\|")

## AnyGeometry
set **st**'s width and height as pixels instead of cells, both from the command line:
```bash
st -G [width]x[height]
```
or the `config.h` file variables: 
 
 * `static Geometry geometry = PixelGeometry;` 
 
 * `static unsigned int width = x;` 
 
 * `static unsigned int height = x;`

\* set (`static Geometry geometry = CellGeometry;`) to set size by cell instead of pixels.

## Scrollback
Scrollback is still in an experimental state in **st**. You may experience some buggy behavior, but it is still nice to have and works well 99% of the time, so I included it. 

**NOTE**: If you are experiencing weird scrolling issues while in insert mode in vim/nvim. copy and paste this into your `vimrc` file:
```vim
 if $TERM ==# 'st-256color'
      set mouse=a
      map <ScrollWheelUp> <C-Y>
      map <ScrollWheelDown> <C-E>
  endif
```

## Desktop Entry
The shell script `desktopentry.sh` is a quick and dirty shell script that creates a `st.desktop` file @ `~/.local/share/applications`
and installs it to your system, without having to patch **st** itself. This allows **st** to be accessible from your desktop/application launcher

**Requirements**:  

  * `desktop-file-utils`

run by entering:
```bash
bash ./desktopentry.sh
``` 
**NOTE**: There is a [patch](https://st.suckless.org/patches/desktopentry/) for this already, If you'd rather use that you can patch it to **st** by saving the `.diff` file into your **st** directory and entering the command:
```bash
patch -p1 < 'patch-file-name.diff'
```
\* **ALWAYS** back up your build before attempting a patch.

### Thanks
Thanks to Suckless.org for creating [Simple terminal](https://suckless.org/)

Thanks to AUR for [Blinking cursor patch](https://aur.archlinux.org/cgit/aur.git/tree/st-blinking-cursor-20180605.diff?h=st-patched-git)
