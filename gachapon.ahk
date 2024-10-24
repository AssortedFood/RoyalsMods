#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

stime := 100
if IsMapleStoryActive() {
    Loop, 100 {
        Send {Space}
        Sleep, %stime%
        Send {Left}
        Sleep, %stime%
        Send {Left}
        Sleep, %stime%
        Send {Enter}
        Sleep, %stime%
        Send {Space}
        Sleep, %stime%
    }
}
return