#!/bin/bash

set -e

warn () {
	printf "\033[01;31m - %s\033[00;00m\n" "$1"
}

_mv_file_rm_sym () {
	if [ -f "$1" ] || [ -d "$1" ]; then
		if [ ! -h "$1" ]; then
			echo "mv \"$1\" \"$1.bkup.$(date +\"%s\")\""
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
echo "chsh -s /bin/zsh"
# ------
echo "git config --global --replace-all include.path \"$DOTPATH/git/.gitconfig\""
# ------
for i in $(ls -1 ./rc)
do
	_cfg_ln "$DOTPATH/rc/$RCFILE" "$HOME/.$RCFILE"
done
# ------
_no_folder_create "$HOME/bin"
# ------
_no_folder_create "$HOME/.ssh"
echo "ssh-keygen -t ed25519"
echo "curl -L \"https://github.com/henderjon.keys\" > \"$HOME/.ssh/authorized_keys\""
# ------
if [[ "$OSTYPE" == darwin* ]]; then
	_cfg_ln "$DOTPATH/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"

	if [ -x "$(which brew)" ]; then
		echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
		echo "brew bundle --file=$DOTPATH/assets/Brewfile"
	else
		warn "brew is not installed"
	fi
fi
# ------
if [ -x "$(which php)" ]; then
	echo "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin/"
	echo "ln -s \"$(which composer.phar)\" \"$HOME/bin/composer\""
else
	warn "php is not installed, skipping composer"
fi



