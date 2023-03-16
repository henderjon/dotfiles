#!/bin/bash

set -e

if [ -x "$(which php)" ]; then
	if [ ! -x "$(which composer)" ]; then
		notice "# ------ composer"
		sto "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=\"$HOME/bin/\""
		sto "mv \"$HOME/bin/composer.phar\" \"$HOME/bin/composer\""
	fi
else
	notice "# ------ php"
	notice "php is not installed, skipping composer"
fi
