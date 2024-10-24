#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

F9::
reload
return

F10::
stime := 200
mtime := 500
if IsMapleStoryActive() {
    Loop, 100 {
        Send {Space}
        Sleep, %mtime%
        Send {Left}
        Sleep, %stime%
        Send {Left}
        Sleep, %stime%
        Send {Enter}
        Sleep, %mtime%
        Send {Space}
        Sleep, %mtime%
    }
}
return