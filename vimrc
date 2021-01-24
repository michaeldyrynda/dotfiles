set rtp+=/usr/local/opt/fzf

set autoindent                                                                  "Preserve current indent on new lines
set smartindent                                                                 "Automatic indentation. See :help smartindent
set softtabstop=4                                                               "Number of spaces a tab counts as with si
set backspace=indent,eol,start                                                  "Make backspaces delete sensibly
set tabstop=4                                                                   "Indentation levels every four columns
set expandtab                                                                   "Convert all tabs typed to spaces
set shiftwidth=4                                                                "Indent/outdent by four columns
set shiftround                                                                  "Indent/outdent to nearest tabstop
set matchpairs+=<:>                                                             "Jump between pairs (%) command
set showmatch                                                                   "Briefly jump to matching bracket, one screen
set number                                                                      "Show line numbers
set relativenumber
set ruler                                                                       "Show line and column number of cursor pos
set nowrap                                                                      "Don't wrap long lines
set wildmenu                                                                    "Visual autocomplete for command menu
set autowriteall                                                                "Write files when switching buffers
set complete=.,w,b,u                                                            "Set the auto-complete buffer options
set nobackup                                                                    "Disable backup files
set noswapfile                                                                  "Disable swapfiles
set cursorline                                                                  "Display the cursor line
set noerrorbells                                                                "Disable error bells
set novisualbell                                                                "Disable visual bells
set t_vb=
set colorcolumn=120
let mapleader = ','                                                             "The default is \, but a comma is better
filetype plugin indent on                                                       "Enable file-type based indentation

"/
"/ Editor *********************************************************************
"/

set guioptions-=l                                                               "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

"/
"/ Greplace
"/
set grepprg=ag                                          "Use ag for search
let g:grep_cmd_opts = '--line-numbers --noheading'


"/
"/ Fix background breaking when scrolling in tmux session
"/
if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes work properly
    " when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

set t_Co=256                                                                    "Use 256 colours. Useful for terminal Vim.

"/
"/ Searching ******************************************************************
"/
set hlsearch                                                                    "Highlight all search pattern matches
set incsearch                                                                   "Match search pattern as it is typed
set ignorecase                                                                  "Always do a case-insensitive search
set smartcase                                                                   "Override ignorecase if uppercase chars present

"/
"/ Splits *********************************************************************
"/
set splitbelow
set splitright

" Simplify mappings for switching between splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L> 

"/
"/ Mappings *******************************************************************
"/

"Shortcut to edit vimrc
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Shortcut to edit PHP snippets
nmap <Leader>es :e ~/.vim/snippets/

"Remove highlighting
nmap <Leader><space> :nohlsearch<cr>

"Breeze jumping
nmap <Leader>s <Plug>(breeze-jump-attribute-forward)
nmap <Leader>S <Plug>(breeze-jump-attribute-backward)

"Delete all buffers
nmap <Leader>bda :bufdo bd <cr>

"Remap undo/redo
nmap <C-u> :undo<cr>
nmap <C-R> :redo<cr>

"Map moving current line
"Move current line up one
nmap <Leader><Leader>u :call feedkeys( line('.') == 1 ? '' : 'ddkP' )<cr>
"Move current line down one
nmap <Leader><Leader>d ddp

"Reload all snippets
nmap <Leader>ras :call ReloadAllSnippets()<cr>

"Remap emmet expansion trigger
imap <C-e> <plug>(emmet-expand-abbr)

"/
"/ Laravel-specific **********************************************************
"/
nmap <Leader>lr :vsp routes/<cr>
nmap <Leader>lrw :vsp routes/web.php<cr>
nmap <Leader>lra :vsp routes/api.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader><Leader>a :e app/<cr>
nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
nmap <Leader><Leader>v :e resources/views/<cr>
nmap <Leader><Leader>r :e resources/<cr>

"Toggle syntastic checking mode
nmap <Leader>st :SyntasticToggleMode<cr>

" Custom mapping to open Gstatus
nmap <Leader>gst :Gstatus<cr>

"/
"/ GitGutter
"/
"Ensure sign column background colour matches editor background
"Always display the sign column
set signcolumn=yes
let g:gitgutter_sign_allow_clobber = 1

"/
"/ Status bar *****************************************************************
"/
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
set laststatus=2
set showtabline=0

"/
"/ Syntastic ******************************************************************
"/
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{gutentags#statusline()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_phpmd_disable = 1

let g:PHP_noArrowMatching = 1

" Extract vundle configuration to separate file
so ~/.vim/plugins.vim
set termguicolors

colorscheme nord
syntax on

so ~/.vim/colors.vim

let g:prettier#autoformat = 0
nnoremap <Leader>gp :silent %!prettier --stdin-filepath %<CR>

" Auto-source .vimrc when saved ***********************************************
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc nested source %
augroup END

autocmd filetype crontab setlocal nobackup nowritebackup
autocmd! GUIEnter * set vb t_vb=

autocmd FileType php set iskeyword+=$
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
autocmd BufWritePost *.php nested set filetype=php
autocmd BufWritePost *.blade.php nested set filetype=blade

augroup WrapLineInMarkdown
    autocmd!
    autocmd FileType markdown setlocal wrap
augroup END

" Automatically rebalance windows when vim is resized
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Move highlighted block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
