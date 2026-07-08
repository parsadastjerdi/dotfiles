#!/bin/bash

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

if ! command -v opencode &> /dev/null; then
    echo "Installing OpenCode..."
    /bin/bash -c "$(curl -fsSL https://opencode.ai/install | bash)"
else
    echo "OpenCode already installed"
fi

if ! command -v rustup &> /dev/null; then
    echo "Installing RustUp"
    /bin/bash -c "$(curl https://sh.rustup.rs -sSf -y | sh)"
else
    echo "RustUp already installed"
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
echo "Setting MacOS defaults"

# NOT stow-managed: `defaults` writes to live plist databases, not symlinked
# files. This script is invoked from setup-macos.sh and is idempotent — safe to
# re-run. Values are curated (not a raw `defaults export`) so they stay diffable
# and survive macOS upgrades.
[[ "$OSTYPE" == darwin* ]] || { echo "macos-defaults.sh: not macOS, skipping"; exit 0; }

set -euo pipefail
echo "Applying macOS defaults…"

# Close System Settings so it can't clobber changes on exit.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# Dock
defaults write com.apple.dock autohide -bool true          # auto-hide dock
defaults write com.apple.dock tilesize -int 64             # icon size
defaults write com.apple.dock orientation -string bottom   # dock position
defaults write com.apple.dock show-recents -bool false     # no recent apps
defaults write com.apple.dock launchanim -bool false       # no bounce on launch
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

# Finder
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv       # list view
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false     # no internal drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Global (NSGlobalDomain) — appearance, keyboard, input
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark          # dark mode
defaults write NSGlobalDomain _HIHideMenuBar -bool true                 # auto-hide menubar
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false      # key repeat over accent popup
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2                # full keyboard access
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false    # no screen flash on beep
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true  # force click enabled

# Trackpad — tap-to-click off (both driver + Bluetooth domains)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false

# Menubar clock — day of week + AM/PM, no date
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0

# Restart affected apps
for app in Dock Finder SystemUIServer ControlCenter; do
    killall "$app" 2>/dev/null || true
done

echo "macOS defaults applied. Some changes need a logout/restart."
echo "Bootstrap complete"
