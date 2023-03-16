#!/bin/bash

set -e

if [[ "$OSTYPE" == darwin* ]]; then
	notice "# ------ macos dictionary"
	_cfg_ln "$DOTPATH/assets/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"

	if [ ! -x "$(which brew)" ]; then
		notice "# ------ brew"
		sto "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	fi

	notice "# ------ brew bundle"
	sto "brew bundle --file=$DOTPATH/assets/Brewfile"

	notice "# ------ vscode"
	sto "code --install-extension \"$DOTPATH/assets/monokai22-1.0.0.vsix\""
	_mv_file_rm_sym "$HOME/Library/Application Support/Code/User/settings.json"
	sto "cp \"$DOTPATH/assets/vcs-settings.json\" \"$HOME/Library/Application Support/Code/User/settings.json\""
fi
