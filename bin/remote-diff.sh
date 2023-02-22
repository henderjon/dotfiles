#!/usr/bin/env sh

set -e

SRCDIR=$1
DESTFILE=$2

if [[ -z "$DESTFILE" ]]
then
echo "missing destination filename\n"
exit 1
fi

TF1=$(mktemp)
printf "%s\n%s\n" "$TMPDIR" "$TF1"

find "$SRCDIR" -type f -exec sum {} \; | \
### assign $1 and $2 to new vars, then blank them so $0 outputs the blanks; this will still output delims which is where `sort` comes in
awk 'BEGIN{FS=" "}{ o=$1; t=$2; $1=$2=""; print $0,o,t; }' > "$TF1"

TF2=$(mktemp)
echo "$TF2\n"
cat "$TF1" | sort -k 3 > "$TF2"

mv "$TF2" "$DESTFILE"
rm -f "$TF1" "$TF2"

# grab path and checksum of all filesin current directory and down
# find . -type f -exec sum {} \; | \
# find . -type f -exec sum {} \; > $TF1
# move the output columns around to be able to sort by path
# awk 'BEGIN{FS=" "}{o=$1;t=$2;$1=$2=""; print $0,o,t;}' | \
# remove blank chars at beginning of the line; sort can also be told to ignore blanks with -b, --ignore-leading-blanks
# sort -k 3
# sed 's/^[[:blank:]]*//'
