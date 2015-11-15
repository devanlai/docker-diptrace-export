SendMode Input

SaveSheetBmp(index, name)
{
    ; Open the print preview dialog
    IfWinNotExist, Preview
    {
        Send, ^!p
        WinWait, Preview,, 3
    }

    ; Select the sheet we want
    Control, Choose, %index%, TComboBox2, Preview

    ; Open sheet export dialog
    ControlClick, TButton1, Preview

    ; Configure export settings
    WinWaitActive, Save Picture,, 3
    ControlSetText, Edit1, Objects, Save Picture
	Control, Check,, TCheckBox1, Save Picture
    ControlSetText, TEdit1, %EXP_DPI%, Save Picture

    ; Open save dialog
    ControlClick, OK, Save Picture
    WinWaitNotActive, Save Picture,, 3

    ; Save the bitmap
    myFileName := name . ".bmp"
    ControlSetText, Edit1, %myFileName%, A
    ControlClick, &Save, A
}

SaveAllSheetsBmp()
{
    ; Open the print preview dialog
    IfWinNotExist, Preview
    {
        Send, ^!p
        WinWait, Preview,, 3
    }

    ; Read sheet names
    Sheets := []
    ControlGet, List, List, , TComboBox2, Preview

    ; Rows are delimited by linefeeds (`n).
    Loop, Parse, List, `n
    {
        RowNumber := A_Index
        Sheets.Insert(A_LoopField)
    }

    ; Export each sheet
    for index, name in Sheets
    {
        SaveSheetBmp(index, name)
        WinWaitActive,Preview,, 3
    }
}

OpenAndExportRecentBmp()
{
    Run, %WINE_PATH% "%DT_PATH%" "%SCH_PATH%"
    WinWait, ahk_exe Schematic.exe,,10
    WinActivate, ahk_exe Schematic.exe

    Sleep, 8000

    SaveAllSheetsBmp()
    Sleep, 1000

    ControlClick, Close, Preview

    Send, !{F4}
}

OpenAndExportRecentBmp()

Return
