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

; i need to co-ordinates of the box that is hp and also for mana
; i need the colour/colour range for the background colour of the bars
; the function that checks hp and mana checks based on a given %
; some variable for hp and another for mana that decides when to activate the potion
; some variable for hp and another for mana that decides how many potions to activate