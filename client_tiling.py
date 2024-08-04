import pygetwindow as gw
import pyautogui
import math

def resize_and_position_mapleroyals(num_windows):
    # Get screen dimensions
    screen_width, screen_height = pyautogui.size()

    # Calculate the maximum possible width and height for each window
    aspect_ratio = 4 / 3
    screen_aspect_ratio = 16 / 9

    # Determine the optimal number of rows and columns to fit windows on the screen
    for cols in range(1, num_windows + 1):
        rows = math.ceil(num_windows / cols)
        window_width = screen_width / cols
        window_height = window_width / aspect_ratio
        if rows * window_height <= screen_height:
            break

    # Resize all windows to the calculated width and height
    windows = gw.getWindowsWithTitle('MapleRoyals')
    if not windows:
        print("MapleRoyals window not found.")
        return

    windows = windows[:num_windows]  # Limit to the number of specified windows
    window_width = int(window_width)
    window_height = int(window_height)

    for i, window in enumerate(windows):
        col = i % cols
        row = i // cols
        x = col * window_width
        y = row * window_height
        window.activate()
        window.resizeTo(window_width, window_height)
        window.moveTo(x, y)

    print(f"Resized and repositioned {num_windows} MapleRoyals windows to {window_width}x{window_height}.")

# Example usage
num_windows = 4
resize_and_position_mapleroyals(num_windows)
