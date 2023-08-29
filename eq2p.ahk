; Create GUI for window selection
Gui, Add, ListBox, vWinList w400 h200 Multi
FillList()
Gui, Add, Text, , Keystroke for Start:
Gui, Add, Edit, vStartKey w50, 1 ; Default value
Gui, Add, Button, gToggle, Start
Gui, Add, Text, , Keystroke for Follow:
Gui, Add, Edit, vFollowKey w50, 2 ; Default value
Gui, Add, Button, gFollow, Follow
Gui, Add, Edit, w400 vStat ReadOnly, Status: Inactive
Gui, Add, Edit, w400 h100 vLog ReadOnly -Wrap
Gui, Show
return

FillList()
{
    targets := ["is1", "is2", "is3", "is4", "is5", "is6", "is7"]
    WinGet, wID, list
    Loop, %wID%
    {
        thisID := wID%A_Index%
        WinGetTitle, t, ahk_id %thisID%
        for _, n in targets
        {
            if (InStr(t, n))
            {
                GuiControl,, WinList, %t%
                break
            }
        }
    }
}

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
    GuiControlGet, win, , WinList
    GuiControlGet, k, , FollowKey
    SendToWindows(k, win)
return

SendStartKey:
    GuiControlGet, win, , WinList
    GuiControlGet, k, , StartKey
    SendToWindows(k, win)
return

SendToWindows(k, win)
{
    Loop, Parse, win, |
    {
        WinGet, wID, list, %A_LoopField%
        Loop, %wID%
        {
            thisID := wID%A_Index%
            ControlSend,, %k%, ahk_id %thisID%
        }
    }
}

Append(m)
{
    GuiControl,, Log, % m . "`r`n"
}

GuiClose:
    ExitApp
