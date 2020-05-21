" Vundle configuration ********************************************************
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" vim-scripts repos
Plugin 'L9'

" Vundle bundles
"Plugin 'ervandew/supertab'
Plugin 'Shougo/vimproc'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'wakatime/vim-wakatime'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-vinegar'
Plugin 'sheerun/vim-polyglot'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-surround'
Plugin 'StanAngeloff/php.vim'
Plugin 'lilydjwg/colorizer'
Plugin 'trevordmiller/nova-vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'junegunn/fzf.vim'
Plugin 'mattn/emmet-vim'
Plugin 'dhruvasagar/vim-zoom'
Plugin 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plugin 'janko/vim-test'
Plugin 'rainglow/vim'
Plugin 'majutsushi/tagbar'
Plugin 'arcticicestudio/nord-vim'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'prettier/vim-prettier', {'do': 'npm install'}
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'benmills/vimux'
Plugin 'tmhedberg/matchit'

call vundle#end()
filetype plugin indent on " required!

nmap <F6> :TagbarToggle<cr>

let g:pdv_template_dir = $HOME."/.vim/bundle/pdv/templates_snip"

source ~/.vim/coc.vim
