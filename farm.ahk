#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable variables (easy to adjust)
<<<<<<< HEAD
UnitsPerDirection := 10      ; Number of walk+attack units before turning around
=======
UnitsPerDirection := 6      ; Number of walk+attack units before turning around
>>>>>>> d3780f1affabbefd3f0d7139a5887f53bab5a05a
LeftKey := "Left"           ; Key to walk Left
RightKey := "Right"         ; Key to walk Right
UnitCounter := 0
Direction := "Right"

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

; Function: Toggle direction after a set number of units
ToggleDirection() {
    global Direction
    Direction := (Direction = "Left") ? "Right" : "Left"
}

BoostCheck() {
    ; global some timer at the top (lowest boost cd)
    ; when boostcheck runs it takes A_Now and compares it to A_Last time it ran and if its over the cd timer it casts and resets A_Last
}

FeedPet() {
    ;basically the same as boostcheck but for the pet
}

; Main routine to handle walking and attacking
MainLoop() {
    global UnitsPerDirection, UnitCounter, Direction

    Loop, {  ; Start of the while loop
        if IsMapleStoryActive() {
            stime := 800
            mtime := 1000
            
            Send {Del}
            Sleep, %stime%
            Send {Ins}
            Sleep, %stime%

            
            Send {%Direction% down}

            Loop, %UnitsPerDirection% {
                Send {Shift}
                Send {Ctrl}
                Sleep, %mtime%
                ; Send {Ctrl}
                ; Sleep, %mtime%
                }

                Send {%Direction% up}
            
            ToggleDirection()
        }
    }
}

MainLoop()

F3::
Send {Left up}
Send {Right up}
Send {Up up}
Send {Down up}
Pause
return