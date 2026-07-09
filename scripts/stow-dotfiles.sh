#!/bin/bash
# Stow all dotfiles packages.
# Idempotent — safe to re-run.
# Run from repo root.

set -euo pipefail

cd "$(dirname "$0")/.."

echo "Stowing dotfiles..."

mkdir -p "$HOME/.config/helix"
mkdir -p "$HOME/.config/starship"
mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/opencode"

stow zsh --target="$HOME"
stow tmux --target="$HOME"
stow vim --target="$HOME"
stow stow --target="$HOME"
stow git --target="$HOME"
stow helix --target="$HOME/.config/helix"
stow starship --target="$HOME/.config/starship"
stow zed --target="$HOME/.config/zed"
stow ghostty --target="$HOME/.config/ghostty"
stow opencode --target="$HOME/.config/opencode"

echo "Done."
