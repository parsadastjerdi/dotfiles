echo -e "Starting bootstrap process for Arch"

pacman -S git
pacman -S github-cli
pacman -S helix
pacman -S less # needed for running "git log"
pacman -S stow # needed to create symlinks for dotfiles
pacman -S sudo
pacman -S zellij # tmux replacment
pacman -S zsh
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
pacman -S rust
