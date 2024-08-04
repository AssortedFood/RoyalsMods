#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
SetTitleMatchMode, 3

delaySmall := 12
delayLarge := 36

SetTimer, Check, 250
return

Check:
if WinActive("MapleRoyals May 31 2024 IMG") {
    Suspend, Off
}
else {
    Suspend, On
}
return

RandomDelay(min, max) {
    Random, delay, %min%, %max%
    return delay
}

w::Up
s::Down

a::
    Send {Left down}
    Loop {
        if !GetKeyState("a", "P")
            break
        Send {z}
        Sleep % RandomDelay(delaySmall, delayLarge)
    }
    Send {Left up}
return

d::
    Send {Right down}
    Loop {
        if !GetKeyState("d", "P")
            break
        Send {z}
        Sleep % RandomDelay(delaySmall, delayLarge)
    }
    Send {Right up}
return