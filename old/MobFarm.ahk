#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
SetTitleMatchMode, 3

; Function to add a window to the array
AddWindow(hwnd) {
    global MapleRoyalsWindows
    WinGetTitle, title, ahk_id %hwnd%
    if InStr(title, "MapleRoyals") {
        MapleRoyalsWindows.Push(hwnd)
    }
}

; Function to relay commands to all clients
AllClients(command, args*) {
    global MapleRoyalsWindows
    for index, hwnd in MapleRoyalsWindows {
        ; Activate the window
        WinActivate, ahk_id %hwnd%
        ; Wait for the window to be active
        WinWaitActive, ahk_id %hwnd%

        ; Execute the command
        if (command = "SendInput") {
            SendInput, % args[1]
        } else if (command = "Click") {
            Click, % args[1] ", " args[2]
        } else {
            ; Execute custom commands
            func := Func(command)
            func.Call(args*)
        }
    }
}

global MapleRoyalsWindows := []
Usernames := []
Passwords := []

RunWait, Login.py,, Hide

; Get all window handles
WinGet, id, list
Loop, %id% {
    this_id := id%A_Index%
    AddWindow(this_id)
}

; Read usernames and passwords from ini file
Loop, 4 {
    IniRead, current_username, data.ini, Usernames, %A_Index%
    IniRead, current_password, data.ini, Passwords, %A_Index%
    Usernames[A_Index] := current_username
    Passwords[A_Index] := current_password
}

; Example usage of AllClients function
; AllClients("SendInput", "your command here")

; Example: Click at specific coordinates in all clients
AllClients("Click", 508, 246)
