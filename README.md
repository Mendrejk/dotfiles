# Arch Linux AwesomeWM Setup (Gruvbox Hyper-V VM)

Arch Linux configuration optimized for a Hyper-V Virtual Machine, using AwesomeWM (Policromia theme) and a Gruvbox Material Dark palette.

## Core Architecture
* **Window Manager:** AwesomeWM
* **Compositor:** Picom
* **Terminal:** Kitty
* **Shell:** Fish

## Components & Modifications

### Compositor (Picom)
Uses the `xrender` backend to prevent VM lag. Heavy blur (`dual_kawase`) is disabled.
* **Modifications:** Disabled shadows, fading, and blur. `corner-radius = 0` set to prevent black artifacts around native application rounding.
* **Config:** `~/.config/picom/picom.conf`

### Launcher (Ulauncher)
Replaces Rofi for a Spotlight-style interface.
* **Theme:** Gruvbox Material Dark Hard
* **Integration:** Replaced Rofi execution with `ulauncher-toggle` in AwesomeWM keybindings (`Super + e`). Appended to `autorun.sh` for background startup.
* **Config:** `~/.config/ulauncher/`

### Appearance
* **Icons:** Papirus (with `xelser/gruvbox-papirus-folders`)
* **Cursor:** Bibata-Modern-Amber (Configured via `~/.Xresources` for core X11 and `lxappearance` for GTK)
* **Wallpaper:** Nitrogen

### Core Packages
* **CLI Utilities:** `zoxide`, `fzf`, `fd`, `eza`, `fastfetch`
* **Audio:** `spotify_player` (Colour palettes configured in `theme.toml`)
* **Editors:** `helix`, `nvim`, `zed`
* **Browser:** Zen Browser

## Tracked Dotfiles (Chezmoi)
Add the following paths to Chezmoi to capture the system state:
* `~/.config/awesome/`
* `~/.config/picom/`
* `~/.config/ulauncher/`
* `~/.config/fish/`
* `~/.config/spotify-player/`
* `~/.config/kitty/`
* `~/.Xresources`
