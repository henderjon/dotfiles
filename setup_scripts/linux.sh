#!/bin/bash

set -e

if [[ "$OSTYPE" == linux* ]]; then
	notice "# ------ vscode"
	sto "code --install-extension \"$DOTPATH/assets/monokai22-1.0.0.vsix\""
	_mv_file_rm_sym "$HOME/.config/Code/User/settings.json"
	sto "cp \"$DOTPATH/assets/vcs-settings.json\" \"$HOME/.config/Code/User/settings.json\""
fi
