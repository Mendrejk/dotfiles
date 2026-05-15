# Mandrake's Environment Context

You are operating on a minimal Arch Linux system that serves as a headless host for AI workflows and terminal workspaces.

## System Architecture
- **OS:** Arch Linux (Minimal, Headless)
- **User:** `mandrake` (Pseudonym, do not ask for or use real name)
- **Role:** AI Workflow & Workspace Host
- **Network & Access:** 
  - Exposed securely via Cloudflare Tunnels (`cloudflared`).
  - Base domain: `mandrake.me`
  - Subdomains route to specific services (e.g., `ide.mandrake.me` for Zellij/Helix workspace, `hub.mandrake.me` for Gateway).
  - Corporate WiFi autoconnect is disabled to prevent firewall blocking of outbound port 7844 (QUIC). The machine relies on a cellular hotspot.
  - Automatic restart on kernel panic is enabled via `sysctl`.

## Stack & Tooling
- **Core AI Agents:** `pi` (primary coding agent) and `hermes` (upcoming).
- **Workspace:** `tmux` daemon running in the background, managing the session `shared`.
- **Frontend:** `zellij` + `helix` + `yazi`, accessible via `ttyd` on the browser.
- **Service Management:** `systemd` user service (`workspace.service`) keeps the tmux session and all background apps alive across reboots.
- **Dotfiles:** Managed via `chezmoi` (repo located in `~/.local/share/chezmoi` on branch `headless`). Never switch to or use the `master` branch.

## Agent Guidelines
- The machine is headless. Do not suggest or run GUI applications (X11/Wayland).
- All web tools should be bound to `127.0.0.1` and exposed via Cloudflare Access (GitHub SSO). Avoid local basic auth.
- Prefer CLI-native tools (`yazi`, `helix`, `rg`, `fd`, `bat`). VS Code is strongly disliked.
- Maintain the "gruvbox-dark" theme consistency across all terminal applications.
- When generating configs, remember they will be managed by `chezmoi` and pushed to a public repository. Never hardcode secrets. Use `~/.secrets/`.
- **Package Management:** Always prioritize Arch Linux repositories. Use ONLY `paru` as the helper for all AUR and Arch package management operations. When a package is in the AUR, prefer compiling from source if it is fast, but use the `-bin` pre-compiled version if compilation would take a long time.
- **Sudo Access:** The `mandrake` user has passwordless `sudo` access. You can safely use `sudo` without worrying about interactive password prompts.