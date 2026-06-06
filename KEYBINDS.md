# Hyprland Keybindings

This document details all the custom keybindings configured in the Multi-Nix Hyprland environment. 

> **Note:** The `SUPER` key (also known as the Windows key or Meta key) is the primary modifier for most bindings.

## 🚀 Launchers & Apps
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `Return` | Launch Terminal | Opens the Kitty terminal emulator. |
| `SUPER` + `E` | File Manager | Opens the Yazi terminal file manager inside a large-font Kitty window. |
| `SUPER` + `B` | Brave Browser | Launches the Brave web browser. |
| `SUPER` + `S` | Spotify | Launches the Spotify music player. |
| `SUPER` + `Space` | Application Launcher | Opens Rofi in `drun` mode (with icons) to launch installed applications. |
| `SUPER` + `Tab` | Window Switcher | Opens Rofi in `window` mode to switch between currently open windows. |
| `SUPER` + `Escape` | Power Menu | Opens the custom Wlogout menu (lock, hibernate, logout, shutdown, suspend, reboot). |
| `SUPER` + `V` | Clipboard History | Opens the Cliphist clipboard manager via Rofi. Select an item to copy it back to your clipboard. |
| `SUPER` + `W` | Cycle Wallpaper | Immediately kills the current wallpaper timer and forces the daemon to pick a new wallpaper and color scheme. |

## 🪟 Window Management
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `Q` | Kill Window | Forcibly closes the currently active window. |
| `SUPER` + `N` | Minimize Window | Hides the currently active window into the "minimized" special workspace. |
| `SUPER` + `Shift` + `N` | Restore Window | Toggles the "minimized" special workspace to let you retrieve hidden windows. |
| `SUPER` + `Shift` + `Space` | Toggle Floating | Toggles the active window between floating and tiling mode. |
| `SUPER` + `F` | Fullscreen (True) | Maximizes the window to take up the entire screen (hides Waybar). |
| `SUPER` + `Shift` + `F` | Maximize (Soft) | Maximizes the window within the tiling bounds (keeps Waybar visible). |
| `SUPER` + `J` | Toggle Split | Toggles the layout split direction for the current window. |
| `SUPER` + `P` | Pseudo-tiling | Toggles pseudo-tiling mode for the active window. |
| `ALT` + `Tab` | Cycle Next | Switches focus to the next window (standard Alt-Tab behavior). |

## 🎯 Navigation & Movement
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `Left/Right/Up/Down` | Move Focus | Shifts your focus to the window in the specified direction. |
| `SUPER` + `Shift` + `Left/Right/Up/Down` | Move Window | Physically moves the active window within the tiling layout in the specified direction. |

## 🖥️ Workspaces
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `[1-0]` | Switch Workspace | Switches your view to the specified workspace (1 through 10). |
| `SUPER` + `Shift` + `[1-0]` | Move to Workspace | Moves the currently active window to the specified workspace. |

## 📸 Screenshots
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `Print Screen` | Full Screen Screenshot | Captures the entire screen and opens it in Swappy for editing/saving. |
| `SUPER` + `Print Screen` | Region Screenshot | Freezes the screen and lets you draw a rectangle to capture a specific region, then opens it in Swappy. |

## 🔊 Hardware Controls & Media
*These bindings utilize the `swayosd` overlay daemon to provide visual feedback for hardware keys.*

| Keybind | Action | Description |
| :--- | :--- | :--- |
| `Volume Up` | Raise Volume | Increases speaker volume and displays an overlay. |
| `Volume Down` | Lower Volume | Decreases speaker volume and displays an overlay. |
| `Mute` | Toggle Speaker Mute | Mutes/unmutes the audio output and displays an overlay. |
| `Mic Mute` | Toggle Mic Mute | Mutes/unmutes the microphone input and displays an overlay. |
| `Brightness Up` | Raise Brightness | Increases the display brightness and displays an overlay. |
| `Brightness Down` | Lower Brightness | Decreases the display brightness and displays an overlay. |

## 🚪 System
| Keybind | Action | Description |
| :--- | :--- | :--- |
| `SUPER` + `M` | Exit Hyprland | Force quits the Hyprland session and returns to the SDDM login screen. |
