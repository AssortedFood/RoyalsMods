#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles
CoordMode, Pixel, Screen

GetHPPercent() {
    ; Hardcoded box area (coordinates of the top-left corner, width, and height)
    x1 := 336  ; Top-left corner X
    y1 := 1055  ; Top-left corner Y
    boxWidth := 150  ; Width of the entire box
    boxHeight := 12  ; Height of the box

    ; Define the single target colour (in hexadecimal format)
    targetColour := "0xBABABA"

    ; Calculate the width of each decile
    decileWidth := boxWidth / 10

    ; Loop from decile 100 down to decile 10 (i.e., 10 to 1)
    Loop, 10
    {
        decileId := 11 - A_Index  ; Calculate decile ID (100 to 10)
        decileX := x1 + (decileId - 1) * decileWidth  ; Calculate X coordinate for this decile

        ; Define the coordinates of the current decile (box)
        decileX2 := decileX + decileWidth - 1  ; Right side of the decile

        ; Use PixelSearch to check for the target colour in the decile
        PixelSearch, foundX, foundY, decileX, y1, decileX2, y1 + boxHeight - 1, targetColour, 30, Fast RGB
        if (ErrorLevel = 0) {
            return decileId * 10  ; Colour found, return decile ID (100, 90, etc.)
        }
    }

    return 100  ; No colour found in any decile
}

GetMPPercent() {
    ; Hardcoded box area (coordinates of the top-left corner, width, and height)
    x1 := 498  ; Top-left corner X
    y1 := 1055  ; Top-left corner Y
    boxWidth := 150  ; Width of the entire box
    boxHeight := 12  ; Height of the box

    ; Define the single target colour (in hexadecimal format)
    targetColour := "0xBABABA"

    ; Calculate the width of each decile
    decileWidth := boxWidth / 10

    ; Loop from decile 100 down to decile 10 (i.e., 10 to 1)
    Loop, 10
    {
        decileId := 11 - A_Index  ; Calculate decile ID (100 to 10)
        decileX := x1 + (decileId - 1) * decileWidth  ; Calculate X coordinate for this decile

        ; Define the coordinates of the current decile (box)
        decileX2 := decileX + decileWidth - 1  ; Right side of the decile

        ; Use PixelSearch to check for the target colour in the decile
        X1 := decileX
        Y1 := y1
        X2 := decileX2
        Y2 := y1 + boxHeight - 1
        ; MsgBox % "X1: " . X1 . "`nY1: " . Y1 . "`nX2: " . X2 . "`nY2: " . Y2 . "`nTarget: " . targetColour
        PixelSearch, foundX, foundY, X1, Y1, X2, y1 + Y2, targetColour, 30, Fast RGB
        if (ErrorLevel = 0) {
            return decileId * 10  ; Colour found, return decile ID (100, 90, etc.)
        }
    }

    return 100  ; No colour found in any decile
}

F4::
hpValue := GetHPPercent()
mpValue := GetMPPercent()
MsgBox % "HP: " . hpValue . "`nMP: " . mpValue
return
