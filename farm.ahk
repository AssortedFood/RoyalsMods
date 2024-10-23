#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable variables (easy to adjust)
UnitsPerDirection := 1      ; Number of walk+attack units before turning around
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
            ; hold right
            ; some action then switch direction and loop
            ; then test the attack tele combo
            ; combine it all
            ; Increment the unit counter and check for direction toggle 
            UnitCounter++
            if (UnitCounter >= UnitsPerDirection) {
                UnitCounter := 0
                ToggleDirection()
            }
        }
        ; Sleep, 100  ; Adjust delay between loops for more organic timing
    }
}

MainLoop()