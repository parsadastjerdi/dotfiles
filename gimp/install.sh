#! /bin/ bash

#======================================================================
# FILE: install.sh
#
# USAGE: ./install.sh
#        or install.sh
#
# DESCRIPTION: Installs Gimp on the local system
#
# OPTIONS:
# AUTHOR: Parsa Dastjerdi
# CREATED: 01.02.2019
# BUGS: 
#======================================================================

# Abort on error
set -e

echo "Checking if Homebrew cask is already installed.";

# Check if Homebrew cask is installed on the system (used to install Gimp)
if test !$(which cask);then
    echo "Homebrew cask was not found on the system it is required in order to install Gimp via command line.";
    echo "Install Homebrew cask? (y/n)";
    read INSTALL_CASK;
    if ["$INSTALL_CASK" = "y"]; then 
        brew tap caskroom/cask
    else if ["$INSTALL_CASK" = "n"]; then
        echo "Homebrew cask was not installed on the system. Did not install Gimp.";
        exit 0
    else 
        echo "Reply not recognized, Gimp not installed";
        exit 1
    fi
fi

echo "Checking if Gimp is installed ..."; echo;

# Check if Gimp is installed on the system and install
if test !$(which gimp); then
   echo "Gimp not found. Installing Homebrew ..."; echo;
   brew cask install gimp
else
   echo "Gimp already installed."; echo;
fi

exit 0