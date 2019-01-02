#!/usr/bin/env bash

# This script is a modified version of homebrew.sh from Aditya Pillai. github @ adityarpillai 
# Credit: https://gist.github.com/codeinthehole/26b37efa67041e1307db

# Abort on error
set -e

echo "Checking if Homebrew is installed ..."; echo;

if test !$(which brew); then
   echo "Homebrew not found. Installing Homebrew ..."; echo;
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
   echo "Homebrew already installed."; echo;
fi
