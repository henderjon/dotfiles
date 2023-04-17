#!/bin/bash

set -e

DOTPATH=$(pwd)

# don't run this file from it's own dir
if [[ "$DOTPATH" == *setup_scripts* ]]; then
	echo "run this file from dotfiles/; try cd .."
	exit 1
fi

# shellcheck source=functions.sh
. "$DOTPATH/setup_scripts/functions.sh"

sde "please name me:"
read -r ENV_NAME
if [ -z "$ENV_NAME" ]; then
	sdo "you forgot a name ... "
	exit 1
else
	sde "Hello, $ENV_NAME"
fi

# ------
notice "# ------ zsh"
sdo "chsh -s /bin/zsh"

# ------
notice "# ------ gitconfig"
sdo "git config --global --replace-all include.path \"$DOTPATH/conf/git/gitconfig\""

if [ -z "$CODESPACES" ]; then #codespaces doesn't like these GPG values
	sdo "git config --global --add include.path \"$DOTPATH/conf/git/gitgpg\""
fi

notice "# !----- edit signing key and email in gitconfig & gitgpg"
sde "git config --global user.email \"\""
sde "git config --global user.signingkey \"\""
sde "git config --global core.excludesfile = \"\""

# ------
notice "# ------ rc files"
for RCFILE in "$DOTPATH"/rc/*
do
	F=$(basename "$RCFILE")
	_cfg_ln "$RCFILE" "$HOME/.$F"
done

# ------
notice "# ------ zshenv"
sdo "touch \"$HOME/.zshenv\""
sdo "echo 'export _LOCAL_ENV_NAME=$ENV_NAME' >> \"$HOME/.zshenv\""

# ------
notice "# ------ bin files"
_no_folder_create "$HOME/bin"

# ------
notice "# ------ ssh"
_no_folder_create "$HOME/.ssh"
sdo "curl -L \"https://github.com/henderjon.keys\" >> \"$HOME/.ssh/authorized_keys\""

# ------
# shellcheck source=macos.sh
. "$DOTPATH/setup_scripts/macos.sh"

# ------
# shellcheck source=linux.sh
. "$DOTPATH/setup_scripts/linux.sh"

# ------
# shellcheck source=php.sh
. "$DOTPATH/setup_scripts/php.sh"

# ------
notice "# ------ cleanup; avoids clobbering on fetch/pull"
sdo "git checkout -b \"$ENV_NAME\""

# ------
notice "# ------ you might consider creating an ssh key pair"
sde "ssh-keygen -t ed25519 -C \"henderjon; $ENV_NAME; $(date '+%FT%T%z')\""

