# Multi-Nix Architecture Overview

This repository uses a modern, modular Nix Flake architecture. It is designed so that you can define multiple **Hosts** (computers/devices) and multiple **Users** (profiles/roles), and mix and match them as needed.

Here is a conceptual map of how your repository is structured and how the pieces fit together.

## 🌳 The File Tree

```text
Multi-Nix/
├── flake.nix                  <-- The Master Router (Connects Hosts to Users)
│
├── hosts/                     <-- DEVICE SPECIFIC CONFIGURATIONS (The Hardware Layer)
│   ├── laptop/
│   │   ├── default.nix        <-- Intel-only Laptop Host (open-source native drivers)
│   │   └── hardware-configuration.nix <-- Hardware profiles, LUKS UUIDs, filesystems
│   ├── laptop-nvidia/
│   │   ├── default.nix        <-- Hybrid Nvidia/AMD Laptop Host (proprietary drivers, prime)
│   │   └── hardware-configuration.nix 
│   ├── rpi4/
│   │   └── default.nix        <-- Raspberry Pi Host settings (minimal, no GUI)
│   └── macos/
│       └── default.nix        <-- MacBook/Darwin settings (nix-darwin)
│
├── modules/nixos/             <-- SYSTEM LEVEL CONFIGURATIONS (The OS Layer)
│   ├── base.nix               <-- Core system (Zsh, Tailscale, Network, Timezone)
│   └── desktop.nix            <-- GUI system (X11, SDDM, Hyprland System configs)
│
├── home/                      <-- USER LEVEL CONFIGURATIONS (The Application Layer)
│   ├── base.nix               <-- Shared apps for ALL users (Git, Neovim, Obsidian)
│   ├── mitch.nix              <-- User Profile: Penetration Testing & OSCP Tools
│   ├── mitch-daily.nix        <-- User Profile: Privacy & Daily Browsing (Brave, Proton)
│   ├── mitch-embedded.nix     <-- User Profile: Embedded Exploitation Tools
│   │
│   └── common/                <-- Reusable App Configurations (Dotfiles)
│       ├── hyprland.nix       <-- The ML4W bleeding-edge Hyprland/Waybar setup
│       ├── zsh.nix            <-- ZSH, Starship, Fastfetch, Yazi, Zoxide
│       ├── theme.nix          <-- GTK & Cursor themes
│       └── neovim/            <-- Modular Neovim setup
│
└── wallpapers/
    └── ml4w_tokyonight.png    <-- Drives Stylix system-wide colors
```

---

## 🧩 How It Fits Together (The Mental Model)

Think of the repository in **Three Layers**:

### 1. The Hardware Layer (`hosts/`)
This layer defines physical computers. 
- A Host file (like `hosts/laptop/default.nix`) only cares about "What computer am I?" 
- It sets the hostname and defines the hardware UUIDs. 
- It then "pulls in" the OS Layer it needs. For example, the Laptop pulls in `desktop.nix` (heavy GUI), while the Raspberry Pi only pulls in `base.nix` (minimal CLI).

### 2. The OS Layer (`modules/nixos/`)
This layer handles root-level Linux stuff (SystemD services, Display Managers, Bootloaders).
- `base.nix`: The foundation. It ensures the computer has networking, a terminal, and SSH.
- `desktop.nix`: The graphics stack. It adds SDDM, Hyprland, and Audio (Pipewire).

### 3. The User Layer (`home/`)
This is managed by `Home Manager`. It handles applications, dotfiles, and roles.
- Instead of one massive user, you have **Roles**. 
- `mitch.nix` is loaded with Kali/OSCP tools. 
- `mitch-daily.nix` is lightweight, focusing on web browsing and email.
- You can assign any User Role to any Host inside `flake.nix`!

---

## 🏗️ How to Continue Building

If you want to add something new, follow this logic:

**1. "I want to add a new hacking tool (e.g., Metasploit)."**
- Ask yourself: Does every user need this? No.
- *Action*: Add it to `home/mitch.nix` inside `home.packages`.

**2. "I bought a new Desktop PC and want to run NixOS on it."**
- *Action*: Generate the hardware config from the live USB. Create `hosts/desktop/default.nix`. Import `modules/nixos/desktop.nix`. Add it to `flake.nix`.

**3. "I want to change my ZSH prompt or add an alias."**
- Ask yourself: Is this a system service or a user config? It's a user config.
- *Action*: Edit `home/common/zsh.nix`. Because `home/base.nix` imports `common/zsh.nix`, ALL your users (`mitch`, `mitch-daily`, etc.) will automatically get the new alias!

**4. "I want to run a Docker daemon."**
- Ask yourself: Is Docker an application or a root-level system service? It's a system service.
- *Action*: If you want Docker on every machine, put `virtualisation.docker.enable = true;` in `modules/nixos/base.nix`. If you only want it on the laptop, put it in `hosts/laptop/default.nix`.
