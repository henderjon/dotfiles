" Vim color file
" Converted from Textmate theme phped using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "phped"

hi Cursor ctermfg=NONE ctermbg=15 cterm=NONE guifg=NONE guibg=#ffffff gui=NONE
hi Visual ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#0b4175 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#393939 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#393939 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#393939 gui=NONE
hi LineNr ctermfg=246 ctermbg=237 cterm=NONE guifg=#919191 guibg=#393939 gui=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#636363 guibg=#636363 gui=NONE
hi MatchParen ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi StatusLine ctermfg=15 ctermbg=241 cterm=bold guifg=#ffffff guibg=#636363 gui=bold
hi StatusLineNC ctermfg=15 ctermbg=241 cterm=NONE guifg=#ffffff guibg=#636363 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#0b4175 gui=NONE
hi IncSearch ctermfg=NONE ctermbg=58 cterm=NONE guifg=NONE guibg=#6a6126 gui=NONE
hi Search ctermfg=NONE ctermbg=58 cterm=NONE guifg=NONE guibg=#6a6126 gui=NONE
hi Directory ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Folded ctermfg=249 ctermbg=235 cterm=NONE guifg=#aeaeae guibg=#232323 gui=NONE

hi Normal ctermfg=15 ctermbg=235 cterm=NONE guifg=#ffffff guibg=#232323 gui=NONE
hi Boolean ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Character ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Comment ctermfg=249 ctermbg=NONE cterm=NONE guifg=#aeaeae guibg=NONE gui=NONE
hi Conditional ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=210 ctermbg=NONE cterm=NONE guifg=#ff8080 guibg=NONE gui=NONE
hi Function ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi Identifier ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Keyword ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Label ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi NonText ctermfg=250 ctermbg=236 cterm=NONE guifg=#bfbfbf guibg=#2e2e2e gui=NONE
hi Number ctermfg=210 ctermbg=NONE cterm=NONE guifg=#ff8080 guibg=NONE gui=NONE
hi Operator ctermfg=15 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi PreProc ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi Special ctermfg=15 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey ctermfg=250 ctermbg=237 cterm=NONE guifg=#bfbfbf guibg=#393939 gui=NONE
hi Statement ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi StorageClass ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi String ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi Tag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Title ctermfg=15 ctermbg=NONE cterm=bold guifg=#ffffff guibg=NONE gui=bold
hi Todo ctermfg=249 ctermbg=NONE cterm=inverse,bold guifg=#aeaeae guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi rubyFunction ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi rubyConstant ctermfg=15 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi rubyEscape ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi rubyControl ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=15 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi rubyException ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=15 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=249 ctermbg=NONE cterm=NONE guifg=#aeaeae guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=220 ctermbg=NONE cterm=NONE guifg=#fbde2d guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=77 ctermbg=NONE cterm=NONE guifg=#61ce3c guibg=NONE gui=NONE
hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName ctermfg=104 ctermbg=NONE cterm=NONE guifg=#7996c7 guibg=NONE gui=NONE
hi cssColor ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff6400 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssClassName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssValueLength ctermfg=210 ctermbg=NONE cterm=NONE guifg=#ff8080 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=77 ctermbg=NONE cterm=NONE guifg=#62cd3c guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

