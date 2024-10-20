#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

; Load environment variable from .env file
FileRead, envContent, .env

; Parse the variable from the content
Loop, Parse, envContent, `n, `r
{
    StringSplit, keyValue, A_LoopField, =
    if (keyValue1 = "PASSWORD")
    {
        password := keyValue2
        break
    }
}

Loop, {
    if IsMapleStoryActive() {
        Click, 450, 333
        Sleep, 50
        Clipboard := "Oxidising"
        Send ^v
        Sleep, 50
        Send {Tab}
        Sleep, 50
        Send %password%
        Sleep, 50
        Send {Enter}
        Sleep, 50
        ExitApp
    }
}

return