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

## Setup Instructions

### 1. Install Core Dependencies
Ensure `git`, `chezmoi`, and `paru` (or another AUR helper) are installed.

### 2. Clone and Apply Dotfiles
```bash
chezmoi init git@github.com:Mendrejk/dotfiles.git
chezmoi apply
```

### 3. Install Packages
```bash
paru -S awesome picom ulauncher kitty fish zoxide fzf fd eza fastfetch spotify-player helix neovim zed-editor-bin zen-browser-bin nitrogen papirus-icon-theme bibata-cursor-theme-bin rigrep dbus-x11 avahi nss-mdns
```

### 4. Post-Install Configuration
* Download a wallpaper to `~/Pictures/` and apply it using `nitrogen ~/Pictures/`.
* Apply the Gruvbox folder theme to Papirus:
  ```bash
  git clone [https://github.com/xelser/gruvbox-papirus-folders](https://github.com/xelser/gruvbox-papirus-folders) /tmp/gruvbox-folders
  cd /tmp/gruvbox-folders
  sudo cp -r src/* /usr/share/icons/Papirus/
  ./papirus-folders -C gruvbox-material-yellow --theme Papirus-Dark
  ```
* Set the cursor to `Bibata-Modern-Amber` using `lxappearance`.

### 5. Hyper-V Enhanced Session (XRDP) Configuration
Switch XRDP to standard TCP network mode instead of `vsock` to allow GlazeWM to tile the window:
```bash
sudo sed -i 's/^port=vsock:\/\/-1:3389/port=3389/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/^use_vsock=true/use_vsock=false/g' /etc/xrdp/xrdp.ini
sudo systemctl restart xrdp

Enable mDNS to connect via archlinux.local instead of tracking dynamic IPs:
```bash
sudo systemctl enable --now avahi-daemon.service
```

Create a Windows RDP configuration file (`ArchVM.rdp`) with these specific flags to force resolution scaling and capture shortcuts:
```
full address:s:archlinux.local
smart sizing:i:1
keyboardhook:i:1
```

```
