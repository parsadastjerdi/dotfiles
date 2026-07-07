#!/bin/bash

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

brew update
brew upgrade
brew bundle install

echo "Symlinking dotfiles..."
cd "$(dirname "$0")"

stow zsh --target=$HOME 2>/dev/null
stow tmux --target=$HOME 2>/dev/null
stow vim --target=$HOME 2>/dev/null
stow stow --target=$HOME 2>/dev/null
stow git --target=$HOME 2>/dev/null

mkdir -p ~/.config/helix && stow helix --target=$HOME/.config/helix 2>/dev/null
mkdir -p ~/.config/starship && stow starship --target=$HOME/.config/starship 2>/dev/null
mkdir -p ~/.config/zed && stow zed --target=$HOME/.config/zed 2>/dev/null
mkdir -p ~/.config/ghostty && stow ghostty --target=$HOME/.config/zed 2>/dev/null

echo "Dotfiles symlinked"
echo "Bootstrap complete"
