" Vim color file
" Name:       facebook.vim
" Version:    1.0
" Maintainer: Farfanoide <https://github.com/farfanoide>

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Facebook"

"General
hi Cursor           guifg=#252b39   ctermfg=236     guibg=#979e86   gui=NONE
hi Visual           cterm=NONE      guifg=NONE      guibg=#353b4a   ctermbg=237     gui=NONE
hi CursorLine       cterm=NONE      guifg=NONE      guibg=#353b4a   ctermbg=237     gui=NONE
hi CursorColumn     guifg=NONE      guibg=#353b4a   ctermbg=237     gui=NONE
hi ColorColumn      guifg=NONE      guibg=#353b4a   ctermbg=237     gui=NONE
hi LineNr           guifg=#747d8e   ctermfg=244     guibg=#353b4a   gui=NONE
hi VertSplit        guifg=#747d8e   ctermfg=244     guibg=#353b4a   ctermbg=59      gui=NONE
hi MatchParen       cterm=underline guifg=#ffffff   ctermfg=15      guibg=NONE      gui=underline
hi StatusLine       cterm=bold      guifg=#c3cee3   ctermfg=253     guibg=#535a6a   gui=bold
hi StatusLineNC     guifg=#c3cee3   ctermfg=252     guibg=#535a6a   gui=NONE
hi Pmenu            guifg=NONE      guibg=NONE      gui=NONE
hi PmenuSel         guifg=NONE      guibg=#1a1f29   ctermbg=234     gui=NONE
hi IncSearch        guifg=#252b39   ctermfg=236     guibg=#d5d5ca   gui=NONE
hi Search           cterm=underline guifg=NONE      guibg=NONE      gui=underline
hi Directory        guifg=#abd683   ctermfg=150     guibg=NONE      gui=NONE
hi Folded           guifg=#7081be   ctermfg=67      guibg=#252b39   gui=NONE
hi Normal           guifg=#c3cee3   ctermfg=252     guibg=#252b39   gui=NONE        ctermbg=237
hi Boolean          cterm=bold      guifg=#e4eaf0   ctermfg=7       guibg=NONE      gui=bold
hi Character        guifg=#d5d5ca   ctermfg=252     guibg=NONE      gui=NONE
hi Comment          guifg=#7081be   ctermfg=67      guibg=NONE      gui=NONE
hi Conditional      cterm=bold      guifg=#ffffff   ctermfg=15      guibg=NONE      gui=bold
hi Constant         guifg=NONE      guibg=NONE      gui=NONE
hi Define           cterm=bold      guifg=#ffffff   ctermfg=15      guibg=NONE      gui=bold
hi DiffAdd          cterm=bold      guifg=#c3cee3   ctermfg=252     guibg=#468410   gui=bold
hi DiffDelete       guifg=#8b090b   ctermfg=88      guibg=NONE      gui=NONE
hi DiffChange       guifg=#c3cee3   ctermfg=252     guibg=#233b60   gui=NONE
hi DiffText         cterm=bold      guifg=#c3cee3   ctermfg=252     guibg=#204a87   gui=bold
hi ErrorMsg         guifg=NONE      guibg=NONE      gui=NONE
hi WarningMsg       guifg=NONE      guibg=NONE      gui=NONE
hi Float            guifg=#18c9c9   ctermfg=6       guibg=NONE      gui=NONE
hi Function         guifg=#8be9ee   ctermfg=117     guibg=NONE      gui=NONE
hi Identifier       guifg=#d3afc5   ctermfg=182     guibg=NONE      gui=italic
hi Keyword          cterm=bold      guifg=#ffffff   ctermfg=67      guibg=NONE      gui=bold
hi Label            guifg=#d5d5ca   ctermfg=252     guibg=NONE      gui=NONE
hi NonText          guifg=#747d8e   ctermfg=244     guibg=#353b4a   gui=NONE
hi Number           guifg=#18c9c9   ctermfg=6       guibg=NONE      gui=NONE
hi Operator         cterm=bold      guifg=#e4eaf0   ctermfg=7       guibg=NONE      gui=bold
hi PreProc          cterm=bold      guifg=#ffffff   ctermfg=186      guibg=NONE      gui=bold
hi Special          guifg=#c3cee3   ctermfg=6     guibg=NONE      gui=NONE
hi SpecialKey       guifg=#ff0000   ctermfg=9       guibg=#353b4a   gui=NONE
hi Statement        cterm=bold      guifg=#ffffff   ctermfg=15      guibg=NONE      gui=bold
hi StorageClass     guifg=#d3afc5   ctermfg=15     guibg=NONE      gui=bold
hi String           guifg=#e3c78a   ctermfg=186     guibg=NONE      gui=NONE
hi Tag              guifg=#8db3ff   ctermfg=111     guibg=NONE      gui=NONE
hi Title            cterm=bold      guifg=#c3cee3   ctermfg=252     guibg=NONE      gui=bold
hi Type             guifg=#e3c78a   ctermfg=117     guibg=NONE      gui=NONE
hi Underlined       cterm=underline guifg=NONE      guibg=NONE      gui=underline
hi Todo             guifg=#7081be   ctermfg=67      guibg=NONE      gui=inverse,bold cterm=inverse,bold

