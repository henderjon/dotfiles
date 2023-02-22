" Vim color file

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "monokaish"

" 81  66d9ef blue
" 197 f92672 pink
" 148 a6e22e green
" 186 e6db74 yellow
" 208 fd971f orange
" 141 ae81ff purple
" 237 3E3D32 grey
" 235 272822 black

" to view named colors
" :runtime syntax/colortest.vim
" to view default vim highlight groups
" :help highlight-groups

"Editor Options
	" turn on syntax highlighting
	syntax on
	set background=dark
	"set t_Co=256

"Editor Color
	highlight Normal                  ctermbg=none        ctermfg=white                 guibg=#272822   guifg=white
	highlight CursorLine   cterm=none ctermbg=238                                       guibg=#3E3D32
	highlight ColorColumn  cterm=none ctermbg=238                                       guibg=#3E3D32
	highlight StatusLine   cterm=none ctermbg=white       ctermfg=black      gui=none   guibg=white     guifg=black
	highlight StatusLineNC cterm=none ctermbg=grey        ctermfg=black      gui=none   guibg=grey      guifg=black
	highlight TabLine      cterm=none ctermbg=grey        ctermfg=black      gui=none   guibg=grey      guifg=black
	highlight TabLineFill  cterm=none ctermbg=grey        ctermfg=grey       gui=none   guibg=grey      guifg=grey
	highlight TabLineSel   cterm=bold ctermbg=black       ctermfg=yellow     gui=none   guibg=black     guifg=yellow
	highlight LineNr                  ctermbg=white       ctermfg=black                 guibg=white     guifg=black
	highlight Directory                                                                                 guifg=yellow

"For Diffing, gui colors are not monokai, but variants of named terminal colors
	highlight DiffAdd      cterm=none ctermbg=darkblue    ctermfg=lightgray  gui=none   guibg=#457BB1   guifg=#DBDFD8
	highlight DiffChange   cterm=none ctermbg=brown       ctermfg=black      gui=none   guibg=#AF5F11   guifg=black
	highlight DiffText     cterm=none ctermbg=yellow      ctermfg=black      gui=none   guibg=#FCEA6B   guifg=black
	highlight DiffDelete   cterm=none ctermbg=none        ctermfg=darkgray   gui=none                   guifg=#6C6C6C

"Groups :help group-name
	highlight MatchParen              ctermbg=lightblue                                 guibg=#66d9ef
	highlight Comment      cterm=none                     ctermfg=grey       gui=italic                 guifg=grey
	highlight Constant                                    ctermfg=yellow                                guifg=#e6db74
	highlight String                                      ctermfg=yellow                                guifg=#e6db74
	highlight Character                                   ctermfg=yellow                                guifg=#e6db74
	"highlight Special
	highlight Identifier   cterm=none                     ctermfg=white                                 guifg=white
	highlight Delimiter                                   ctermfg=white                                 guifg=white
	highlight Function                                    ctermfg=blue                                  guifg=#66d9ef
	highlight Statement                                   ctermfg=red                                   guifg=#f92672
	highlight Operator                                    ctermfg=red                                   guifg=#f92672
	highlight PreProc                                     ctermfg=lightblue                             guifg=#66d9ef
	highlight Type                                        ctermfg=red        gui=none                   guifg=#f92672
	highlight Structure                                   ctermfg=lightblue                             guifg=#66d9ef
	highlight StorageClass                                ctermfg=red                                   guifg=#f92672
	"highlight Underlined
	"highlight Ignore
	highlight Error                   ctermbg=red                                       guibg=#f92672
	highlight Todo                    ctermbg=red                                       guibg=#f92672

"Special Groups
	highlight Visual                  ctermbg=blue        ctermfg=white                 guibg=#66d9ef   guifg=white
	highlight Folded                  ctermbg=none        ctermfg=darkgray
	highlight FoldColumn                                  ctermfg=darkgray

"Custom Syntax in ~/.vim/after/syntax

" Goloang
	highlight goDirective                                 ctermfg=red                                   guifg=#f92672
	highlight goDeclaration                               ctermfg=red                                   guifg=#f92672
	highlight goDeclType                                  ctermfg=red                                   guifg=#f92672

	highlight goStatement                                 ctermfg=red                                   guifg=#f92672
	highlight goConditional                               ctermfg=red                                   guifg=#f92672
	highlight goLabel                                     ctermfg=red                                   guifg=#f92672
	highlight goRepeat                                    ctermfg=red                                   guifg=#f92672

	highlight goType                                      ctermfg=blue                                  guifg=#66d9ef
	highlight goSignedInts                                ctermfg=blue                                  guifg=#66d9ef
	highlight goUnsignedInts                              ctermfg=blue                                  guifg=#66d9ef
	highlight goFloats                                    ctermfg=blue                                  guifg=#66d9ef
	highlight goComplexes                                 ctermfg=blue                                  guifg=#66d9ef

	highlight goBuiltins                                  ctermfg=blue                                  guifg=#66d9ef
	highlight goConstants                                 ctermfg=darkmagenta                           guifg=#ae81ff

	highlight goFuncCall                                  ctermfg=blue                                  guifg=#66d9ef
	highlight goInitAssign                                ctermfg=red                                   guifg=#f92672
	highlight goFuncDefine                                ctermfg=white                                 guifg=white
	highlight goFuncDefName                               ctermfg=green                                 guifg=#a6e22e

	highlight goString                                    ctermfg=yellow                                guifg=#e6db74
	highlight goRawString                                 ctermfg=yellow                                guifg=#e6db74
	highlight goCharacter                                 ctermfg=yellow                                guifg=#e6db74
	highlight goSpecialString                             ctermfg=yellow                                guifg=#e6db74

	"highlight goComment                                  ctermfg=grey                                  guifg=grey
	"highlight goTodo                                     ctermfg=grey                                  guifg=grey

	highlight goEscapeOctal                               ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goEscapeC                                   ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goEscapeX                                   ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goEscapeU                                   ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goEscapeBigU                                ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goEscapeError                               ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goDecimalInt                                ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goHexadecimalInt                            ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goOctalInt                                  ctermfg=darkmagenta                           guifg=#ae81ff
	highlight Integer                                     ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goFloat                                     ctermfg=darkmagenta                           guifg=#ae81ff
	highlight goImaginary                                 ctermfg=darkmagenta                           guifg=#ae81ff

" PHP Custom Syntax
	syn match phpOperator "[-=+,;%^&|*!.~?:]" contained display
	highlight phpType            cterm=NONE               ctermfg=blue                 gui=NONE         guifg=#66d9ef
	highlight phpIdentifier      cterm=NONE                                            gui=NONE
	highlight phpVarSelector                              ctermfg=white                                 guifg=white

" misc help
" :help syntax|group-names|usr_44|highlight|syn-pattern-offset|highlight-ctermbg|highlight-groups
