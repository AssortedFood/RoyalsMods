package main

import (
	"fmt"
	"image"
	"image/png"
	"os"
	"github.com/kbinani/screenshot"
)

func main() {
	// Define the region you want to capture
	x1, y1 := 336, 0
	x2, y2 := 1067, screenshot.GetDisplayBounds(0).Dy()

	// Capture the screenshot of the specified region
	bounds := image.Rect(x1, y1, x2, y2)
	img, err := screenshot.CaptureRect(bounds)
	if err != nil {
		fmt.Println("Error capturing screenshot:", err)
		return
	}

	// Save the screenshot to a file
	file, err := os.Create("screenshot.png")
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

	fmt.Println("Screenshot saved to screenshot.png")
}
