#! /bin/bash

#======================================================================
# FILE: setup.sh
#
# USAGE: ./setup.sh
#        or setup.sh
#
# DESCRIPTION: Installs all applications depending on the operating system selected
#
# OPTIONS:
# AUTHOR: 
# CREATED: 01.02.2019
# BUGS: 
#======================================================================

echo "Select operating system: ";
echo "[1] macOS"; echo;
echo "[2] Arch Linux"; echo;

read SYSTEM;

cd ~

if [$SYSTEM = "1"]; then
    bash osx/install.sh
else if [$SYSTEM = "2"]; then
    bash arch/install.sh
else
    echo "Invalid operating system.";
fi
 
exit 0
