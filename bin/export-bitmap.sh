#!/bin/sh
TEMP_SCHEMATIC_NAME="/tmp/export.dch"
cat - > /tmp/export.dch
DIR_NAME=${1:-schematic}
IMPORT_PATH_WIN=`winepath -w "$TEMP_SCHEMATIC_NAME" 2>/dev/null`
AHK_PATH_WIN=`winepath /tmp/bin/AutoHotkey.exe 2>/dev/null`
DT_PATH=`winepath "C:\Program Files\DipTrace\Schematic.exe" 2>/dev/null`
WINE_PATH=`which wine`
EXP_DPI=${DPI:-300}
SCH_PATH=$IMPORT_PATH_WIN

export WINE_PATH DT_PATH SCH_PATH EXP_DPI
xvfb-run wine "$AHK_PATH_WIN" /tmp/ahk/schematic-to-bmp.ahk 2>/dev/null 1>/dev/null

/tmp/bin/waitfor.sh wineserver

mkdir -p /tmp/export/$DIR_NAME
cp ~/DipTrace/*.bmp /tmp/export/$DIR_NAME
cd /tmp/export/
zip - $DIR_NAME $DIR_NAME/* 2>/dev/null
