#!/bin/bash

# Quick and dirty shell script to make suckless st accessible from desktop, without having to patch src.
# Requires package:  `desktop-file-utils`

XDG_DESKTOP_HOME=${XDG_DESKTOP_HOME:-${HOME}/.local/share/applications}
DESKTOP_FILE="${XDG_DESKTOP_HOME}/st.desktop"

if [ -e $DESKTOP_FILE ]; then
    printf '%s ' "$DESKTOP_FILE already exists"
else
    DESKTOP_INFO="\
[Desktop Entry]
Categories=System;TerminalEmulator;
Comment[en_US]=Suckless terminal emulator for the X window system
Comment=Suckless terminal emulator for the X window system
Encoding=UTF-8
Exec=st
GenericName[en_US]=Terminal
GenericName=Terminal
Icon=st
Keywords=shell;prompt;command;commandline;cmd;
Name[en_US]=Simple Terminal
Name=Simple Terminal
Path=
Terminal=false
Type=Application
"
    printf '%s\n' "$DESKTOP_INFO" > "$DESKTOP_FILE";
    desktop-file-install --dir="$XDG_DESKTOP_HOME" "$DESKTOP_FILE" 2>/dev/null;
    update-desktop-database "$XDG_DESKTOP_HOME" 2>/dev/null;
fi

#MIT License
#
#Copyright (c) 2020 FeloniousBonk
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

