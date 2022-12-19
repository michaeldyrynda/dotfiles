"
" Default configuration
"

" Persistent undo
let &undodir=sourcery#system_vimfiles_path('undo')

packadd! matchit

" Automatically resize splits when Vim is resized
autocmd VimResized * :wincmd =
