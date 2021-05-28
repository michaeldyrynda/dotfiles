" vim-plug configuration ********************************************************
call plug#begin('~/.vim/plugged')

" Vundle bundles
Plug 'Shougo/vimproc'

Plug 'vim-airline/vim-airline'
Plug 'wakatime/vim-wakatime'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
Plug 'jwalton512/vim-blade'
Plug 'tpope/vim-surround'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', {'do': 'fzf#install()'}
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'janko/vim-test'
Plug 'arcticicestudio/nord-vim'
Plug 'benmills/vimux'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'gcmt/breeze.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-xmlattr'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" PHP
Plug 'dense-analysis/ale'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-vdebug/vdebug'

call plug#end()

so ~/.vim/coc.vim
so ~/.vim/fzftags.vim
so ~/.vim/phpactor.vim
so ~/.vim/vimtest.vim
so ~/.vim/php.vim
so ~/.vim/linting.vim

noremap <Leader>g :Gstatus<cr>
