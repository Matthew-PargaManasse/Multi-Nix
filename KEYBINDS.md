# System Keyboard Shortcuts & Aliases

This file contains a reference list of all configured keyboard shortcuts, keybinds, and aliases across the system. 
As you update your `.nix` configuration files, remember to update this document to keep it current.

---

## 🪟 Hyprland (Window Manager)

**Modifier Key (`$mainMod`) = SUPER / Windows Key**

### Core System
| Shortcut | Action |
|---|---|
| `SUPER` + `Return` | Open Kitty (Terminal) |
| `SUPER` + `Q` | Kill active window |
| `SUPER` + `M` | Exit Hyprland |
| `SUPER` + `E` | Open Yazi (File Manager) in Kitty |
| `SUPER` + `Space` | Open Walker (App Launcher) |
| `SUPER` + `Tab` | Open Rofi (Window Switcher) |
| `SUPER` + `Escape` | Open Wlogout (Power Menu) |
| `SUPER` + `V` | Open Cliphist (Clipboard Manager via Rofi) |
| `Print Screen` | Take Screenshot (Grim + Slurp) and open in Swappy |

### Window Management
| Shortcut | Action |
|---|---|
| `SUPER` + `Shift` + `Space` | Toggle floating mode for active window |
| `SUPER` + `P` | Toggle Pseudo-tiling |
| `SUPER` + `J` | Toggle window split layout |
| `SUPER` + `Left/Right/Up/Down` | Move focus between windows |
| `SUPER` + `Left Click (Hold)` | Move floating window |
| `SUPER` + `Right Click (Hold)`| Resize floating window |

### Workspaces
| Shortcut | Action |
|---|---|
| `SUPER` + `1-0` | Switch to workspace 1-10 |
| `SUPER` + `Shift` + `1-0` | Move active window to workspace 1-10 |

### Media & Hardware Controls
| Shortcut | Action |
|---|---|
| `Volume Up/Down` | Raise/Lower volume by 5% |
| `Mute` | Toggle Audio Mute |
| `Brightness Up/Down`| Raise/Lower screen brightness by 5% |

---

## ⚡ Wlogout (Power Menu)

When Wlogout is open (via `SUPER` + `Escape`), use these keys:

| Key | Action |
|---|---|
| `l` | Lock Screen (Hyprlock) |
| `h` | Hibernate |
| `e` | Logout |
| `s` | Shutdown |
| `u` | Suspend |
| `r` | Reboot |

---

## 📝 Neovim (nixvim)

**Leader Key (`<leader>`) = Space**

### Normal Mode
| Shortcut | Action |
|---|---|
| `ESC` | Clear search highlighting |
| `Y` | Yank to end of line (behaves like `D` or `C`) |
| `Ctrl` + `c` | Toggle between two most recent files |
| `Ctrl` + `x` | Close current window |
| `Space` + `s` OR `Ctrl` + `s` | Save file (`:w`) |
| `Space` + `h/l` | Navigate to left/right split window |
| `H` | Jump to start of line |
| `L` | Jump to end of line |
| `Ctrl` + `Up/Down` | Resize horizontal split |
| `Ctrl` + `Left/Right`| Resize vertical split |
| `Alt` + `j/k` | Move current line up/down |

### Visual Mode
| Shortcut | Action |
|---|---|
| `>` or `TAB` | Indent block and keep selection |
| `<` or `Shift+TAB` | Un-indent block and keep selection |
| `J` | Move selected block down one line |
| `K` | Move selected block up one line |
| `Space` + `s` | Sort selected lines |

---

## 🐚 Zsh & Terminal Aliases

These are the custom commands available in your terminal:

| Alias / Command | Action | Note |
|---|---|---|
| `ls` | `eza --icons` | Modern `ls` replacement with icons |
| `ll` | `eza -1la` | Detailed list view |
| `cat` | `bat` | Modern `cat` replacement with syntax highlighting |
| `cd` | `z` (zoxide) | Smart directory jumper |
| `update` | `sudo nix flake update && sudo nixos-rebuild switch --flake ./#nixos` | System updater alias |
| `v` | `nvim` | Quick launch Neovim |
