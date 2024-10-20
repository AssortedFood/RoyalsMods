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

    ; Initialize an empty list to store coordinates of matches
    matches := ""

    ; Loop through the screen to find matching pixels
    Loop {
        PixelSearch, foundX, foundY, 0, 0, screenWidth - 1, screenHeight - 1, targetColour, variation, Fast RGB
        if (ErrorLevel = 0) {
            ; Store the found coordinates
            matches .= "X: " foundX " Y: " foundY "`n"
            ; Move the search start point to avoid matching the same pixel again
            PixelSearch, foundX, foundY, foundX + 1, foundY + 1, screenWidth - 1, screenHeight - 1, targetColour, variation, Fast RGB
        } else {
            break  ; No more matches
        }
    }

    ; Return the found coordinates
    if (matches = "")
        MsgBox, No matching pixels found.
    else
        MsgBox, Found matches:`n%matches%
}

; Example usage of the function
F5::
{
    targetColour := "0xBABABA"  ; Define the target colour
    variation := 30  ; Set the colour variation
    SearchPixelColour(targetColour, variation)
}
return
