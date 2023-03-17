#!/bin/bash

set -e

if [ -x "$(which php)" ]; then
	if [ ! -x "$(which composer)" ]; then
		notice "# ------ composer"
		sdo "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=\"$HOME/bin/\""
		sdo "mv \"$HOME/bin/composer.phar\" \"$HOME/bin/composer\""
	fi
else
	notice "# ------ php"
	notice "php is not installed, skipping composer"
fi
