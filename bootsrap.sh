#!/usr/bin/env sh

set -e

if [ -z "$_LOCAL_ENV_NAME" ]; then
	echo "codespace" | sh "./instructions.sh" | sh
	exit 0;
fi

echo "env \"$_LOCAL_ENV_NAME\" is already installed/configured"

