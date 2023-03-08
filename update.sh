#!/usr/bin/env sh

DOTPATH=$(pwd)
VCS_SETTINGS_FILE="vcs-settings.json"
echo "rm \"$DOTPATH/resources/vscode/$VCS_SETTINGS_FILE\""
echo "cp \"$HOME/Library/Application Support/Code/User/settings.json\" \"$DOTPATH/resources/vscode/$VCS_SETTINGS_FILE\""

SUBL_COLOR_SETTINGS="Monokai22.sublime-color-scheme"
echo "rm \"$DOTPATH/resources/sublime_text/$SUBL_COLOR_SETTINGS\""
echo "cp \"$HOME/Library/Application Support/Sublime Text/Packages/User/$SUBL_COLOR_SETTINGS\" \"$DOTPATH/resources/sublime_text/$SUBL_COLOR_SETTINGS\""

SUBL_SETTINGS_FILE="Preferences.sublime-settings"
echo "rm \"$DOTPATH/resources/sublime_text/$SUBL_SETTINGS_FILE\""
echo "cp \"$HOME/Library/Application Support/Sublime Text/Packages/User/$SUBL_SETTINGS_FILE\" \"$DOTPATH/resources/sublime_text/$SUBL_SETTINGS_FILE\""

echo "rm \"$DOTPATH/resources/brew/Brewfile\""
echo "brew bundle dump --file=\"$DOTPATH/resources/brew/Brewfile\""


