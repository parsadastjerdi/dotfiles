#!/bin/bash

# default target is $HOME
stow bash --target=$HOME
stow helix --target="$HOME/.config/helix"
stow idea --target=$HOME
stow stow --target=$HOME
stow tmux --target=$HOME
stow vim --target=$HOME
# stow zsh/.zshrc --target=$HOME
# stow zsh/.zshenv --target=$HOME
stow zsh --target=$HOME
