#!/bin/sh
IMPORT_PATH_WIN=`winepath -w "$1"`
AHK_PATH_WIN="C:\Program Files\AutoHotkey\AutoHotkey.exe"
DT_PATH=`winepath "C:\Program Files\DipTrace\Schematic.exe"`
WINE_PATH=`which wine`

WINE_PATH="$WINE_PATH" DT_PATH="$DT_PATH" SCH_PATH="$IMPORT_PATH_WIN" \
xvfb-run wine "$AHK_PATH_WIN" /tmp/ahk/schematic-to-bmp.ahk

/tmp/bin/waitfor.sh wineserver && mv ~/DipTrace/*.bmp $2/;
