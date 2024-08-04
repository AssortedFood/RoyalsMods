import pygetwindow as gw
import pyautogui

def resize_and_position_mapleroyals(width, height, position):
    # Find the MapleRoyals window
    windows = gw.getWindowsWithTitle('MapleRoyals')
    if not windows:
        print("MapleRoyals window not found.")
        return

    mapleroyals_window = windows[0]

    mapleroyals_window.activate()
    mapleroyals_window.resizeTo(width, height)
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
    mapleroyals_window.moveTo(x, y)

    print(f"Resized and moved MapleRoyals window to {width}x{height}, top-center of the screen.")

# Example usage
size = 340
w = size * 4
h = size * 3
resize_and_position_mapleroyals(w, h, "R")
