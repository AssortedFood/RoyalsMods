import pygetwindow as gw
import pyautogui

def resize_and_position_mapleStory(width, height, position):
    # Find the MapleStory window
    windows = gw.getWindowsWithTitle('MapleStory')
    if not windows:
        print("MapleStory window not found.")
        return

    mapleStory = windows[0]

    mapleStory.activate()
    mapleStory.resizeTo(width, height)
    screen_width, screen_height = pyautogui.size()

    if position == "L":
        x = 0
        y = 0
    elif position == "R":
        x = screen_width - width
        y = 0
    elif position == "M":
        x = (screen_width - width) // 2
        y = 0
    else:
        print(f"Provided position ({position}) is invalid.")

    # Move the window to the top-center position
    mapleStory.moveTo(x, y)

    print(f"Resized and moved MapleStory window to {width}x{height}, top-center of the screen.")

# Example usage
size = 340
w = size * 4
h = size * 3
resize_and_position_mapleStory(w, h, "M")
