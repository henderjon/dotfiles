#!/bin/bash

# mercilessly copied from github.com/donatj/dotfiles

set -e

notice () {
	NOTICE=$(printf "\033[01;36m%s\033[00;00m\n" "$1")
	sde "$NOTICE"
}

sde () {
	echo "$1" 1>&2;
}

sdo () {
	echo "$1"
}

_mv_file_rm_sym () {
	if [ -f "$1" ] || [ -d "$1" ]; then
		if [ ! -h "$1" ]; then
			sdo "mv \"$1\" \"$1.bkup.$(date '+%Y.%m.%dT%H.%M.%S')\""
		else
			sdo "rm \"$1\""
		fi
	fi
}

_no_folder_create() {
	if [ ! -d "$1" ]; then
		sdo "mkdir \"$1\""
	fi
}

_cfg_ln(){
	_mv_file_rm_sym "$2"
	sdo "ln -s \"$1\" \"$2\""
}


_confirm(){
	CONT=0
	read -r -p "$1 (y/n)? " CHOICE
	case "$CHOICE" in
	  y|Y ) CONT=1;;
	  n|N ) CONT=0;;
	  * ) CONT=0;;
	esac
	echo "$CONT";
}

# RESULT="$(confirm "really?")"
# if [ "$RESULT" -gt 0 ]; then
