"
" Installed plugins
"

" Simplify management of vim configuration (https://github.com/jesseleite/vim-sourcery)
Plug 'jesseleite/vim-sourcery'

" Nord color scheme
Plug 'arcticicestudio/nord-vim'

" Syntax analysis and fixing
Plug 'dense-analysis/ale'

" Quickstart config for the nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Telescope
" Telescope dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" Telescope itself
Plug 'nvim-telescope/telescope.nvim'

" fzf extension for fuzzy finding in Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" nvim abstraction for tree-sitter (parser generator)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Improve behaviour of built-in netrw
Plug 'tpope/vim-vinegar'

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gcmt/breeze.vim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'jwalton512/vim-blade'
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'voldikss/vim-floaterm'
