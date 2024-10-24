#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")

    