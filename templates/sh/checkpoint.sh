#!/usr/bin/env sh

set -e

_make_check(){
	git add --update . # -u/--update only updates files that are already commited
	git commit -m "WIP; √ adding a checkpoint"
	git status --untracked-files
}

_make_check
exit 0 # make sure the loops below don't run yet

# to run the loop for a given amount of time

# end=$((SECONDS+3))
# while [ $SECONDS -lt $end ]; do
#     _make_check
# done

# to run a loop for ever but with a pause

# while true; do
#     _make_check
# 	sleep 3m
# done
