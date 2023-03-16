#!/bin/bash

# mercilessly copied from github.com/donatj/dotfiles

set -e

notice () {
	NOTICE=$(printf "\033[01;36m%s\033[00;00m\n" "$1")
	ste "$NOTICE"
}

ste () {
	echo "$1" 1>&2;
}

sto () {
	echo "$1"
}

_mv_file_rm_sym () {
	if [ -f "$1" ] || [ -d "$1" ]; then
		if [ ! -h "$1" ]; then
			sto "mv \"$1\" \"$1.bkup.$(date +%s)\""
		else
			sto "rm \"$1\""
		fi
	fi
}

_no_folder_create() {
	if [ ! -d "$1" ]; then
		sto "mkdir \"$1\""
	fi
}

_cfg_ln(){
	_mv_file_rm_sym "$2"
	sto "ln -s \"$1\" \"$2\""
}
