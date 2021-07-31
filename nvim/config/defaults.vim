"
" Default configuration
"
set autowriteall
set completeopt=menuone,noselect
set colorcolumn=120
set cursorline
set expandtab
set ignorecase
set matchpairs+=<:>
set nobackup
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set shiftround
set showmatch
set smartcase
set smartindent
set splitbelow
set splitright
set termguicolors
set signcolumn=yes
set timeoutlen=500

" Persistent undo
let &undodir=sourcery#system_vimfiles_path('undo')
set undofile

packadd! matchit

" Automatically resize splits when Vim is resized
autocmd VimResized * :wincmd =
