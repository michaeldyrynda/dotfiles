"
" Mappings
"
let mapleader = ','

" Open nvim config
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<cr>

nmap <c-p> <cmd>Telescope find_files<cr>
nmap <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>gd :lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap <silent> <leader>a :lua require'telescope.builtin'.lsp_code_actions{}<cr>
nnoremap <silent> <leader>f :lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap <silent> <leader>r :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>

" LSP
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>

" Miscellaneous
nnoremap <silent> <leader><space> :nohlsearch<cr>

"
" Window 
"
" Cycle splits
nnoremap <tab> <c-w>w
nnoremap <s-tab> <c-w>W

" Splits
nmap <silent> <leader>v :vsplit<cr>
nmap <silent> <leader>h :split<cr>

" Resizing
autocmd VimResized * :wincmd =                  " Automatically resize splits when Vim is resized
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>  " Focus active split
nnoremap <leader>= :wincmd =<cr>                " Balance open splits

" Simplify split movement 
nmap <c-j> <c-w><c-j>
nmap <c-k> <c-w><c-k>
nmap <c-h> <c-w><c-h>
nmap <c-l> <c-w><c-l>


" Buffers
nmap <silent> <leader>bda :bufdo bd<cr>

"
" vim-test
"
nmap <leader>tn :w<cr>TestNearest<cr>
nmap <leader>tf :w<cr>TestFile<cr>
nmap <leader>ts :w<cr>TestSuite<cr>
nmap <leader>tl :w<cr>TestLast<cr>
nmap <leader>tv :w<cr>TestVisit<cr>

"
" Navigation
"
nnoremap <silent> <leader>j :m .+1<cr>==
nnoremap <silent> <leader>k :m .-2<cr>==
inoremap <silent> <leader>k <esc>:m .-2<cr>==gi
inoremap <silent> <leader>j <esc>:m .+1<cr>==gi

"
" Laravel
"
nmap <silent> <leader>lv :call LaravelGoToDefinition()<cr> " See config/laravel.vim

"
" UltiSnips
"
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"
" compe
"
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

"
" Plugins
"
nnoremap <buffer><nowait> <leader>pi <cmd>PlugInstall<cr>
nnoremap <buffer><nowait> <leader>pu <cmd>PlugUpdate<cr>
