#! /bin/ bash

#======================================================================
# FILE: install.sh
#       Credit: homebrew.sh from (github @ adityarpillai)
#               https://gist.github.com/codeinthehole/26b37efa67041e1307db
#
# USAGE: ./install.sh
#        or install.sh
#
# DESCRIPTION: Installs Homebrew on the local system
#
# OPTIONS:
# AUTHOR: 
# CREATED: 01.02.2019
# BUGS: 
#======================================================================

# Abort on error
set -e

echo "Checking if Homebrew is installed ..."; echo;

if test !$(which brew); then
   echo "Homebrew not found. Installing Homebrew ..."; echo;
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
   echo "Homebrew already installed."; echo;
fi
