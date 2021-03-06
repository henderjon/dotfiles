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

#------------------------------------------------------- these are important --#
#--------------------------- these are off as they mess with tmux and screen --#
#export EDITOR=ed
#export VISUAL=vi
#export PAGER=less

#---------------------------------------------------------------- HOME LOCAL --#
export HOMELOCAL=$HOME/local
export GO111MODULE=on

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOMELOCAL/bin:$HOMELOCAL/sbin:$PATH
export PATH=$HOME/bin:$PATH

#-------------------------------------------------------------------- GO ENV --#
#export GOPATH="$HOME/code/go"             # points to local workspace
#export GOROOT="/usr/local/go"             # this is the default location; ONLY used for custom install location
#export GOROOT_FINAL="/usr/local/go"       # destination after building from source
#export GOBIN=$GOROOT/bin                  # destination for bins after `go install`
export PATH=/usr/local/go/bin:$HOME/go/bin:$PATH # adding $GOBIN to the path to use installed bins
#export GOROOT_BOOTSTRAP=$GOROOT           # to build new versions of Go, point to the old version of Go

#---------------------------------------------------------------------- subl --#
# alias subl='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl '
# ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

#------------------------------------------------- Alias [`man zshbuiltins`] --#
alias lsl='ls -AFGTl '  # --time-style=+'%b %e %T %Y' ## MacOS, BSD
# alias lsl='ls -AFCl --color ' # --time-style=+'%b %e %T %Y' ## Linux
alias lslh='lsl -h '
alias less='less -S '
alias ed='ed -p :'
alias h='history -25'
alias hall='history 1'
alias psp='ps -eo user,group,pid,comm,args'
alias grep='grep --color '
alias gome='cd ~/go/src/github.com/henderjon'

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
	ENV_NAME="Laptop"
fi

#------------------------------------------------------ label screened terms --#
if [[ "$TERM" = "screen"* ]] && [ -z "$TMUX" ]; then
	XTERM=" (screen)"
elif [[ "$TERM" = "screen"* ]] && [ -n "$TMUX" ]; then
	XTERM=" (tmux)"
else
	XTERM=""
fi

#-------------------------------------------------------------- fancy prompt --#
PROMPT="[$ENV_NAME]$XTERM %# %~/: "

#-------------------------- fancy RIGHT prompt -- '%?[%D{%d %b %Y %l:%M%p}]' --#
RPROMPT='%?[%D{%Y-%m-%d %H:%M:%S}]'
