#!/bin/bash

# Update all existing dependencies
sudo apt-get update

# Setup log file - will get written to console at end of script
log_file=~/install_progress_log.txt

# Install tools
install_zsh()
install_curl()
install_git_completion()
install_tmux()
install_stow()
install_helix()
install_docker()
install_python()
install_rust()
install_golang()
install_dotnet()

# Give summary of what has been installed
echo -e "\n====== Summary ======\n"
cat $log_file
echo
rm $log_file

###########################################
# install methods for each tool below
###########################################

install_zsh() {
    if type -p zsh > /dev/null; then
        echo "SUCCESS: zsh installed" >> $log_file
    else
        echo "ERROR: zsh failed to install" >> $log_file
    fi

    sudo apt-get install zsh-syntax-highlighting
}

install_curl() {
    sudo apt-get -y install curl
    if type -p curl > /dev/null; then
        echo "SUCCESS: curl installed" >> $log_file
    else
        echo "ERROR: curl failed to install" >> $log_file
    fi
}

install_git_completion() {
    cd ~/
    curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
    mv ~/git-completion.bash ~/.git-completion.bash
    curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
    echo "git-completion and git-prompt installed and configured" >> $log_file
}

install_tmux() {
    sudo apt-get -y install tmux
    if type -p tmux > /dev/null; then
        echo "SUCCESS: tmux installed" >> $log_file
    else
        echo "ERROR: tmux failed to install" >> $log_file
    fi
}

install_stow() {
    sudo apt install stow
}

install_helix() {
    sudo add-apt-repository ppa:maveonair/helix-editor
    sudo apt install helix
}

install_docker() {
    // TODO: fill this out
}

install_python() {   
    sudo apt-get -y install python-pip
    if type -p pip > /dev/null; then
        echo "SUCCESS: pip installed" >> $log_file
    else
        echo "ERROR: pip failed to install" >> $log_file
    fi
    
    sudo apt-get -y install python
    if type -p python > /dev/null; then
        echo "SUCCESS: python installed" >> $log_file
    else
        echo "ERROR: python failed to install" >> $log_file
    fi

    sudo apt-get -y install python3
    if type -p python3 > /dev/null; then
        echo "SUCCESS: python3 installed" >> $log_file
    else
        echo "ERROR: python3 failed to install" >> $log_file
    fi
            
    sudo apt-get -y install python-dev
}

install_golang() {
    sudo apt install golang
    
    # add gopls LSP for Golang
    GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
    
    # go goimports for auto-imports in Helix
    GO111MODULE=on go get -v golang.org/x/tools/cmd/goimports@latest
}

# https://www.rust-lang.org/tools/install
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # add rust-analyzer LSP for Rust
    rustup component add rust-analyzer
}

# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#install-net
install_dotnet() {    
    # Register the Microsoft package repository
    declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)
    
    # Download Microsoft signing key and repository
    wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    
    # Install Microsoft signing key and repository
    sudo dpkg -i packages-microsoft-prod.deb
    
    # Clean up
    rm packages-microsoft-prod.deb
   
    # Install .NET
    sudo apt install dotnet-sdk-7.0
}

