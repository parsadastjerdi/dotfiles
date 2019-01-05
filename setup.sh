#! bin/bash

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
echo "[1] macOS";
echo "[2] Arch Linux";
echo "[3] osx";

read SYSTEM;

echo $SYSTEM

# Run scripts from root directory
# cd ~

if [ $SYSTEM -eq 1 ] then
    echo "macOS";
    # ./macos/install.sh
elif [ $SYSTEM -eq 2 ] then
    ./arch/install.sh
elif [ $SYSTEM -eq 3 ] then
    ./osx/install.sh
else
    echo "Invalid operating system.";
    exit 1
fi

echo "If statement doesn't work";