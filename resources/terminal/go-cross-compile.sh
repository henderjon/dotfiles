

GOCROSSSOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "function go-"$1"-"$2 " {\n\tenv GOOS="$1" GOARCH="$2" go $@\n}\n" }')
eval "$GOCROSSSOURCE"

GOCROSSSOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "\tgo-"$1"-"$2" $@" }')
eval "function go-all {
	$GOCROSSSOURCE
}"

unset GOCROSSSOURCE
