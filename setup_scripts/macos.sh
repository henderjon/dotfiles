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
