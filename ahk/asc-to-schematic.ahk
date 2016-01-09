SendMode Input

ImportFromAscii(name)
{
    WinWaitActive, ahk_class #32770,, 3

    myFileName := name . ".asc"
    ControlSetText, Edit1, %myFileName%, A
    ControlClick, &Open, A

    Sleep, 9000

    WinWaitNotActive,, ahk_class #32770,, 3
}

SaveAsSchematic(name)
{
    WinWaitActive, ahk_class #32770,, 3

    myFileName := name . ".dch"
    ControlSetText, Edit1, %myFileName%, A
    ControlClick, &Save, A

    Sleep, 1000

    WinWaitNotActive,, ahk_class #32770,, 3
}

ConvertAsciiToSchematic()
{
    Run, %WINE_PATH% "%DT_PATH%"
    WinWait, ahk_exe Schematic.exe,,10
    WinActivate, ahk_exe Schematic.exe

    Sleep, 9000

    Send, !fid

    ImportFromAscii("import")
    Sleep, 9000

    Send, ^s

    SaveAsSchematic("export")
	Sleep, 1000

    Send, !{F4}
}

ConvertAsciiToSchematic()

Return