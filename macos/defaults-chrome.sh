#! /bin/bash

#======================================================================
# FILE: defaults-chrome.sh
#
# USAGE: ./defaults-chrome.sh
#        or defaults-chrome.sh
#
# DESCRIPTION: Sets Google Chrome 
#
# OPTIONS:
# AUTHOR: 
# CREATED: 01.03.2019
# BUGS: 
#======================================================================

# Disable swipe navigation
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true