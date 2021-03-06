" vim-plug configuration ********************************************************
call plug#begin('~/.vim/plugged')

" Vundle bundles
Plug 'ervandew/supertab'
Plug 'Shougo/vimproc'

Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', {'do': 'fzf#install()'}
Plug 'junegunn/fzf.vim', {'do': 'fzf#install()'}
Plug 'mattn/emmet-vim'
Plug 'janko/vim-test'
Plug 'arcticicestudio/nord-vim'
Plug 'prettier/vim-prettier', {'on': ['Prettier', 'PrettierAsync'], 'do': 'npm install'}
Plug 'benmills/vimux'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'gcmt/breeze.vim'
Plug 'christoomey/vim-tmux-navigator'

" Snippets
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" PHP
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'develop', 'do': 'composer install --no-dev'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-vdebug/vdebug'

Plug 'iamcco/coc-tailwindcss',  {'do': 'npm ci && npm build'}

call plug#end()

so ~/.vim/coc.vim
so ~/.vim/fzftags.vim
so ~/.vim/phpactor.vim
so ~/.vim/vimtest.vim

noremap <Leader>g :Gstatus<cr>
noremap <Leader>p :PrettierAsync<cr>

let g:snipMate = { 'snippet_version' : 1 }
