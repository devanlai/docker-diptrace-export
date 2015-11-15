#!/bin/sh
TEMP_IMPORT_NAME=import.asc
TEMP_IMPORT_PATH=~/DipTrace/$TEMP_IMPORT_NAME
TEMP_EXPORT_PATH=~/DipTrace/export.dch
cat - > $TEMP_IMPORT_PATH

AHK_PATH_WIN=`winepath /tmp/bin/AutoHotkey.exe 2>/dev/null`
DT_PATH=`winepath "C:\Program Files\DipTrace\Schematic.exe" 2>/dev/null`
WINE_PATH=`which wine`

export WINE_PATH DT_PATH
xvfb-run wine "$AHK_PATH_WIN" /tmp/ahk/asc-to-schematic.ahk 2>/dev/null 1>/dev/null

/tmp/bin/waitfor.sh wineserver

if [ -f "$TEMP_EXPORT_PATH" ]; then
    cat $TEMP_EXPORT_PATH
else
	echo "Export failed" >/dev/stderr
fi;
