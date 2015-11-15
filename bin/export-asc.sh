#!/bin/sh
TEMP_SCHEMATIC_NAME="/tmp/export.dch"
TEMP_ASCII_PATH=~/DipTrace/export.asc
cat - > /tmp/export.dch
IMPORT_PATH_WIN=`winepath -w "$TEMP_SCHEMATIC_NAME" 2>/dev/null`
AHK_PATH_WIN=`winepath /tmp/bin/AutoHotkey.exe 2>/dev/null`
DT_PATH=`winepath "C:\Program Files\DipTrace\Schematic.exe" 2>/dev/null`
WINE_PATH=`which wine`
SCH_PATH=$IMPORT_PATH_WIN

export WINE_PATH DT_PATH SCH_PATH
xvfb-run wine "$AHK_PATH_WIN" /tmp/ahk/schematic-to-asc.ahk 2>/dev/null 1>/dev/null

/tmp/bin/waitfor.sh wineserver

if [ -f "$TEMP_ASCII_PATH" ]; then
    cat $TEMP_ASCII_PATH
else
	echo "Export failed" >/dev/stderr
fi;
