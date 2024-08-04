import pygetwindow as gw
import pyautogui

def resize_and_position_mapleroyals(width, height):
    # Find the MapleRoyals window
    windows = gw.getWindowsWithTitle('MapleRoyals')
    if not windows:
        print("MapleRoyals window not found.")
        return

    mapleroyals_window = windows[0]

    # Activate the window (bring it to the foreground)
    mapleroyals_window.activate()

    # Resize the window
    mapleroyals_window.resizeTo(width, height)

    # Get screen width and height
    screen_width, screen_height = pyautogui.size()

    # Calculate the x position to center the window
    x = (screen_width - width) // 2
    y = 0  # Top of the screen

    # Move the window to the top-center position
    mapleroyals_window.moveTo(x, y)

    print(f"Resized and moved MapleRoyals window to {width}x{height}, top-center of the screen.")

# Example usage
size = 460
w = size * 4
h = size * 3
resize_and_position_mapleroyals(w, h)
