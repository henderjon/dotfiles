#!/bin/bash

set -e

if [[ "$OSTYPE" == linux* ]]; then
	notice "# ------ vscode"
	notice "assuming this is cli, don't do anything with VSCode"
	# _mv_file_rm_sym "$HOME/.config/Code/User/settings.json"
	# sdo "cp \"$DOTPATH/resources/vscode/vcs-settings.json\" \"$HOME/.config/Code/User/settings.json\""
fi
