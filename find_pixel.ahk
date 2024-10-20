#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
CoordMode, Pixel, Screen  ; Use screen coordinates for PixelSearch

; Function to search pixel by pixel across the screen for a specific colour with a variation
SearchPixelColour(targetColour, variation) {
    ; Get screen dimensions using A_ScreenWidth and A_ScreenHeight
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight

    ; Define the log file path
    logFilePath := A_ScriptDir . "\PixelSearchLog.txt"

    ; Delete any existing log file
    FileDelete, %logFilePath%

    ; Start logging progress
    FileAppend, Starting pixel search for colour: %targetColour% with variation: %variation%`n, %logFilePath%

    ; Loop through each pixel on the screen (pixel by pixel search)
    Loop, %screenHeight%  ; Loop through rows (Y coordinates)
    {
        y := A_Index - 1  ; Start from 0 in Y axis
        Loop, %screenWidth%  ; Loop through columns (X coordinates)
        {
            x := A_Index - 1  ; Start from 0 in X axis
            
            PixelGetColor, foundColour, x, y, RGB
            ; Check if the current pixel color matches the target colour with the given variation
            PixelSearch, foundX, foundY, x, y, x, y, targetColour, variation, RGB
            if (ErrorLevel = 0) {
                ; Log the coordinates where the match is found
                FileAppend, Match found at X: %x% Y: %y%`n, %logFilePath%
            }
        }
    }

    ; Final status after search completes
    FileAppend, Search completed.`n, %logFilePath%
}

; Execute the search immediately when the script is run
MsgBox % "Starting search..."
targetColour := "0xBABABA"  ; Define the target colour
variation := 30  ; Set the colour variation
SearchPixelColour(targetColour, variation)
return