# Dotfiles

MacOS dotfiles managed with GNU Stow.

## Structure

Each directory under this repo is a stow package:
- `zsh/` — `.zshrc` (stowed to `$HOME`)
- `tmux/`, `vim/`, `git/`, `stow/` — stowed to `$HOME`
- `helix/`, `starship/`, `zed/`, `ghostty/`, `opencode/` — stowed to `~/.config/<name>`
- `1password/`, `aerospace/`, `vimium/` — stowed to `$HOME`

## Setup

Run `setup-macos.sh` to:
1. Install Homebrew, OpenCode, RustUp
2. `brew bundle install` (deps defined in Brewfile)
3. Install opencode hook plugins
4. Stow all dotfiles
5. Apply macOS defaults

Brewfile manages formulae and casks (node, helix, starship, ghostty, zed, supacode, etc.).

## OpenCode / Supacode Integration

- `opencode/plugins/supacode.ts` — plugin that reports busy/idle state to Supacode via Unix socket
- Installed via stow to `~/.config/opencode/`
- Dependencies in `opencode/package.json`, install via `npm --prefix ~/.config/opencode install`
- Works automatically when opencode runs inside a Supacode-managed terminal
- Environment variables injected by Supacode: `SUPACODE_SOCKET_PATH`, `SUPACODE_WORKTREE_ID`, `SUPACODE_TAB_ID`, `SUPACODE_SURFACE_ID`

## OpenCode Hook Plugins

- `opencode-yaml-hooks` — define hooks via `hooks.yaml` for session/file/tool lifecycle events
- `opencode-command-hooks` — run shell commands after tool calls, inject output into context
- Config: `~/.config/opencode/hook/hooks.yaml`

## Editing Configs

Most tools read their config from `~/.config/<name>/`. Edit files in this repo, then re-stow:
```bash
cd $(git rev-parse --show-toplevel)
stow <package> --target=$HOME/.config/<name>  # or $HOME
```
