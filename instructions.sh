#!/bin/bash

# mercilessly copied from github.com/donatj/dotfiles

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

echo "please name me:"
read -r ENV_NAME
if [ -z "$ENV_NAME" ]; then
	echo "you forgot a name ... "
	exit 1
else
	echo "Hello, $ENV_NAME"
fi

DOTPATH=$(pwd)
# ------
notice "# ------ zsh"
echo "chsh -s /bin/zsh"
# ------
notice "# ------ gitconfig"
if [ -z "$CODESPACES" ]; then #codespaces doesn't like these GPG values
	echo "git config --global --replace-all include.path \"$DOTPATH/conf/git/gitconfig\" \"$DOTPATH/conf/git/gitgpg\""
else
	echo "git config --global --replace-all include.path \"$DOTPATH/conf/git/gitconfig\""
fi
notice "# !----- edit signing key and email in gitconfig & gitgpg"
echo "git config --global user.email \"...\""
echo "git config --global signingkey \"...\""
# ------
notice "# ------ rc files"
for RCFILE in "$DOTPATH"/rc/*
do
	F=$(basename "$RCFILE")
	_cfg_ln "$RCFILE" "$HOME/.$F"
done
# ------
notice "# ------ zshenv"
echo "touch \"$HOME/.zshenv\""
echo "echo 'export _LOCAL_ENV_NAME=$ENV_NAME' >> \"$HOME/.zshenv\""
# ------
notice "# ------ bin files"
_no_folder_create "$HOME/bin"
# ------
notice "# ------ ssh"
_no_folder_create "$HOME/.ssh"
echo "ssh-keygen -t ed25519 -C \"henderjon; $ENV_NAME; $(date '+%FT%T%z')\""
echo "curl -L \"https://github.com/henderjon.keys\" >> \"$HOME/.ssh/authorized_keys\""
# ------
if [[ "$OSTYPE" == darwin* ]]; then
	notice "# ------ macos dictionary"
	_cfg_ln "$DOTPATH/assets/LocalDictionary" "$HOME/Library/Spelling/LocalDictionary"

	if [ ! -x "$(which brew)" ]; then
		notice "# ------ brew"
		echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	fi
	notice "# ------ brew bundle"
	echo "brew bundle --file=$DOTPATH/assets/Brewfile"
	notice "# ------ vscode"
	echo "code --install-extension \"$DOTPATH/assets/monokai22-1.0.0.vsix\""
	_mv_file_rm_sym "$HOME/Library/Application Support/Code/User/settings.json"
	echo "cp \"$DOTPATH/assets/vcs-settings.json\" \"$HOME/Library/Application Support/Code/User/settings.json\""
fi
# ------
if [ -x "$(which php)" ]; then
	if [ ! -x "$(which composer)" ]; then
		notice "# ------ composer"
		echo "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=\"$HOME/bin/\""
		echo "mv \"$HOME/bin/composer.phar\" \"$HOME/bin/composer\""
	fi
else
	notice "# ------ php"
	notice "php is not installed, skipping composer"
fi

notice "# ------ cleanup; avoids clobbering on fetch/pull"
echo "git checkout -b \"$ENV_NAME\""

