SendMode Input

SaveSheetDxf(index, name)
{
    Sleep,1000
    IfWinNotExist, Export DXF
    {
        Send, !fxx
        WinWait, Export DXF,, 3
    }

    Control, Choose, %index%, TListBox1, Export DXF
    ControlClick, TButton2, Export DXF

    WinWaitActive, ahk_class #32770,, 3

    myFileName := name . ".dxf"
    ControlSetText, Edit1, %myFileName%, A
    ControlClick, &Save, A

    Sleep, 1000

    WinWaitNotActive,, ahk_class #32770,, 3
}

SaveAllSheetsDxf()
{
    IfWinNotExist, Export DXF
    {
        Send, !fxx
        WinWait, Export DXF,, 3
    }

    ; Read sheet names
    Sheets := []
    ControlGet, List, List, , TListBox1, Export DXF

    ; Rows are delimited by linefeeds (`n).
    Loop, Parse, List, `n
    {
        RowNumber := A_Index
        Sheets.Insert(A_LoopField)
    }

    ; Export each sheet
    for index, name in Sheets
    {
        Sleep, 1000
        SaveSheetDxf(index, name)
    }
}

OpenAndExportRecentDxf()
{
    Run, %WINE_PATH% "%DT_PATH%" "%SCH_PATH%"
    WinWait, ahk_exe Schematic.exe,,10
    WinActivate, ahk_exe Schematic.exe

    Sleep, 8000

    SaveAllSheetsDxf()
    Sleep, 1000

    Send, !{F4}
}

OpenAndExportRecentDxf()

Return