#!/bin/bash

set -e

notice () {
	printf "\033[01;36m%s\033[00;00m\n" "$1"
}

_mv_file_rm_sym () {
	if [ -f "$1" ] || [ -d "$1" ]; then
		if [ ! -h "$1" ]; then
			echo "mv \"$1\" \"$1.bkup.$(date +%s)\""
		else
			echo "rm \"$1\""
		fi
	fi
}

_no_folder_create() {
	if [ ! -d "$1" ]; then
		echo "mkdir \"$1\""
	fi
}

_cfg_ln(){
	_mv_file_rm_sym "$2"
	echo "ln -s \"$1\" \"$2\""
}


DOTPATH=$(pwd)
# ------
notice "# ------ zsh"
echo "chsh -s /bin/zsh"
# ------
notice "# ------ gitconfig"
echo "git config --global --replace-all include.path \"$DOTPATH/git/.gitconfig\""
# ------
notice "# ------ rc files"
for RCFILE in $(ls -1 ./rc)
do
	_cfg_ln "$DOTPATH/rc/$RCFILE" "$HOME/.$RCFILE"
done
# ------
notice "# ------ bin dir"
_no_folder_create "$HOME/bin"
# ------
notice "# ------ ssh"
_no_folder_create "$HOME/.ssh"
echo "ssh-keygen -t ed25519"
echo "curl -L \"https://github.com/henderjon.keys\" > \"$HOME/.ssh/authorized_keys\""
# ------
if [[ "$OSTYPE" == darwin* ]]; then
	notice "# ------ macos dictionary"
	_cfg_ln "$DOTPATH/assets/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"

	if [ -x "$(which brew)" ]; then
		notice "# ------ brew bundle"
		echo "brew bundle --file=$DOTPATH/assets/Brewfile"
	else
		notice "# ------ brew"
		echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	fi
fi
# ------
if [ -x "$(which php)" ]; then
	if [ -x "$(which composer)" ]; then
		notice "# ------ composer"
	else
		notice "# ------ composer"
		echo "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=\"$HOME/bin/\""
		echo "mv \"$HOME/bin/composer.phar\" \"$HOME/bin/composer\""
	fi
else
	notice "# ------ php"
	notice "php is not installed, skipping composer"
fi



