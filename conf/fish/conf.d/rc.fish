# https://fishshell.com/docs/current/cmds/complete.html
# $HOME/.config/fish/conf.d/rc.fish

abbr --add ed ed -p :
abbr --add lsl ls -AFGTl # --time-style=+'%b %e %T %Y' ## MacOS, BSD
# abbr --add lsl ls -AFCl --color  # --time-style=+'%b %e %T %Y' ## Linux
abbr --add lslh lsl -h
abbr --add less less -S
abbr --add ed ed -p :
abbr --add h history -25
abbr --add hall history 1
abbr --add psp ps -eo user,group,pid,comm,args
abbr --add psa ps aux
abbr --add grep grep --color
abbr --add gome cd ~/code/go/src/github.com/henderjon
abbr --add iclouddrive cd ~/Library/Mobile\ Documents/com~apple~CloudDocs
abbr --add topen open -a Terminal
abbr --add python python3
abbr --add diff diff -u --color=always

set -x PATH "$HOME/bin" "$PATH"
set -x GOROOT "/usr/local/go"             # this is the default location; ONLY used for custom install location
set -x GOPATH "$HOME/go"                  # points to local workspace... this is necessary for legacy go code that isn't using modules
set -x GOBIN "$GOPATH/bin"                # destination for bins after `go install`
set -x PATH "$GOBIN" "$PATH"              # adding $GOBIN to the path to use installed bins
set -x PATH "$GOROOT/bin" "$PATH"         # adding $GOROOT to the path to use installed bins
set -x GOPROXY direct                     # https://proxy.golang.org
set -x GOSUMDB off
set -x GOPRIVATE
# set -x GOROOT_FINAL "/usr/local/go"       # destination after building from source
# set -x GOROOT_BOOTSTRAP $GOROOT           # to build new versions of Go, point to the 1.4 bootstrap version of Go
# set -x GOVCS "public:git|hg,private:all"  # this is default

# set -x PATH "$PATH" "/usr/local/Homebrew/bin"      # apple intel
set -x PATH "$PATH" "/opt/homebrew/bin"              # apple silicon
set -x PATH "$PATH" "/home/linuxbrew/.linuxbrew/bin" # ubuntu
set -x HOMEBREW_NO_AUTO_UPDATE 1

set -x PATH "$PATH" "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin" #default
set -x PATH "$PATH" "/Applications/Sublime Text.app/Contents/SharedSupport/bin"

set -x PATH "$PATH" "/usr/local/bin"
set -x PATH "$PATH" "/usr/local/sbin"
set -x PATH "$PATH" "$HOME/dotfiles/bin"

set -gx EDITOR "ed -p : "
set -gx CLICOLOR_FORCE true
set -gx VISUAL $EDITOR
# Define $PAGER *g*lobal and e*x*ported
set -gx PAGER cat
set -gx DIFFCOLORS "31:32" # ascii color codes ... add:rm
set -gx GLAMOUR_STYLE "$HOME/dotfiles/conf/gh/monokai22.json" # set gh color scheme
# set -gx XDG_CONFIG_HOME "$HOME/.config"

#--------------------------------------------------------------------- SNIPS --#
set -gx SNIPS_FILE "$HOME/dotfiles/resources/terminal/snips.txt"
abbr --add snips cat "$SNIPS_FILE"

#--------------------------------------------------------------------- ASCII --#
set -gx ASCII_FILE "$HOME/dotfiles/resources/terminal/ascii.tsv"
abbr --add ascii head -133 "$ASCII_FILE"
abbr --add asciix cat "$ASCII_FILE"

if test -z "$ENV_NAME"
	set -x ENV_NAME "<><" # redefine in env.fish
end

switch (uname)
case Linux
	# digital ocean / ubuntu
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
case Darwin
	# apple silcon
	eval "$(/opt/homebrew/bin/brew shellenv)"

	# apple intel
	# eval "$(/usr/local/bin/brew shellenv)"
# case FreeBSD NetBSD DragonFly
#     echo Hi Beastie!
# case '*'
#     echo Hi, stranger!
end