" Ruby
hi rubyClass            cterm=bold      guifg=#ffffff   ctermfg=15  guibg=NONE  gui=bold
hi rubyFunction         guifg=#8be9ee   ctermfg=117     guibg=NONE  gui=NONE
hi rubySymbol           guifg=#abd683   ctermfg=150     guibg=NONE  gui=NONE
hi rubyConstant         guifg=#e3c78a   ctermfg=186     guibg=NONE  gui=NONE
hi rubyStringDelimiter  guifg=#d5d5ca   ctermfg=252     guibg=NONE  gui=NONE
hi rubyBlockParameter   guifg=#18c9c9   ctermfg=6       guibg=NONE  gui=italic
hi rubyInstanceVariable guifg=#7081be   ctermfg=67      guibg=NONE  gui=NONE
hi rubyInclude          cterm=bold      guifg=#ffffff   ctermfg=15  guibg=NONE  gui=bold
hi rubyGlobalVariable   guifg=#8dc4f0   ctermfg=117     guibg=NONE  gui=NONE
hi rubyRegexp           guifg=#18c9c9   ctermfg=6       guibg=NONE  gui=NONE
hi rubyRegexpDelimiter  guifg=#18c9c9   ctermfg=6       guibg=NONE  gui=NONE
hi rubyEscape           guifg=#d5d5ca   ctermfg=252     guibg=NONE  gui=NONE
hi rubyControl          cterm=bold      guifg=#ffffff   ctermfg=15  guibg=NONE  gui=bold
hi rubyClassVariable    guifg=NONE      guibg=NONE      gui=NONE
hi rubyOperator         cterm=bold      guifg=#e4eaf0   ctermfg=7   guibg=NONE  gui=bold
hi rubyException        cterm=bold      guifg=#ffffff   ctermfg=15  guibg=NONE  gui=bold
hi rubyPseudoVariable   guifg=#b3b2a2   ctermfg=145     guibg=NONE  gui=NONE
hi rubyRailsUserClass   guifg=#e3c78a   ctermfg=186     guibg=NONE  gui=NONE
hi rubyRailsARMethod    guifg=#8be9ee   ctermfg=117     guibg=NONE  gui=NONE
hi rubyRailsMethod      guifg=#8be9ee   ctermfg=117     guibg=NONE  gui=NONE
hi erubyDelimiter       guifg=NONE      guibg=NONE      gui=NONE
hi erubyComment         guifg=#7081be   ctermfg=67      guibg=NONE  gui=NONE
hi erubyRailsMethod     guifg=#8be9ee   ctermfg=117     guibg=NONE  gui=NONE
hi rubyMethodDeclaration                guifg=#8be9ee   ctermfg=117 guibg=NONE gui=NONE
hi rubyRailsRenderMethod                guifg=#8be9ee   ctermfg=117 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod         guifg=#8be9ee   ctermfg=117 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter           guifg=NONE      guibg=NONE  gui=NONE


