#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetTitleMatchMode, 2  ; Partial match for window titles

; Configurable Variables
hpPotionHealAmount := 500  ; Amount of HP healed by potion
mpPotionHealAmount := 300  ; Amount of MP healed by potion
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

; Function: Get HP percentage based on the bar's colour
GetHPPercent() {
    global hpBarX, hpBarY, hpBarColour

    ; PixelGetColor example to detect HP bar colour
    PixelGetColor, hpColor, %hpBarX%, %hpBarY%
    if (hpColor = hpBarColour) {
        return 50  ; Placeholder percentage, you'll need logic to calculate actual HP percentage
    }
    return 100  ; Default to full HP if no matching colour is found
}

; Function: Get MP percentage based on the bar's colour
GetMPPercent() {
    global mpBarX, mpBarY, mpBarColour

    ; PixelGetColor example to detect MP bar colour
    PixelGetColor, mpColor, %mpBarX%, %mpBarY%
    if (mpColor = mpBarColour) {
        return 50  ; Placeholder percentage, you'll need logic to calculate actual MP percentage
    }
    return 100  ; Default to full MP if no matching colour is found
}

; Main loop to check HP/MP and use potions
SetTimer, CheckLoop, 1000  ; Check every second
CheckLoop:
    if IsMapleStoryActive() {
        CheckHPMP()
    }
Return
