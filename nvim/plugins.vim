"
" Installed plugins
"

" Simplify management of vim configuration (https://github.com/jesseleite/vim-sourcery)
Plug 'jesseleite/vim-sourcery'

" nvim abstraction for tree-sitter (parser generator)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Syntax analysis and fixing
Plug 'dense-analysis/ale'

" Quickstart config for the nvim LSP client
Plug 'neovim/nvim-lspconfig' | Plug 'b0o/schemastore.nvim' | Plug 'folke/lsp-colors.nvim'

" Telescope
" Telescope dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" Telescope itself
Plug 'nvim-telescope/telescope.nvim'

" Improve behaviour of built-in netrw
Plug 'tpope/vim-vinegar'

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gcmt/breeze.vim'
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-surround'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'jwalton512/vim-blade'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'voldikss/vim-floaterm'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'michaeldyrynda/carbon'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'vim-vdebug/vdebug'
Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch' " Adds :Rename, :SudoWrite
Plug 'tpope/vim-sleuth' " Indent autodetection with editorconfig support
Plug 'jessarcher/vim-heritage' 
Plug 'nelstrom/vim-visual-star-search'
Plug 'sickill/vim-pasta'
Plug 'famiu/bufdelete.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'akinsho/bufferline.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'weilbith/nvim-code-action-menu'
Plug 'johmsalas/text-case.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'onsails/lspkind-nvim'
Plug 'folke/trouble.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'jessarcher/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'windwp/nvim-autopairs'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
