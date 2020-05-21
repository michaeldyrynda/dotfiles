" Vim color file
" Converted from Textmate theme Monokai using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name = "skyknight"

" ============
"  Underline
" ============
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE
hi clear SpellCap " & ALE
hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE

" ============
"  yamabuki
" ============
hi String ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi Character ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE

" ============
"  gray
" ============
hi Statement ctermfg=249 ctermbg=NONE cterm=NONE guifg=#a4a4a4 guibg=NONE gui=NONE
hi Identifier ctermfg=249 ctermbg=NONE cterm=NONE guifg=#a4a4a4 guibg=NONE gui=NONE
hi Type ctermfg=249 ctermbg=NONE cterm=NONE guifg=#a4a4a4 guibg=NONE gui=NONE
hi Directory ctermfg=249 ctermbg=NONE cterm=NONE guifg=#a4a4a4 guibg=NONE gui=NONE
hi MatchParen ctermfg=249 ctermbg=NONE cterm=NONE guifg=#a4a4a4 guibg=NONE gui=NONE

" ============
"  skyblue
" ============
hi PreProc ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Label ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Boolean ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Float ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Number ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Operator ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Structure ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi StorageClass ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Function ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Define ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Question ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE
hi Conditional ctermfg=45 ctermbg=NONE cterm=NONE guifg=#00dfff guibg=NONE gui=NONE

" ============
"  yellowgreen
" ============
hi DiffAdd ctermfg=148 ctermbg=NONE cterm=NONE guifg=#a6e22e guibg=NONE gui=NONE

" ============
"  yellow
" ============
hi SpecialChar ctermfg=226 ctermbg=NONE cterm=NONE guifg=#ffff00 guibg=NONE gui=NONE
hi Todo ctermfg=226 ctermbg=NONE cterm=NONE guifg=#ffff00 guibg=NONE gui=NONE

" ============
"  orange
" ============
hi Search ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff8700 guibg=NONE gui=NONE
hi IncSearch ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff8700 guibg=NONE gui=NONE
hi DiffText ctermfg=202 ctermbg=NONE cterm=NONE guifg=#ff8700 guibg=NONE gui=NONE

" ============
"  red
" ============
hi Keyword ctermfg=196 ctermbg=NONE cterm=NONE guifg=#ff0000 guibg=NONE gui=NONE
hi Special ctermfg=196 ctermbg=NONE cterm=NONE guifg=#ff0000 guibg=NONE gui=NONE
hi Tag ctermfg=196 ctermbg=NONE cterm=NONE guifg=#ff0000 guibg=NONE gui=NONE
hi DiffDelete ctermfg=196 ctermbg=NONE cterm=NONE guifg=#ff0000 guibg=NONE gui=NONE
hi MatchParen ctermfg=196 ctermbg=NONE cterm=underline guifg=#ff0000 guibg=NONE gui=underline
hi ErrorMsg ctermfg=231 ctermbg=196 cterm=NONE guifg=#f8f8f0 guibg=#ff0000 gui=NONE
hi WarningMsg ctermfg=231 ctermbg=196 cterm=NONE guifg=#f8f8f0 guibg=#ff0000 gui=NONE

" =================
"  black and white
" =================
hi Cursor ctermfg=235 ctermbg=231 cterm=NONE guifg=#272822 guibg=#f8f8f0 gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#49483e gui=NONE
hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE
hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE
hi Folded ctermfg=242 ctermbg=235 cterm=NONE guifg=#75715e guibg=#272822 gui=NONE
hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
hi Comment ctermfg=240 ctermbg=NONE cterm=NONE guifg=#585858 guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#243955 gui=NONE
hi NonText ctermfg=59 ctermbg=236 cterm=NONE guifg=#49483e guibg=#31322c gui=NONE
hi SpecialComment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=237 cterm=NONE guifg=#49483e guibg=#3c3d37 gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=NONE gui=bold
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

" =================
"  menu
" =================
hi Pmenu ctermfg=249 ctermbg=236 cterm=NONE guifg=#a4a4a4 guibg=#3c3d37 gui=NONE
hi PmenuSel ctermfg=80 ctermbg=59 cterm=NONE guifg=#5fd7d7 guibg=#49483e gui=NONE

" =================
"  link
" =================
hi link gitcommitSummary String