"
" Default configuration
"
set autowriteall
set completeopt=menu,menuone,noselect
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
set timeoutlen=300
set updatetime=300
set lazyredraw
set scrolloff=8
set wildmode=longest:full,full

" Persistent undo
let &undodir=sourcery#system_vimfiles_path('undo')
set undofile

packadd! matchit

" Automatically resize splits when Vim is resized
autocmd VimResized * :wincmd =
