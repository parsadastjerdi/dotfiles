echo -e "Starting bootstrap process for Fedora"

sudo dnf update

sudo dnf install helix
sudo dnf install stow
sudo dnf install fastfetch
sudo dnf install zsh
sudo dnf install btop
sudo dnf install lazygit
sudo dnf install lazydocker
sudo dnf install tmux

sudo dnf install rustup
sudo dnf install go
sudo dnf install npm

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
