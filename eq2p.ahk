; Create GUI for sending keystrokes
Gui, Add, ListBox, vWinList w400 h200 Multi
FillList()
Gui, Add, Text, , Keystroke for Start:
Gui, Add, Edit, vStartKey w50, 1 ; Default value for Start button
Gui, Add, Button, gToggle, Start
Gui, Add, Text, , Keystroke for Follow:
Gui, Add, Edit, vFollowKey w50, 2 ; Default value for Follow button
Gui, Add, Button, gFollow, Follow
Gui, Add, Edit, w400 vStat ReadOnly, Status: Inactive
Gui, Add, Edit, w400 h100 vLog ReadOnly -VScroll ; Log box
Gui, Show, w500 h500, MacroMasher by Billster



return

Toggle:
    GuiControlGet, bText,, Button1
    if (bText = "Start")
    {
        GuiControl,,Button1, Stop
        GuiControl,,Stat, Status: Active
        SetTimer, SendStartKey, 250
    }
    else
    {
        GuiControl,,Button1, Start
        GuiControl,,Stat, Status: Inactive
        SetTimer, SendStartKey, Off
    }
return

Follow:
    GuiControlGet, k,, FollowKey
    GuiControlGet, win,, WinList
    SendToSelectedWindows(k, win)
return

SendStartKey:
    GuiControlGet, k,, StartKey
    GuiControlGet, win,, WinList
    SendToSelectedWindows(k, win)
return

SendToSelectedWindows(k, win)
{
    Loop, Parse, win, |
    {
        ; Send the key to the selected window title
        ControlSend,, %k%, %A_LoopField%
    }
}

FillList()
{
    ; Find all windows related to the everquest2.exe process
    WinGet, wList, List, ahk_exe everquest2.exe
    Loop, %wList%
    {
        thisID := wList%A_Index%
        WinGetTitle, thisTitle, ahk_id %thisID%
        GuiControl,, WinList, %thisTitle%
    }
}

Append(m)
{
    GuiControlGet, currentLog,, Log
    combinedLog := currentLog . m . "`r`n"
    GuiControl,, Log, % combinedLog
}

GuiClose:
    ExitApp
