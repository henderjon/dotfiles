" Interface
	set title                                                " allow vim to alter the title bar of the terminal
	set titlestring=%<%F\ %M%R\ %n                           " the format of the terminal title
	set nowrap                                               " turn off word wrap
	set number                                               " line numbers
	set ruler                                                " show ruler
	set paste                                                " allow better copy-n-pasting
	set laststatus=2                                         " always show command area
	set cmdheight=2                                          " make command area two lines high
	set statusline=\ %n\ \ %<%F\ \ %M%R%=\ %c\ \ %l/%L\ \ %r " comment?
	set showtabline=2                                        " 0=never; 1=when applicable; 2=always
	set showmode                                             " show the current mode
	" set scrolloff=15                                       " scroll when cursor is N lines from the top/bottom edge
	set showcmd                                              " show commands in command area
	set visualbell t_vb=                                     " Turn off audible bell
	set clipboard=unnamed                                    " hopefully catch the cut/paste of the OS
	autocmd BufWritePre * :%s/\s\+$//e                       " remove trainling white space on :w
	" set clipboard=unnamedplus                              " same as above but for vim -v > 7.3.74
	" set lines=30 columns=100
	set diffopt=filler,iwhite
	set fileformats=unix,dos
" Margins
	set tabstop=4                                            " tab width
	set shiftwidth=4                                         " shift width
	set tabpagemax=15                                        " allow 15 tabs

" Search
	set hlsearch "highlight search results

" Editor Preferences
	set showmatch                                            " show the matching bracket
	set autoindent                                           " auto indent based on previous line
	" set autochdir                                          " automatically change the working dir to the dir of the current file/buffer/window
	set cursorline                                           " show the current cursor line
	set backspace=indent,eol,start                           " {:help bs} a fix for *POSSIBLY*  broken backspace keys
	set matchpairs+=<:>                                      " add html tag delimeters to bracket matching
	set whichwrap=<,>,[,],h,l                                " Allows for left/right keys to wrap across lines
	filetype plugin on                                       " allows for some extra filetype specific goodness, specifically auto comments
	if !&diff
		set colorcolumn=80,72
	endif

	syntax on
	highlight ColorColumn ctermbg=DarkGray ctermfg=white
	" colorscheme monokaish
	" set background=dark






