#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles
DetectHiddenWindows, On

F1::
Send ^!{Tab}
return

F2::
Run, powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File "C:\Users\oxi\Projects\RoyalsMods\UpdateAndRunAsAdmin.ps1"
return

F3::
Send {Left up}
Send {Right up}
Send {Up up}
Send {Down up}
PostMessage, 0x0111, 65306,,, farm.ahk
return