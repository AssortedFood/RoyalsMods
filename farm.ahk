#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable variables (easy to adjust)
UnitsPerDirection := 8      ; Number of walk+attack units before turning around
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

; Main routine to handle walking and attacking
MainLoop() {
    global UnitsPerDirection, UnitCounter, Direction, AttackKey, AttackCount, PickupKey, ZPressCount, ZPressInterval

    Loop, {  ; Start of the while loop
        if IsMapleStoryActive() {
            stime := 800
            mtime := 1000 ;850 plus some leniency
            
            Send {Del}
            Sleep, %stime%
            Send {Ins}
            Sleep, %stime%

            Loop, %UnitsPerDirection% {
                Send {%Direction% down}
                Send {Ctrl}
                Sleep, %mtime%
                Send {Ctrl}
                Send {Shift}
                Sleep, %mtime%
                Send {%Direction% up}
                }
            
            ToggleDirection()
        }
    }
}

MainLoop()