#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

GetHPPercent() {
    ; Hardcoded box area (coordinates of the top-left corner, width, and height)
    x1 := 336  ; Top-left corner X
    y1 := 1055  ; Top-left corner Y
    boxWidth := 150  ; Width of the entire box
    boxHeight := 12  ; Height of the box

    ; Define the colours (in hexadecimal format)
    colours := ["0xB8B8B8", "0xC3C3C3", "0xCCCCCC", "0x9C9C9C", "0xBEBEBE"]

    ; Calculate the width of each decile
    decileWidth := boxWidth / 10

    ; Loop from decile 100 down to decile 10 (i.e., 10 to 1)
    Loop, 10
    {
        decileId := 11 - A_Index  ; Calculate decile ID (100 to 10)
        decileX := x1 + (decileId - 1) * decileWidth  ; Calculate X coordinate for this decile

        ; Define the coordinates of the current decile (box)
        decileX2 := decileX + decileWidth - 1  ; Right side of the decile

        ; Loop through each colour and use PixelSearch for each decile
        Loop, % colours.MaxIndex() {
            currentColour := colours[A_Index]
            PixelSearch, foundX, foundY, decileX, y1, decileX2, y1 + boxHeight - 1, currentColour, 0, Fast RGB
            if (ErrorLevel = 0) {
                return decileId * 10  ; Colour found, return decile ID (100, 90, etc.)
            }
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

    ; Define the colours (in hexadecimal format)
    colours := ["0xB8B8B8", "0xC3C3C3", "0xCCCCCC", "0x9C9C9C", "0xBEBEBE"]

    ; Calculate the width of each decile
    decileWidth := boxWidth / 10

    ; Loop from decile 100 down to decile 10 (i.e., 10 to 1)
    Loop, 10
    {
        decileId := 11 - A_Index  ; Calculate decile ID (100 to 10)
        decileX := x1 + (decileId - 1) * decileWidth  ; Calculate X coordinate for this decile

        ; Define the coordinates of the current decile (box)
        decileX2 := decileX + decileWidth - 1  ; Right side of the decile

        ; Loop through each colour and use PixelSearch for each decile
        Loop, % colours.MaxIndex() {
            currentColour := colours[A_Index]
            PixelSearch, foundX, foundY, decileX, y1, decileX2, y1 + boxHeight - 1, currentColour, 0, Fast RGB
            if (ErrorLevel = 0) {
                return decileId * 10  ; Colour found, return decile ID (100, 90, etc.)
            }
        }
    }

    return 100  ; No colour found in any decile
}