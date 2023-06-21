#!/usr/bin/env sh

# `source`-ing this file will add a function that sets the GOOS & GOARCH for each available pairing for cross compiling Go
GOCROSSSOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "function go-"$1"-"$2 " {\n\tenv GOOS="$1" GOARCH="$2" go $@\n}\n" }')
eval "$GOCROSSSOURCE"

GOCROSSSOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "\tgo-"$1"-"$2" $@" }')
eval "function go-all {
	$GOCROSSSOURCE
}"

function go-cross {
	go tool dist list | awk 'BEGIN { FS = "/" }{ print("GOOS="$1" GOARCH="$2) }'
}

unset GOCROSSSOURCE
