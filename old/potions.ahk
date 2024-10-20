#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable Variables
hpPotionHealAmount := 50  ; Amount of HP healed by potion
mpPotionHealAmount := 100  ; Amount of MP healed by potion
hpKey := "End"  ; Key for HP potion
mpKey := "PgDn"  ; Key for MP potion
hpThreshold := 50  ; % HP threshold to trigger potion
mpThreshold := 50  ; % MP threshold to trigger potion
hpPotionsToUse := 1  ; Number of HP potions to use
mpPotionsToUse := 1  ; Number of MP potions to use

; Function: Check if MapleStory is active
IsMapleStoryActive() {
    return WinActive("MapleStory")
}

; Function: Press potion keys based on the amount of potions to use
UsePotion(key, numPotions) {
    Loop, %numPotions% {
        Send, %key%
        Sleep, 50  ; Small delay between potion uses (50ms)
    }
}

; Function: Check HP and MP and use potions if necessary
CheckHPMP() {
    global hpKey, mpKey, hpThreshold, mpThreshold, hpPotionsToUse, mpPotionsToUse

    ; Get the percentage of HP and MP
    hpPercent := GetHPPercent()
    mpPercent := GetMPPercent()

    ; Use HP potion if HP is below threshold
    if (hpPercent <= hpThreshold) {
        UsePotion(hpKey, hpPotionsToUse)
    }

    ; Use MP potion if MP is below threshold
    if (mpPercent <= mpThreshold) {
        UsePotion(mpKey, mpPotionsToUse)
    }
}

GetHPPercent() {
    ; Hardcoded box area (coordinates of the top-left corner, width, and height)
    x1 := 0  ; Top-left corner X
    y1 := 0  ; Top-left corner Y
    boxWidth := 100  ; Width of the entire box
    boxHeight := 50  ; Height of the box

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
    x1 := 0  ; Top-left corner X
    y1 := 0  ; Top-left corner Y
    boxWidth := 100  ; Width of the entire box
    boxHeight := 50  ; Height of the box

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

; Main loop to check HP/MP and use potions
SetTimer, CheckLoop, 1000  ; Check every second
CheckLoop:
    if IsMapleStoryActive() {
        CheckHPMP()
    }
Return
