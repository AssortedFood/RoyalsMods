package main

import (
	"fmt"
	"image"
	"image/png"
	"os"

	"github.com/kbinani/screenshot"
)

// Function to capture a screenshot of a specific region
func captureScreenshot(x1, y1, x2, y2 int, filename string) {
	bounds := image.Rect(x1, y1, x2, y2)
	img, err := screenshot.CaptureRect(bounds)
	if err != nil {
		fmt.Println("Error capturing screenshot:", err)
		return
	}

	// Save the screenshot to a file
	file, err := os.Create(filename)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	err = png.Encode(file, img)
	if err != nil {
		fmt.Println("Error encoding image:", err)
		return
	}

	fmt.Println("Screenshot saved to", filename)
}

func main() {
	// Coordinates for HP (336, 1055) to (486, 1067)
	captureScreenshot(336, 1055, 486, 1067, "hp.png")

	// Coordinates for MP (498, 1055) to (648, 1067)
	captureScreenshot(498, 1055, 648, 1067, "mp.png")

	fmt.Println("HP and MP screenshots captured.")
}
