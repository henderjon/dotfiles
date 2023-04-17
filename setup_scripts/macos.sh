#!/bin/bash

set -e

if [[ "$OSTYPE" == darwin* ]]; then
	notice "# ------ macos dictionary"
	_cfg_ln "$DOTPATH/resources/macos/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"

	if [ ! -x "$(which brew)" ]; then
		notice "# ------ brew"
		sdo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	fi

	notice "# ------ brew bundle"
	sdo "brew bundle --file=$DOTPATH/resources/brew/Brewfile"

	notice "# ------ vscode"
	sdo "code --install-extension \"$DOTPATH/resources/vscode/monokai22-1.0.0.vsix\""
	_mv_file_rm_sym "$HOME/Library/Application Support/Code/User/settings.json"
	sdo "cp \"$DOTPATH/resources/vscode/vcs-settings.json\" \"$HOME/Library/Application Support/Code/User/settings.json\""
fi

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Quick look doesn't allow text selection by default, enable it!
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

killall Dock
killall Finder
