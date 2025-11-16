echo -e "Starting bootstrap process for Fedora"

sudo dnf update

sudo dnf install gnome-tweaks
sudo dnf install helix
sudo dnf install stow
sudo dnf install fastfetch
sudo dnf install onefetch
sudo dnf install zsh
sudo dnf install btop
sudo dnf install lazygit
# sudo dnf install lazydocker
sudo dnf install tmux

sudo dnf copr enable atim/starship
sudo dnf install starship

sudo dnf copr enable atim/lazygit
sudo dnf install lazygit

sudo dnf copr enable sneexy/zen-browser
sudo dnf instlal zen-browser

sudo dnf copr enable itexpert120/helium
sudo dnf --refresh install helium

# sudo dnf copr enable -y herzen/davinci-helper
# sudo dnf install -y davinci-helper

sudo dnf install fzf
sudo dnf install zoxide
sudo dnf install ripgrep
# sudo dnf install eza # should work but can't find https://eza.rocks/
sudo dnf install fd
# sudo dnf install rofi # not working
sudo dnf install ollama

sudo dnf install rustup
sudo dnf install go 
sudo dnf install gopls
sudo dnf install dlv # used for golang in helix
sudo dnf install goimports
sudo dnf install npm
sudo dnf install snapd

sudo dnf install godot
sudo dnf install blender
sudo dnf install obs-studio
# sudo dnf install anki # can't find

# flatpak packages
flatpak install flathub com.spotify.Client
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.zotero.Zotero

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# gnome settings
# disable window hover whenever mouse is on left side of screen - didn't work
gsettings set org.gnome.desktop.wm.preferences focus-mode click
