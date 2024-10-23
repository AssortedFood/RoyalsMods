#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable variables (easy to adjust)
UnitsPerDirection := 4      ; Number of walk+attack units before turning around
WalkDuration := 300         ; Duration of walking in milliseconds
AttackCount := 1
ZPressCount := 5            ; Number of Z presses for item pickup
ZPressInterval := 20        ; Interval between Z presses in milliseconds
AttackKey := "Control"      ; Key to use for attacks (can change later)
PickupKey := "z"            ; Key to use for item pickup
LeftKey := "Left"           ; Key to walk Left
RightKey := "Right"         ; Key to walk Right

UnitCounter := 0
Direction := "Left"

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

; Function: Perform an action (like attacking or picking up items)
PerformAction(actionKey, count, delay := 50) {
    Loop % count {
        if IsMapleStoryActive() {
            Send {%actionKey%}
            Sleep, %delay%
        }
    }
}

; Function: Perform multiple presses (e.g., Z for item pickup)
MultiPress(actionKey, pressCount, interval) {
    if IsMapleStoryActive() {
        Loop, pressCount {
            PerformAction(actionKey, 20)
            Sleep, %interval%
        }
    }
}

; Function: Move in a given direction (Left or Right)
MoveAndPickUp(direction) {
    global WalkDuration, LeftKey, RightKey, PickupKey
    ZPressCount := Floor(WalkDuration / 20)
    if IsMapleStoryActive() {
        key := (direction = "Left") ? LeftKey : RightKey
        Send {%key% down}
        Loop, %ZPressCount% {
            Send {%PickupKey%}
            Sleep, 20
        }
        Send {%key% up}
    }
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
            stime := 500
            mtime := 900 ;850 plus some leniency
            
            Send {Del}
            Sleep, %stime%
            Send {Ins}
            Sleep, %stime%

            Loop, %UnitsPerDirection% {
                Send {%Direction% down}
                Send {Ctrl}
                Send {Shift}
                Sleep, %mtime%
                Send {%Direction% up}
                ToggleDirection()
                }
        }
    }
}

MainLoop()