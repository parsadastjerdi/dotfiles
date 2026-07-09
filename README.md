# Dotfiles

MacOS + Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start

```bash
# macOS — full setup
./setup-macos.sh

# Any platform — just symlink dotfiles
./scripts/stow-dotfiles.sh

# Linux — install packages then symlink
./scripts/bootstrap-ubuntu.sh   # or bootstrap-fedora.sh / bootstrap-arch.sh
```

## Packages

| Directory | Stows to | Config |
|-----------|----------|--------|
| `zsh/` | `$HOME` | `.zshrc`, `.zshenv` |
| `tmux/` | `$HOME` | `.tmux.conf` |
| `vim/` | `$HOME` | `.vimrc` |
| `git/` | `$HOME` | `.gitconfig` |
| `stow/` | `$HOME` | `.stowrc` |
| `helix/` | `~/.config/helix` | Editor config |
| `starship/` | `~/.config/starship` | Prompt config |
| `zed/` | `~/.config/zed` | Editor config |
| `ghostty/` | `~/.config/ghostty` | Terminal config |
| `opencode/` | `~/.config/opencode` | AI coding config + plugins |
| `1password/` | `$HOME` | Browser allowlist |
| `aerospace/` | `$HOME` | Window manager config |
| `vimium/` | `$HOME` | Browser keybinds |

## Editing a config

Edit the file in this repo, then re-stow:

```bash
cd "$(git rev-parse --show-toplevel)"
stow <package> --target="$HOME/.config/<name>"   # or $HOME
```

Or just run `./scripts/stow-dotfiles.sh` again — it's idempotent.

## macOS specifics

`setup-macos.sh` handles Homebrew, RustUp, OpenCode install, `brew bundle` (via `Brewfile`), opencode hook plugins, stow, and macOS system defaults.

## OpenCode / Supacode

`opencode/plugins/supacode.ts` reports terminal busy/idle state to Supacode via Unix socket. Environment variables (`SUPACODE_SOCKET_PATH`, etc.) are injected by Supacode automatically.
