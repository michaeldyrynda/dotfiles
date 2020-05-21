" vim-plug configuration ********************************************************
call plug#begin('~/.vim/plugged')

" Vundle bundles
Plug 'ervandew/supertab'
Plug 'Shougo/vimproc'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'garbas/vim-snipmate'
Plug 'tpope/vim-surround'
Plug 'StanAngeloff/php.vim'
Plug 'lilydjwg/colorizer'
Plug 'trevordmiller/nova-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'dhruvasagar/vim-zoom'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'janko/vim-test'
Plug 'rainglow/vim'
Plug 'majutsushi/tagbar'
Plug 'arcticicestudio/nord-vim'
Plug 'tobyS/pdv'
Plug 'tobyS/vmustache'
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'benmills/vimux'
Plug 'tmhedberg/matchit'

call plug#end()

nmap <F6> :TagbarToggle<cr>

let g:pdv_template_dir = $HOME."/.vim/bundle/pdv/templates_snip"

so ~/.vim/coc.vim
so ~/.vim/fzftags.vim
so ~/.vim/phpactor.vim
so ~/.vim/vimtest.vim
