#!/usr/bin/env sh

DOTPATH=$(pwd)
echo "rm \"$DOTPATH/assets/vcs-settings.json\""
echo "cp \"$HOME/Library/Application Support/Code/User/settings.json\" \"$DOTPATH/assets/vcs-settings.json\""

echo "rm \"$DOTPATH/assets/Brewfile\""
echo "brew bundle dump --file=\"$DOTPATH/assets/Brewfile\""
