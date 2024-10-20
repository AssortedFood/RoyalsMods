#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

F1::
Send ^!{Tab}
return

F2::
Run, powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File "C:\Users\oxi\Projects\RoyalsMods\RunFarm.ps1"
return

F3::
DetectHiddenWindows, On
WM_COMMAND := 0x0111
ID_FILE_PAUSE := 65403
PostMessage, WM_COMMAND, ID_FILE_PAUSE,,, C:\Users\oxi\Projects\RoyalsMods\farm.ahk ahk_class AutoHotkey
return