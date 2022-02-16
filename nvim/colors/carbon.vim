highlight clear

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction

let s:carbon_Color1 = '#d0d6b5'
let s:carbon_Color2 = '#5d6976'
let s:carbon_Color3 = '#db6378'
let s:carbon_Color4 = '#716994'
let s:carbon_Color5 = '#f9b5ac'
let s:carbon_Color6 = '#727e80'
let s:carbon_Color7 = '#999999'
let s:carbon_Color8 = '#bbbbbb'
let s:carbon_Color9 = '#f9b5ac'
let s:carbon_Color10 = '#c9cccd'
let s:carbon_Color11 = '#ff4262'
let s:carbon_Color12 = '#db6e89'
let s:carbon_Color13 = '#b87ea2'
let s:carbon_Color14 = '#f2c4b3'
let s:carbon_Color15 = '#73a7a7'
let s:carbon_Color16 = '#465063'

call s:highlight('Keyword', '', s:carbon_Color4, 'bold')
call s:highlight('Operator', '', s:carbon_Color14, '')
call s:highlight('Type', '', s:carbon_Color12, '')
call s:highlight('Constant', '', s:carbon_Color14, '')
call s:highlight('String', '', s:carbon_Color15, '')
call s:highlight('Function', '', s:carbon_Color9, '')
call s:highlight('Error', '', s:carbon_Color11, '')
call s:highlight('Identifier', '', s:carbon_Color4, '')
call s:highlight('Comment', '', s:carbon_Color6, '')
call s:highlight('StatusLine', s:carbon_Color6, s:carbon_Color7, '')
call s:highlight('WildMenu', s:carbon_Color16, s:carbon_Color4, '')
call s:highlight('PMenu', s:carbon_Color16, s:carbon_Color4, '')
call s:highlight('LineNr', '', s:carbon_Color16, '')
call s:highlight('CursorLine', s:carbon_Color16, '', '')
call s:highlight('ColorColumn', s:carbon_Color16, '', '')
call s:highlight('SignColumn', s:carbon_Color16, '', '')

" PHP-specific
call s:highlight('Todo', '', s:carbon_Color6, 'bold')
call s:highlight('phpDocComment', '', s:carbon_Color6, '')
call s:highlight('phpDocTags', '', s:carbon_Color2, 'bold')
call s:highlight('phpDocParam', '', s:carbon_Color10, 'bold')
call s:highlight('phpDocIdentifier', '', s:carbon_Color4, 'bold')
call s:highlight('phpDocNamespaceSeparator', '', s:carbon_Color10, 'bold')
call s:highlight('phpClasses', '', s:carbon_Color10, '')
call s:highlight('phpType', '', s:carbon_Color3, '')
call s:highlight('phpKeyword', '', s:carbon_Color9, '')

"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');
"call s:highlight('php', '', '', '');

call s:highlight('DiagnosticError', '', s:carbon_Color11, '')
call s:highlight('DiagnosticWarn', '', s:carbon_Color14, '')
call s:highlight('WarningMsg', '', s:carbon_Color11, '')
call s:highlight('Title', '', s:carbon_Color13, '')
call s:highlight('Search', s:carbon_Color14, s:carbon_Color16, '')
call s:highlight('MoreMsg', '', s:carbon_Color15, '')
call s:highlight('Question', '', s:carbon_Color15, '')

highlight! link TSString String
highlight! link Folded Comment
highlight! link TSPunctSpecial TSPunctDelimiter
highlight! link TSParameter Constant
highlight! link TSConstant Constant
highlight! link NonText Comment
highlight! link TSConstBuiltin TSVariableBuiltin
highlight! link Conditional Operator
highlight! link Whitespace Comment
highlight! link TSFunction Function
highlight! link CursorLineNr Identifier
highlight! link TSRepeat Repeat
highlight! link Macro Function
highlight! link TSTagDelimiter Type
highlight! link TelescopeNormal Normal
highlight! link TSTag MyTag
highlight! link TSNamespace TSType
highlight! link TSFloat Number
highlight! link TSField Constant
highlight! link Repeat Conditional
highlight! link TSLabel Type
highlight! link TSPunctBracket MyTag
highlight! link TSType Type
highlight! link TSOperator Operator
highlight! link Operator Keyword
highlight! link TSKeyword Keyword
highlight! link TSFuncMacro Macro
highlight! link TSComment Comment
highlight! link TSParameterReference TSParameter
highlight! link TSProperty TSField
highlight! link TSNumber Number
highlight! link TSConditional Conditional


