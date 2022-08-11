################ http://zsh.sourceforge.net/Guide/zshguide.html ################

#-------------------------------------------------------------- history file --#
HISTFILE=$HOME/.history
HISTFILESIZE=151000

#----------------------------------------------------- history file max size --#
HISTSIZE=151000

#----------------------------------- max number of lines to write to history --#
SAVEHIST=150000

#-------------------------------------- disallow Ctrl-d from exiting windows --#
setopt ignore_eof

#------------------------------------- add to history upon execution vs exit --#
setopt inc_append_history

#------------------------------ do not append command if it matches the last --#
setopt hist_ignore_dups

#------------------------------------- ignore commands that start with space --#
setopt hist_ignore_space

#----------------------------------------------------------- across sessions --#
# setopt SHARE_HISTORY

#------------------------------------------------ save timestamps in history --#
setopt extended_history

#--------------- TAB twice to see a list of completions and TAB through them --#
unsetopt menu_complete
setopt auto_list
setopt auto_menu

#------------------------------------ disallow cat-ing over an existing file --#
setopt no_clobber

#--------------------------------- confirm corrections on incorrect commands --#
setopt correct

#------------------------------------------------------- turn on completions --#
autoload -U compinit
compinit

#------------------------------------------ completions are case insensitive --#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{A-Z}={a-z}'

#-------------------------------------- completion suggestions are colorized --#
zstyle ':completion:*' list-colors ''

#----------------------------- visible tab highlight through completion list --#
zstyle ':completion:*' menu select

#---------------------------------------------------------------- HOME LOCAL --#
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
# export PATH="/usr/local/nginx/sbin:$PATH"

#-------------------------------------------------------- APP SPECIFIC PATHS --#
# export PATH="$HOME/.composer/vendor/bin:$PATH"

#-------------------------------------------------------------------- GO ENV --#
# export GO111MODULE=on                # should be auto or undefined
export GOPATH="$HOME/go"               # points to local workspace... this is necessary for legacy go code that isn't using modules
export GOBIN="$GOPATH/bin"             # destination for bins after `go install`
export PATH="$GOBIN:$PATH"             # adding $GOBIN to the path to use installed bins
export GOROOT="/usr/local/go"          # this is the default location; ONLY used for custom install location
# export GOVCS=public:git|hg,private:all # this is default
export PATH="$GOROOT/bin:$PATH"        # adding $GOBIN to the path to use installed bins
#export GOROOT_FINAL="/usr/local/go"   # destination after building from source
#export GOROOT_BOOTSTRAP=$GOROOT       # to build new versions of Go, point to the old version of Go
export PATH="$PATH:/opt/homebrew/bin"  # apple silicon use opt for brew

#------------------------------------------------------------------ GO PROXY --#
export GOPROXY=direct                      # https://proxy.golang.org
export GOSUMDB=off
export GOPRIVATE=

#---------------------------------------------------------------------- subl --#
# alias subl='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl '
# ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

#------------------------------------------------- Alias [`man zshbuiltins`] --#
alias lsl='ls -AFGTl '  # --time-style=+'%b %e %T %Y' ## MacOS, BSD
# alias lsl='ls -AFCl --color ' # --time-style=+'%b %e %T %Y' ## Linux
alias lslh='lsl -h '
alias less='less -S '
alias ed='ed -p : '
alias h='history -25'
alias hall='history 1'
alias psp='ps -eo user,group,pid,comm,args'
alias psa='ps aux'
alias grep='grep --color '
alias gome='cd ~/code/go/src/github.com/henderjon'
alias iclouddrive='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias topen='open -a Terminal'
alias python='python3 '

#------------------------------------------------------- these are important --#
#--------------------------- these are off as they mess with tmux and screen --#
export EDITOR="ed -p :"
export CLICOLOR_FORCE=true
export VISUAL="$EDITOR"
export PAGER=cat

#----------------------------------------------------------------------- IRC --#
export IRCNAME=henderjon
export IRCNICK=henderjon
export IRCUSER=henderjon

#-------------------------------- Optional settings not commited to the repo --#
if [ -f "$HOME/.env_zshrc" ]; then
	source "$HOME/.env_zshrc"
fi

#-------------------------------------------- name the ENV based on env file --#
if [ -z "$ENV_NAME" ]; then
	ENV_NAME="henderjon"
fi

#------------------------------------------------------ label screened terms --#
if [[ "$TERM" = "screen"* ]] && [ -z "$TMUX" ]; then
	XTERM=" (screen)"
elif [[ "$TERM" = "screen"* ]] && [ -n "$TMUX" ]; then
	XTERM=" (tmux)"
else
	XTERM=""
fi

#------------------------------------------------------ fancy prompt for zsh --#
PROMPT="[%D{%Y-%m-%d %H:%M:%S}] %?
[%U$ENV_NAME%u]$XTERM %~/
%# "

#-------------------------------------------------------fancy prompt for BASH--#
# export PS1="[\D{%Y-%m-%d %H:%M:%S}] $?\n[\e[;4m$ENV_NAME\e[;0m] \w/\n\$ "

#-------------------------- fancy RIGHT prompt -- '%?[%D{%d %b %Y %l:%M%p}]' --#
#RPROMPT='%?[%D{%Y-%m-%d %H:%M:%S}]'
RPROMPT=''
RPS1='
