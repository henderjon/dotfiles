#!/usr/bin/env sh
set -e

cat << "EOF"
################################################# TERMINAL CODES (ANSI/VT100) ##

### https://wiki.bash-hackers.org/scripting/terminalcodes

esc   - "\u001b[" // "\033", byte(27)

ANSI		Description
[0m  - Reset all attributes
[1m  - Set "bright" attribute
[2m  - Set "dim" attribute
[3m  - Set "standout" attribute
[4m  - Set "underscore" (underlined text) attribute
[5m  - Set "blink" attribute
[7m  - Set "reverse" attribute
[8m  - Set "hidden" attribute
[30m - Set foreground to color #0 - black
[31m - Set foreground to color #1 - red
[32m - Set foreground to color #2 - green
[33m - Set foreground to color #3 - yellow
[34m - Set foreground to color #4 - blue
[35m - Set foreground to color #5 - magenta
[36m - Set foreground to color #6 - cyan
[37m - Set foreground to color #7 - white
[39m - Set default color as foreground color
[40m - Set background to color #0 - black
[41m - Set background to color #1 - red
[42m - Set background to color #2 - green
[43m - Set background to color #3 - yellow
[44m - Set background to color #4 - blue
[45m - Set background to color #5 - magenta
[46m - Set background to color #6 - cyan
[47m - Set background to color #7 - white
[49m - Set default color as background color

####################################################################### LINUX ##

% adduser --shell $PATH/zsh --group root,admin,wheel $USERNAME

# if the groups get messed up
% usermod -a -G $GROUP $USERNAME
% ed /etc/sudoers

# assuming digital ocean root user
% cp ~/.ssh/authorized_keys /home/$username/.ssh/authorized_keys
% chown $username /home/$username/.ssh/authorized_keys

############################################################## remote-diff.sh ##
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

################################################################### CLI REGEX ##

### https://stackoverflow.com/questions/399078/what-special-characters-must-be-escaped-in-regular-expressions

Which characters you must and which you mustn't escape indeed depends on the regex flavor you're working with.

For PCRE, and most other so-called Perl-compatible flavors, escape these outside character classes:

.^$*+?()[{\|

and these inside character classes:

^-]\

For POSIX extended regexes (ERE), escape these outside character classes (same as PCRE):

.^$*+?()[{\|

Escaping any other characters is an error with POSIX ERE.

Inside character classes, the backslash is a literal character in POSIX regular expressions. You cannot use it to escape anything. You have to use "clever placement" if you want to include character class metacharacters as literals. Put the ^ anywhere except at the start, the ] at the start, and the - at the start or the end of the character class to match these literally, e.g.:

[]^-]

In POSIX basic regular expressions (BRE), these are metacharacters that you need to escape to suppress their meaning:

.^$*[\

Escaping parentheses and curly brackets in BREs gives them the special meaning their unescaped versions have in EREs. Some implementations (e.g. GNU) also give special meaning to other characters when escaped, such as \? and +. Escaping a character other than .^$*(){} is normally an error with BREs.

Inside character classes, BREs follow the same rule as EREs.

### OTHER

Modern RegEx Flavors (PCRE)
Includes C, C++, Delphi, EditPad, Java, JavaScript, Perl, PHP (preg), PostgreSQL, PowerGREP, PowerShell, Python, REALbasic, Real Studio, Ruby, TCL, VB.Net, VBScript, wxWidgets, XML Schema, Xojo, XRegExp.
PCRE compatibility may vary

- Anywhere: . ^ $ * + - ? ( ) [ ] { } \ |

Legacy RegEx Flavors (BRE/ERE)
Includes awk, ed, egrep, emacs, GNUlib, grep, PHP (ereg), MySQL, Oracle, R, sed.
PCRE support may be enabled in later versions or by using extensions

ERE/awk/egrep/emacs

- Outside a character class: . ^ $ * + ? ( ) [ { } \ |
- Inside a character class: ^ - [ ]

BRE/ed/grep/sed

- Outside a character class: . ^ $ * [ \
- Inside a character class: ^ - [ ]
- For literals, don't escape: + ? ( ) { } |
- For standard regex behavior, escape: \+ \? \( \) \{ \} \|

######################################################################### SCP ##

# for strange errors force legacy mode with "-O"

###################################################################### DATE.C ##

%a      Abbreviated weekday name
%A      Full weekday name
%b      Abbreviated month name
%B      Full month name
%c      Date and time representation appropriate for locale
%d      Day of month as decimal number (01 - 31)
%H      Hour in 24-hour format (00 - 23)
%I      Hour in 12-hour format (01 - 12)
%j      Day of year as decimal number (001 - 366)
%m      Month as decimal number (01 - 12)
%M      Minute as decimal number (00 - 59)
%p      Current locale's A.M./P.M. indicator for 12-hour clock
%S      Second as decimal number (00 - 59)
%U      Week of year as decimal number, with Sunday as first day of week (00 - 53)
%w      Weekday as decimal number (0 - 6; Sunday is 0)
%W      Week of year as decimal number, with Monday as first day of week (00 - 53)
%x      Date representation for current locale
%X      Time representation for current locale
%y      Year without century, as decimal number (00 - 99)
%Y      Year with century, as decimal number
%z, %Z  Either the time-zone name or time zone abbreviation, depending on registry settings
%%      Percent sign

######################################################################## CRON ##

# Numeric values can be comma seperated for step values (e.g. "0,30 6,18 2,20 3,4 * command-to-run.sh" )

# intervals are expressed as */X where X is a number

# * * * * * command to be executed
# ⎢ ⎜ │ │ │
# ⎢ ⎜ │ │ ╰───── day of week (0 - 6) (Sunday=0)
# │ │ │ ╰─────── month (1 - 12)
# │ │ ╰───────── day of month (1 - 31)
# │ ╰─────────── hour (0 - 23)
# ╰───────────── min (0 - 59)

################################################################## FILE PERMS ##

# http://permissions-calculator.org/

#     [4 2 1][4 2 1][4 2 1]
# d s  r w x  r w x  r w x
# │ │  │ │ │  │ │ │  │ │ │
# │ │  │ │ │  │ │ │  │ │ ╰─ other (o) execute
# │ │  │ │ │  │ │ │  │ ╰─── other (o) write
# │ │  │ │ │  │ │ │  ╰───── other (o) read
# │ │  │ │ │  │ │ ╰──────── group (g) execute
# │ │  │ │ │  │ ╰────────── group (g) write
# │ │  │ │ │  ╰──────────── group (g) read
# │ │  │ │ ╰─────────────── user  (u) execute
# │ │  │ ╰───────────────── user  (u) write
# │ │  ╰─────────────────── user  (u) read
# │ ╰────────────────────── special bit**
# ╰──────────────────────── type

# 0766 - go+rw,u+rwx
# 0755 - go+rx,u+rwx

# **special bit
# setuid = 4 (u+s, run as user; s in `ls`)
# setgid = 2 (g+s, run as group; S in `ls`)
# Sticky bit = 1 (+t)

# In octal the special bit is "4" or "s" and will be capital "S" if lacking executable permissions

# symbolic:
# chmod [who][add/remove][perm][,[who][add/remove][perm]]
# - [who] = u/g/o/a
# - [add/remove] = +/-
# - [perm] = r/w/x/s

# octal:
# chmod [special][user][group][other/world]
# - [special] = 4/0
# - [user] = 1/2/3/4/5/6/7/0
# - [group] = 1/2/3/4/5/6/7/0
# - [other/world] = 1/2/3/4/5/6/7/0

################################################################# SSH / PERMS ##

% ssh-keygen -t ed25519 -C "your_email@example.com"

# 700 (drwx------) - .ssh directory
# 644 (-rw-r--r--) - public keys (.pub file)
# 644 (-rw-r--r--) - known_hosts
# 600 (-rw-------) - private keys (id_rsa)
# 600 (-rw-------) - authorized_keys
# 600 (-rw-------) - config

# 644 (-rw-r--r--) - normal files
# 755 (drwxr-xr-x) - normal dirs

# $HOME should not be writeable by the group or others (at most 755 (drwxr-xr-x)).

###################################################################### PYTHON ##

s = u'is a unicode string'
s = b'is a bytes string'
s = f'string {var}' # interpolates vars
s = r'no need to escape the \ char'
s = 'fpri%t' % 'n'
s = 'this uses {0}'.format('indicies')
s = 'this uses {v}'.format(v='indicies')

# TYPES
# Text Type:      str
# Numeric Types:  int, float, complex
# Sequence Types: list, tuple, range
# Mapping Type:   dict
# Set Types:      set, frozenset
# Boolean Type:   bool (True, False)
# Binary Types:   bytes, bytearray, memoryview
# None Type:      NoneType (None)

# import sys // print(sys.argv)
# import json
# import requests # https://docs.python-requests.org/en/latest/user/quickstart/#more-complicated-post-requests
# import os
# import argparse

# iteration returns INDEXES
# for dictionaries use .keys(), .values(), .items()


################################################################# GITHUB / GH ##

### https://cli.github.com/
### https://docs.github.com/en/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax
### https://docs.github.com/en/search-github/getting-started-with-searching-on-github/about-searching-on-github
### https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests
### https://docs.github.com/en/issues/tracking-your-work-with-issues/filtering-and-searching-issues-and-pull-requests

### NEED MY REVIEW
% gh pr status
% gh pr -R $REPO list -S "is:pr is:open user-review-requested:@me "
% gh pr -R $REPO list -S "is:pr is:open -reviewed-by:@me "

### interact with PRs
% gh label list
% gh pr edit $N --add-label "label"
% gh pr edit $N --add-assignee $name
% gh pr comment $N -b "comment"
% gh pr diff $N
% gh pr review $N -a -b ":8ball:"

### https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#ssh-commit-signature-verification

GitHub will automatically use GPG to sign commits you make using the web interface. Commits signed by GitHub will have a verified status. You can verify the signature locally using the public key available at https://github.com/web-flow.gpg. The full fingerprint of the key is 5DE3 E050 9C47 EA3C F04A 42D3 4AEE 18F8 3AFD EB23.

######################################################################### GIT ##

### To revert stuff committed by accident ###
% git revert --no-commit D
% git revert --no-commit C
% git revert --no-commit B
% git commit -m \"the commit message for all of them\"
# or
% git revert --no-commit HEAD~3..
# or the same
% git revert --no-commit HEAD~3..HEAD

### delete remote
% git push --delete origin tagname
% git push --delete origin branchname

###  checkout that revision over the top of local files ###
% git checkout -f A -- .
% git commit -a

### view range ###
% git log $OLD..$NEW

### Search commit messages ###
% git log --all --notes -i --grep=''
# or the same ... `g` searches the reflog
% git log --g -i --grep=''

### Search source code ###
% git grep -i \$str $(git rev-list --all)
# or the same ... `g` searches the reflog
% git grep -i \$regex $(git rev-list --all)
# or search a folder within the repo; also if too many files error
% git grep -i \$regex $(git rev-list --all -- sub/tree) -- sub/tree

# push a subtree as a new repo
% git subtree --prefix $dir push $remote $dest_branch

# apply a branches changes on the current branch
% git checkout $branch && git checkout $otherBranch -- .

# show commits in $LATER that are NOT in $EARLIER
% git log $EARLIER..$LATER

### CLI CODE REVIEW
% git diff $dev $release
% git diff --name-status $dev $release

### TROUBLE WITH GPG
# Add GIT_TRACE=1 at the beginning of the command you use. Run the command that failed
% gpg --list-secret-keys --keyid-format=long
% git config --global user.signingkey <your key>

### GPG EXPLAINED
show "G" for a good (valid) signature,
"B" for a bad signature,
"U" for a good signature with unknown validity,
"X" for a good signature that has expired,
"Y" for a good signature made by an expired key,
"R" for a good signature made by a revoked key,
"E" if the signature cannot be checked (e.g. missing key) and
"N" for no signature

### GIT LOG COLORS (https://git-scm.com/docs/git-config#Documentation/git-config.txt-color)

The value for a variable that takes a color is a list of colors (at most two, one for foreground and one for background) and attributes (as many as you want), separated by spaces.

The basic colors accepted are normal, black, red, green, yellow, blue, magenta, cyan, white and default. The first color given is the foreground; the second is the background. All the basic colors except normal and default have a bright variant that can be specified by prefixing the color with bright, like brightred.

The color normal makes no change to the color. It is the same as an empty string, but can be used as the foreground color when specifying a background color alone (for example, "normal red").

The color default explicitly resets the color to the terminal default, for example to specify a cleared background. Although it varies between terminals, this is usually not the same as setting to "white black".

Colors may also be given as numbers between 0 and 255; these use ANSI 256-color mode (but note that not all terminals may support this). If your terminal supports it, you may also specify 24-bit RGB values as hex, like #ff0ab3.

The accepted attributes are bold, dim, ul, blink, reverse, italic, and strike (for crossed-out or "strikethrough" letters). The position of any attributes with respect to the colors (before, after, or in between), doesn’t matter. Specific attributes may be turned off by prefixing them with no or no- (e.g., noreverse, no-ul, etc).

### Scripts / Aliases

I couldn't find in documentation, but if you create a script "git-<name>" in path, you can call it with "git name" in your repo.

######################################################################### GPG ##

sec => 'SECret key'
ssb => 'Secret SuBkey'
pub => 'PUBlic key'
sub => 'public SUBkey'

> --list-secret-keys (-K)
> List the specified secret keys.  If no keys are specified, then all known
> secret keys are listed.  A # after the initial tags sec or ssb means that the
> secret key or subkey is currently not usable.  We also say that this key has
> been taken offline (for example, a primary key can be taken offline by exporting
> the key using the command --export-secret-subkeys).  A > after these tags
> indicate that the key is stored on a smartcard.  See also --list-keys.

### To Use an Offline Master Key
Create a temp dir and import your master key
% gpg --homedir ~/$TEMPDIR --import $PRIVATE_MASTER_KEY

Edit the actual keyring using the keys from you $TEMPDIR
% gpg --homedir ~/$TEMPDIR --keyring ~/.gnupg/pubring.kbx --edit-key $KEY_YOU_WANT_TO_EDIT

Delete $TEMPDIR


####################################################################### MySQL ##

% mysql -h $HOST --user $USERNAME -p
> use $DATABSE
> show tables;
> describe $TABLE;
> quit

####################################################################### RSYNC ##

  -a, --archive                      archive mode; equals -rlptgoD (no -H,-A,-X)

### The following options are implied by -a --archive
  -r --recursive                     recurse into directories
  -l --links                         copy symlinks as symlinks
  -p --perms                         preserve permissions
  -t --times                         preserve times
  -g --group                         preserve group
  -o --owner                         preserve owner (super-user only)
  -D                                 same as --devices --specials
  --devices                          preserve device files (super-user only)
  --specials                         preserve special files

### OTHER ###
 -z --compress                       compress file data during the transfer
 -v --verbose                        increase verbosity
 -h --human-readable                 output numbers in a human-readable format
 -H --hard-links                     preserve hard links
 -A --acls                           preserve ACLs (implies -p)
 -P                                  same as --partial --progress
 --partial                           keep partially transferred files
 --progress                          show progress during transfer
 --dry-run                           show what would have been transferred
 -L, --copy-links                    transform symlink into referent file/dir
 -i, --itemize-changes               output a change-summary for all updates
 -E, --extended-attributes           (v2.6.9) copy extended attributes, resource forks
 -E, --executability                 (v3.1.3) preserve executability
 -X, --xattrs                        (v3.1.3) preserve extended attributes

### MISC ###
  --delete                           delete extraneous files from dest dirs
  --size-only                        only compare file-size, ignoring last modified
  -c, --checksum                     generate an md5 checksum for files that differ in size
  --safe-links                       ignore symlinks that point outside the tree

### EXAMPLE ###
# no slash on the $src; yes slash on the $dest to copy $src AS IS into $dest
% rsync -a -E -h  --progress --dry-run $src $dest


####################################################################### FIND ###

  -print0
        True;  print  the  full file name on the standard output, followed by a
        null character (instead of the newline character that -print uses).  This
        allows file names that contain newlines or other types of white space to
        be correctly interpreted by programs that process the find output. This
        option corresponds to the -0 option of xargs.

### list subdir
# % find ./sub/dir -maxdepth 1 -mindepth 1

###################################################################### XARGS ###

  -0
        Change xargs to expect NUL (``\0'') characters as separators, instead of
        spaces and newlines.  This is expected to be used in concert with the
        -print0 function in find(1).

% find . -type f | [...] | tr \\n \\0 | xargs -0 -I % rm %

################################################################## FIX PERMS ###

% find . -type d -print0 | xargs -0 -I % chmod 755 %
% find . -type f -print0 | xargs -0 -I % chmod 644 %

################################################################# DISK USAGE ###

# local dir
% du -h -d 1

# main drives
% df -h

####################################################################### WGET ###

% wget -e robots=off -m -np $1
% wget -p -k $1
% wget -r -np -nc -k -c $1
% wget --content-disposition --restrict-file-names=nocontrol -e robots=off -A.pdf,.ppt,.doc -r $1

### Misc ###
 -nc --no-clobber
 -r  --recursive
 -np --no-parent
 -k  --convert-links
 -c  --continue
 -p  --page-requisites
 -m  --mirror; It is currently equivalent to -r -N -l inf --no-remove-listing.
 -N  --timestamping
 -l depth --level=depth (default: 5; can use 'inf' or '0')
 -e command --execute command
 -H --span-hosts
 -D domain-list --domains=domain-list
 -O output redirection (put everything in ONE file, this file, NOT NAMED FOR THE ACTUAL FILE)
 -o write LOGS to named file
 --load-cookies file.txt

### Single page ### (https://gist.github.com/dannguyen/03a10e850656577cfb57)
 % wget -E -H -k -K -N -p -P $DIR $PAGEURL

 --adjust-extension, -E
 --span-hosts, -H
 --convert-links, -k
 --backup-converted, -K
 --page-requisites, -p
 --timestamping, -N
 --directory-prefix=someprefix, -P someprefix (save in this dir)

####################################################################### MISC ###

% curl $1 | grep -o 'href=".*"' | sed 's/href="\(.*\)"/\1/p' | xargs -I {} wget "{}"
% ln [options] file-name link-name

################################################################ GO / GOLANG ###

### classic golang.org docs
% go install golang.org/x/tools/cmd/godoc@latest
% cd $GOROOT/pkg
% godoc -http "localhost:6060"
% cd -

### cross compile
% go tool dist list -json
% env GOOS=windows GOARCH=amd64 go [build ...]

### list STDLIB
% tree -L 1 -d $GOROOT/src

### search STDLIB
% grep --colour=always -Iir "$1" "$GOROOT/src"

####################################################################### DIFF ###

# Example usage of comparing output of two ls commands
% diff -u <(ls -l /directory/) <(ls -l /directory/) | colordiff
% cmp $file $file

###################################################################### DATE ###

# TIMESTAMP=$(shell TZ=UTC date '+%FT%T %Z')
# TIMESTAMP=$(shell date '+%Y-%m-%dT%H:%M:%S %z %Z')

# Convert Unix timestamp to human readable
% date -d 1656685875
Fri, 01 Jul 2022 14:31:15 +0000

# Current time as UNIX timestamp
% date "+%s"

###################################################################### ASCII ###

// Comment is the ascii Data Link Escape (DLE) character and begins a commented record
Comment = rune('\020') // byte(16) || "\x10" ...
// FileSep is the ascii File Separator (FS) character and delineates collections of groups (think DBs)
FileSep = rune('\034') // "\034" byte(28) || "\x1c" ...
// GroupSep is the ascii Group Separator (GS) character and delineates groups of records (think DB tables)
GroupSep = rune('\035') // "\035" byte(29) || "\x1d" ...
// RecordSep is the ascii Record Separator (RS) character and delineates records (think DB rows in a table)
RecordSep = rune('\036') // "\036" byte(30) || "\x1e" ...
// UnitSep is the ascii Unit Separator (US) character and delineates fields in a record (think DB fields in a row)
UnitSep = rune('\037') // "\037" byte(31) || "\x1f" ...
// lammertbies.nl/comm/info/ascii-characters.html

#################################################################### DB DSNs ###

export GO_MYSQL_DSN="user:pass@tcp(127.0.0.1:13306)/mysql?parseTime=true&loc=UTC"
export GO_SQLITE_DSN="file:test.sqlite3?parseTime=true&loc=UTC&cache=shared"

% ssh -NL $local-port:$remote-host:$remote-port keyhole-name &

######################################################################## AWK ###

The standard AWK variables are discussed below.

ARGC        - It implies the number of arguments provided at the command line.
ARGV        - It is an array that stores the command-line arguments. The array's valid index ranges from 0 to ARGC-1.
CONVFMT     - It represents the conversion format for numbers. Its default value is %.6g.
ENVIRON     - It is an associative array of environment variables. To find names of other environment variables, use env command.
FILENAME    - It represents the current file name. Please note that FILENAME is undefined in the BEGIN block.
FS          - It represents the (input) field separator and its default value is space. You can also change this by using -F command line option.
NF          - It represents the number of fields in the current record. For instance, the following example prints only those lines that contain more than two fields.
NR          - It represents the number of the current record. For instance, the following example prints the record if the current record number is less than three.
FNR         - It is similar to NR, but relative to the current file. It is useful when AWK is operating on multiple files. Value of FNR resets with new file.
OFMT        - It represents the output format number and its default value is %.6g.
OFS         - It represents the output field separator and its default value is space.
ORS         - It represents the output record separator and its default value is newline.
RLENGTH     - It represents the length of the string matched by match function. AWK's match function searches for a given string in the input-string.
RS          - It represents (input) record separator and its default value is newline.
RSTART      - It represents the first position in the string matched by match function.
SUBSEP      - It represents the separator character for array subscripts and its default value is \034.
$0          - It represents the entire input record.
$n          - It represents the nth field in the current record where the fields are separated by FS.

GNU AWK Specific Variables
ARGIND      - It represents the index in ARGV of the current file being processed.
BINMODE     - It is used to specify binary mode for all file I/O on non-POSIX systems. Numeric values of 1, 2, or 3 specify that input files, output files, or all files, respectively, should use binary I/O. String values of r or w specify that input files or output files, respectively, should use binary I/O. String values of rw or wr specify that all files should use binary I/O.
ERRNO       - A string indicates an error when a redirection fails for getline or if close call fails.
FIELDWIDTHS - A space separated list of field widths variable is set, GAWK parses the input into fields of fixed width, instead of using the value of the FS variable as the field separator.
IGNORECASE  - When this variable is set, GAWK becomes case-insensitive. The following example demonstrates this −
LINT        - It provides dynamic control of the --lint option from the GAWK program. When this variable is set, GAWK prints lint warnings. When assigned the string value fatal, lint warnings become fatal errors, exactly like --lint=fatal.
PROCINFO    - This is an associative array containing information about the process, such as real and effective UID numbers, process ID number, and so on.
TEXTDOMAIN  - It represents the text domain of the AWK program. It is used to find the localized translations for the program's strings.

### Multi-dimensional arrays

$arr[key1, key2] = "value"
Test for membership: if ((key1, key2) in arr)...
# default SUBSEP = \034
Loop over membership: for (key in arr){ split(key, indices, SUBSEP) }

### Basic Scripting

BEGIN{FS="\t"; OFS="\t";}
NR == 1{
	for(i = 1; i < NF; i += 1){
		if(i % 2 != 0){
			print(i, $i);
		}
	}
	exit;
}
END{}

########################################## macOS SSH Can't Connect To Client ###

% eval $(ssh-agent)
% ssh-add

############################################################# BIG FILE DIFFS ###

% find . -type f -print0 | xargs -0 -I % sum %

##################################################################### SQLITE ###

> PRAGMA wal_checkpoint(TRUNCATE);
> VACUUM
> .tables
> .schema $TABLE
> .quit
> echo .dump | sqlite3 $FILENAME

######################################################################### TR ###

% tr -d "\n\r\t"

####################################################################### CURL ###

### https://curl.se/docs/sslcerts.html
### https://curl.se/docs/caextract.html -- ca cert download

curl -b cookies.txt -c cookies.txt $URL

-b cookies to send
-c cookies to keep
-o, --output <file>
-J, --remote-header-name
-O, --remote-name
--remote-name-all
-L # follow redirects

EOF
