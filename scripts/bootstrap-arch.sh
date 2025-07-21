echo -e "Starting bootstrap process for Arch"

# update package database
pacman -Sy

pacman -S git
pacman -S github-cli
pacman -S helix
pacman -S less # needed for running "git log"
pacman -S stow # needed to create symlinks for dotfiles
pacman -S sudo
pacman -S zellij # tmux replacment
pacman -S bash
pacman -S zsh
pacman -S fastfetch
pacman -S btop
pacman -S lazygit
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# languages
# pacman -S rust
pacman -S rustup # using the official rust toolchain rather than arch's pre-compile rust package
pacman -S go
pacman -S npm

