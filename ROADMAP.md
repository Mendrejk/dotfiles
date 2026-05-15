# Headless Knowledge Base & Workspace Roadmap

## 1. Vault & Note Management (Silverbullet)
- [ ] Create `~/Vault` directory.
- [ ] Install [Silverbullet](https://silverbullet.md/) (a local, web-based Markdown note-taking app that directly edits `.md` files).
- [ ] Configure Silverbullet to run on `127.0.0.1` and bind it to `~/Vault`.
- [ ] Add Silverbullet to the `share-me-tmux` daemon.
- [ ] Add a `notes.mandrake.me` Cloudflare Tunnel route pointing to the Silverbullet port.

## 2. Remote Editor Support (Zed over SSH)
- [ ] Verify `sshd` is running and properly secured on the host.
- [ ] Add an `ssh.mandrake.me` Cloudflare Tunnel route pointing to `tcp://localhost:22`.
- [ ] Document the local `cloudflared access tcp` configuration required on the client machine to connect Zed remotely.

## 3. RAG Engine & Embedding Models (Ollama)
- [ ] Install `ollama`.
- [ ] Pull a lightweight embedding model (e.g., `nomic-embed-text` or `all-minilm`).
- [ ] Configure `ollama` with a `keep_alive = "5m"` flag/environment variable to ensure 0% GPU/RAM waste while idle.
- [ ] Install the local RAG CLI engine (e.g., `mcp-local-rag`).
- [ ] Perform the initial semantic indexing of `~/Vault`.

## 4. AI Agent Integration (Hermes & Pi)
- [ ] Set up the `hermes` agent framework.
- [ ] Connect the RAG CLI as an MCP Tool/Skill to both `pi` and `hermes`.
- [ ] Test the integration by asking the agents contextual questions about the Vault.

## 5. Storage & Backup Strategy
- [ ] Configure an automated backup script targeting the 1TB HDD (`/mnt/ai_data`), restricting the backup footprint to roughly 50% of the drive (~500GB).
- [ ] Use `borg` (highly recommended for deduplication) or `rsync` to create versioned snapshots of `~/Vault` and `~/.config`.
- [ ] Implement an auto-rotation retention policy (e.g., keep 7 daily, 4 weekly, and 6 monthly backups) to automatically prune old archives and prevent filling the disk.
- [ ] Set strict permissions on `/mnt/ai_data` to ensure backups cannot be accidentally overwritten or deleted by user error or AI agent automation.

---

### Containerization Strategy Note
*Decision: No heavy containerization (Docker/Podman).*
Since the *entire* physical machine is essentially a dedicated, single-tenant appliance running Arch Minimal exclusively for this AI workflow, introducing Docker adds unnecessary overhead, networking complexity (especially with Cloudflare Tunnels and `ttyd`), and eats up precious RAM/VRAM on a constrained GTX 1050 / i7 system. We will continue managing services directly via `tmux` and `systemd` user units.