#! /bin/bash

# Installs all applications depending on the operating system selected

echo "Select operating system: ";
echo "[1] macOS"; echo;
echo "[2] Arch Linux"; echo;

read SYSTEM;

if [$SYSTEM = "1"]; then
    bash osx/install.sh
else if [$SYSTEM = "2"]; then
    bash arch/install.sh
else
    echo "Invalid operating system.";
fi
 
exit 0
