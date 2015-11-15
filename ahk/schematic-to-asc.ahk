SendMode Input

ExportAsAscii(name)
{
    WinWaitActive, ahk_class #32770,, 3

    myFileName := name . ".asc"
    ControlSetText, Edit1, %myFileName%, A
    ControlClick, &Save, A

    Sleep, 1000

    WinWaitNotActive,, ahk_class #32770,, 3
}

OpenAndExportAscii()
{
    Run, %WINE_PATH% "%DT_PATH%" "%SCH_PATH%"
    WinWait, ahk_exe Schematic.exe,,10
    WinActivate, ahk_exe Schematic.exe

    Sleep, 8000

    Send, !fxd

    ExportAsAscii("export")
    Sleep, 1000

    Send, !{F4}
}

OpenAndExportAscii()

Return