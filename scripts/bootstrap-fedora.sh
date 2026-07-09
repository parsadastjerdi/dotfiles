echo -e "Starting bootstrap process for Fedora"

sudo dnf update

# install nvidia drivers and enable CUDA support
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda

sudo dnf install gnome-tweaks
sudo dnf install helix
sudo dnf install stow
sudo dnf install fastfetch
sudo dnf install onefetch
sudo dnf install zsh
sudo dnf install btop
sudo dnf install lazygit
sudo dnf install tmux
sudo dnf install docker-cli

# lazydocker
sudo dnf copr enable atim/lazydocker
sudo dnf install lazydocker

# starship
sudo dnf copr enable atim/starship
sudo dnf install starship

# lazygit
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit

# zen
sudo dnf copr enable sneexy/zen-browser
sudo dnf instlal zen-browser

# helium - doesn't work
# sudo dnf copr enable itexpert120/helium
# sudo dnf --refresh install helium

# davinci resolve
sudo dnf copr enable -y herzen/davinci-helper
sudo dnf install -y davinci-helper

# librewolf
curl -fsSL https://repo.librewolf.net/librewolf.repo | pkexec tee /etc/yum.repos.d/librewolf.repo
sudo dnf install librewolf

# https://github.com/terrapkg/packages/tree/frawhide
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf install zed

# sudo dnf copr enable lihaohong/yazi
# sudo dnf install yazi

sudo dnf install fzf
sudo dnf install zoxide
sudo dnf install ripgrep
# sudo dnf install eza # should work but can't find https://eza.rocks/
sudo dnf install fd
# sudo dnf install rofi # not working
sudo dnf install ollama

# yazi
dnf copr enable lihaohong/yazi
dnf install yazi

# rust
sudo dnf install rust
sudo dnf install rust-src
sudo dnf install rustfmt
sudo dnf install rust-analyzer
sudo dnf install lldb
sudo dnf install cargo
sudo dnf install clippy

# golang
sudo dnf install go 
sudo dnf install gopls
sudo dnf install dlv # used for golang in helix
sudo dnf install goimports

# gleam
sudo dnf copr enable frostyx/gleam
sudo dnf install gleam

# elixir/
sudo dnf install elixir erlang
sudo dnf install elixir-doc erlang-doc

sudo dnf install npm
sudo dnf install snapd

# applications
sudo dnf install steam
sudo dnf install godot
sudo dnf install blender
sudo dnf install obs-studio
sudo dnf install gimp
# sudo dnf install anki # can't find

# flatpak packages
flatpak install flathub com.spotify.Client
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.zotero.Zotero

# didnt work on fedora 39
# curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.rpm.sh' | sudo -E bash
# sudo dnf install balena-etcher

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# gnome settings
# disable window hover whenever mouse is on left side of screen - didn't work
gsettings set org.gnome.desktop.wm.preferences focus-mode click

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# Activate dotfiles
"$(dirname "$0")/stow-dotfiles.sh"

echo -e "\nDone. Restart your shell to pick up changes."
