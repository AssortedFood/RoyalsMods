#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

; some main loop with an interval it sleeps after
; some function that takes checks hp and mp
; some function that presses the hp and mana keys
; some variable where i say how much hp and mana the current potions heal
; some variable where i declare which keys are for what
; some function that activates my boosts macro
