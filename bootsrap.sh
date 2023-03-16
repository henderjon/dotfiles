#!/usr/bin/env sh

set -e

_THISDIR=$(pwd)

if [ -n "$CODESPACES" ]; then # if codespaces
	echo "codespace" | bash "$_THISDIR/setup_scripts/instructions.sh" | sh
	exit 0;
fi

if [ -z "$_LOCAL_ENV_NAME" ]; then
	bash "$_THISDIR/setup_scripts/instructions.sh"
	exit 0;
fi

echo "env \"$_LOCAL_ENV_NAME\" is already installed/configured"
