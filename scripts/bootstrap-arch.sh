echo -e "Starting bootstrap process for Arch"

pacman -S git
pacman -S github-cli
pacman -S helix
pacman -S less # needed for running "git log"
pacman -S stow # needed to create symlinks for dotfiles
pacman -S sudo
pacman -S zellij # tmux replacment
pacman -S zsh