" PHP
hi phpMethodsVar    guifg=#c3cee3   ctermfg=252     guibg=NONE  ctermbg=NONE gui=NONE
hi phpIdentifier    guifg=#8dc4f0   ctermfg=103     guibg=NONE  gui=NONE
hi phpVarSelector   guifg=#8dc4f0   ctermfg=67     guibg=NONE  gui=NONE
hi phpStorageClass  guifg=#d3afc5   ctermfg=182     guibg=NONE  gui=italic
hi phpStringSingle  guifg=#e3c78a   ctermfg=186     guibg=NONE  gui=NONE

" HTML
hi htmlTag         guifg=#7081be   ctermfg=67      guibg=NONE      gui=NONE
hi htmlTagName     guifg=#8be9ee   ctermfg=117     guibg=NONE      gui=NONE
hi htmlEndTag      guifg=NONE      guibg=NONE      gui=NONE
hi htmlArg         guifg=#c3cee3   ctermfg=252     guibg=NONE      ctermbg=NONE gui=NONE
hi htmlSpecialChar guifg=#d67c9b   ctermfg=174     guibg=NONE      gui=NONE
hi htmlString      guifg=#d67c9b   ctermfg=174     guibg=NONE      gui=NONE

" Javascript
hi javaScriptFunction           guifg=#d3afc5   ctermfg=182 guibg=NONE gui=italic
hi javaScriptRailsFunction      guifg=#8be9ee   ctermfg=117 guibg=NONE gui=NONE
hi javaScriptBraces             guifg=NONE  guibg=NONE  gui=NONE

" Yaml
hi yamlKey          guifg=#8db3ff   ctermfg=111     guibg=NONE  gui=NONE
hi yamlAnchor       guifg=#8dc4f0   ctermfg=117     guibg=NONE  gui=NONE
hi yamlAlias        guifg=#8dc4f0   ctermfg=117     guibg=NONE  gui=NONE
hi yamlDocumentHeader               guifg=#d5d5ca   ctermfg=252 guibg=NONE gui=NONE

" CSS
hi cssURL           guifg=#18c9c9   ctermfg=6   guibg=NONE gui=italic
hi cssFunctionName  guifg=#8be9ee   ctermfg=117 guibg=NONE gui=NONE
hi cssColor         guifg=#18c9c9   ctermfg=6   guibg=NONE gui=NONE
hi cssPseudoClassId guifg=#96fbff   ctermfg=123 guibg=NONE gui=NONE
hi cssClassName     guifg=#96fbff   ctermfg=123 guibg=NONE gui=NONE
hi cssValueLength   guifg=#18c9c9   ctermfg=6   guibg=NONE gui=NONE
hi cssCommonAttr    guifg=#c3cee3   ctermfg=252 guibg=NONE gui=NONE
hi cssBraces        guifg=NONE      guibg=NONE  gui=NONE

" Nerdtree
hi NERDTreeDir        guifg=#8db3ff   ctermfg=111  guibg=NONE   ctermbg=NONE  gui=NONE
hi NERDTreeDirSlash   guifg=#8db3ff   ctermfg=111  guibg=NONE   ctermbg=NONE  gui=NONE

" GitGutter
hi SignColumn       guifg=#747d8e   ctermfg=244     guibg=#353b4a   ctermbg=59      gui=bold      cterm=bold
hi GitGutterAdd     guifg=green     gui=bold        guibg=#353b4a   ctermbg=59      gui=bold      cterm=bold
