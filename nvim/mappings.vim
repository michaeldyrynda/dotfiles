"
" Mappings
"
let mapleader = ','

"
" nvim
"
nmap <silent> <leader>ev :tabnew ~/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>en :lua require'telescope.builtin'.edit_vim{}<cr>
nnoremap <silent> <leader>ed :lua require'telescope.builtin'.dotfiles{}<cr>
nnoremap <leader>ft :FloatermNew<cr>

"
" Top mappings via https://www.youtube.com/watch?v=hSHATqh8svM
"
" Make Y behave like C, and D (yank to end of line)
nnoremap Y y$

" Keep search results centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Keep cursor in place when joining lines
nnoremap J mzJ`z

" Tabs
nmap <silent> <leader>tL :tabnext<cr>
nmap <silent> <leader>tH :tabprevious<cr>
nmap <leader>tN :tabnew 
nmap <silent> <leader>tC :tabclose<cr>

" Telescope
nmap <c-p> <cmd>Telescope find_files<cr>
nmap <leader>b <cmd>Telescope buffers<cr>
nmap <leader>lg <cmd>Telescope live_grep<cr>
nmap <leader>fb <cmd>Telescope current_buffer_fuzzy_find<cr>

" LSP
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>sr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a <cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>
nnoremap <silent> <leader>gd <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap <silent> <leader>gt <cmd>lua require'telescope.builtin'.lsp_type_definitions{}<cr>
nnoremap <silent> <leader>gi <cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap <silent> <leader>fr <cmd>lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap <silent> <leader>f <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap <silent> <leader>r <cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>
nnoremap <silent> <leader>dg <cmd>lua require'telescope.builtin'.lsp_document_diagnostics{}<cr>

" Miscellaneous
nnoremap <silent> <leader><space> :nohlsearch<cr>

"
" Window 
"
" Splits
nmap <silent> <leader>v :vsplit<cr>
nmap <silent> <leader>h :split<cr>

" Resizing
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
nmap <silent> <leader>tn :w<cr>:TestNearest<cr>
nmap <silent> <leader>tf :w<cr>:TestFile<cr>
nmap <silent> <leader>ts :w<cr>:TestSuite<cr>
nmap <silent> <leader>tl :w<cr>:TestLast<cr>
nmap <silent> <leader>tv :w<cr>:TestVisit<cr>

"
" Navigation
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
inoremap <C-j> :m .+1<cr>==
inoremap <C-k> :m .-2<cr>==
nnoremap <leader>j :m .+1<cr>==
nnoremap <leader>k :m .-2<cr>==

"
" Laravel
"
nmap <silent> <leader>lv :call LaravelGoToDefinition()<cr> " See config/laravel.vim
nmap <leader>lm :!php artisan make:
nmap <leader>pt :!php artisan pest:test 
nmap <leader>rw :vsp routes/web.php<cr>

"
" Plugins
"
nnoremap <buffer><nowait> <leader>pi <cmd>PlugInstall<cr>
nnoremap <buffer><nowait> <leader>pu <cmd>PlugUpdate<cr>
