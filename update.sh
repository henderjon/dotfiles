#!/usr/bin/env sh

DOTPATH=$(pwd)
echo "rm \"$DOTPATH/resources/vcs-settings.json\""
echo "cp \"$HOME/Library/Application Support/Code/User/settings.json\" \"$DOTPATH/resources/vcs-settings.json\""

echo "rm \"$DOTPATH/resources/Brewfile\""
echo "brew bundle dump --file=\"$DOTPATH/resources/Brewfile\""
