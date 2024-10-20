#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
CoordMode, Pixel, Screen  ; Use screen coordinates for PixelSearch

; Function to search the screen for a specific colour with a variation
SearchPixelColour(targetColour, variation) {
    ; Get screen dimensions using A_ScreenWidth and A_ScreenHeight
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight

    ; Define the log file path
    logFilePath := A_ScriptDir . "\PixelSearchLog.txt"

    ; Delete any existing log file
    FileDelete, %logFilePath%

    ; Initialize an array to store the matching coordinates
    matchCoords := []

    ; Initialize the starting point for the search
    x := 0
    y := 0

    ; Start logging progress
    FileAppend, Starting pixel search for colour: %targetColour% with variation: %variation%`n, %logFilePath%

    ; Continue searching while matches are found
    Loop {
        ; Search for the target colour starting from the current position
        PixelSearch, foundX, foundY, x, y, screenWidth - 1, screenHeight - 1, targetColour, variation, Fast RGB

        if (ErrorLevel = 0) {
            ; Store the found coordinates in the array
            matchCoords.Push({x: foundX, y: foundY})

            ; Log the found coordinates to the file
            FileAppend, Match found at X: %foundX% Y: %foundY%`n, %logFilePath%

            ; Move the search start point to avoid matching the same pixel again
            x := foundX + 1
            y := foundY
        } else {
            break  ; No more matches found
        }
    }

    ; Final status after search completes
    FileAppend, Search completed.`n, %logFilePath%

    return matchCoords
}

; Execute the search immediately when the script is run
MsgBox % "Starting search..."
targetColour := "0xBABABA"  ; Define the target colour
variation := 30  ; Set the colour variation

; Get the matching coordinates
matchCoords := SearchPixelColour(targetColour, variation)

MsgBox % "Search complete."
return
