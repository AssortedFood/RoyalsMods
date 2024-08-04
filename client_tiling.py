import pygetwindow as gw
import pyautogui
import win32gui
import win32con
import win32api

def bring_window_to_foreground(window):
    try:
        hwnd = window._hWnd  # Get the window handle
        win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)  # Restore the window if minimized
        win32gui.SetForegroundWindow(hwnd)  # Bring the window to the foreground
        # Send Alt key press to ensure it is in the foreground
        win32api.keybd_event(win32con.VK_MENU, 0, win32con.KEYEVENTF_EXTENDEDKEY, 0)
        win32api.keybd_event(win32con.VK_MENU, 0, win32con.KEYEVENTF_EXTENDEDKEY | win32con.KEYEVENTF_KEYUP, 0)
    except Exception as e:
        print(f"Could not activate window: {e}")

def resize_and_position_mapleroyals():
    # Get screen dimensions
    screen_width, screen_height = pyautogui.size()

    # Resize all windows to the calculated width and height
    windows = gw.getWindowsWithTitle('MapleRoyals')
    if not windows:
        print("MapleRoyals window not found.")
        return

    window_width = 710
    window_height = 540

    for i in range(min(4, len(windows))):  # Ensure we do not exceed the number of available windows
        current_window = windows[i]
        if i < 2:
            x = screen_width - (window_width * (i + 1))
            y = 0
        else:
            x = screen_width - (window_width * ((i - 2) + 1))
            y = window_height

        # Attempt to activate the window
        bring_window_to_foreground(current_window)

        # Resize and move only if necessary
        if current_window.width != window_width or current_window.height != window_height:
            current_window.resizeTo(window_width, window_height)
        if current_window.left != x or current_window.top != y:
            current_window.moveTo(x, y)

    print("Resized and repositioned MapleRoyals windows.")

resize_and_position_mapleroyals()