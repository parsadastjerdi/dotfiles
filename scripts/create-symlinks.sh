#!/bin/bash

# default target is $HOME
stow bash --target=$HOME
stow helix --target="$HOME/.config/helix"
# stow idea --target=$HOME
stow starship --target="$HOME/.config"
stow stow --target=$HOME
stow tmux --target=$HOME
# stow nvim --target=$HOME
# stow zsh/.zshrc --target=$HOME
# stow zsh/.zshenv --target=$HOME
stow zed --target="$HOME/.config/zed"
stow zsh --target=$HOME
