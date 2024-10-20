#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
CoordMode, Pixel, Screen  ; Use screen coordinates for PixelSearch

; Function to search the whole screen for a specific colour with a variation
SearchPixelColour(targetColour, variation) {
    ; Get screen dimensions using A_ScreenWidth and A_ScreenHeight
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight

    ; Define the log file path
    logFilePath := A_ScriptDir . "\PixelSearchLog.txt"

    ; Initialize an empty list to store coordinates of matches
    matches := ""
    
    ; Start logging progress
    FileAppend, Searching for colour: %targetColour% with variation: %variation%`n, %logFilePath%

    ; Loop through the screen to find matching pixels
    Loop {
        PixelSearch, foundX, foundY, 0, 0, screenWidth - 1, screenHeight - 1, targetColour, variation, Fast RGB
        if (ErrorLevel = 0) {
            ; Store the found coordinates and append to the log file
            matches := "X: " foundX " Y: " foundY "`n"
            FileAppend, Match found at %matches%, %logFilePath%
            
            ; Move the search start point to avoid matching the same pixel again
            PixelSearch, foundX, foundY, foundX + 1, foundY + 1, screenWidth - 1, screenHeight - 1, targetColour, variation, Fast RGB
        } else {
            ; Append when no match is found for this search iteration
            FileAppend, No more matches found.`n, %logFilePath%
            break  ; No more matches
        }
    }

    ; Final status
    if (matches = "")
        FileAppend, No matching pixels found.`n, %logFilePath%
    else
        FileAppend, Search completed.`n, %logFilePath%
}

; Example usage of the function
F5::
{
    MsgBox % "Starting search..." ;
    targetColour := "0xBABABA"  ; Define the target colour
    variation := 30  ; Set the colour variation
    SearchPixelColour(targetColour, variation)
}
return
