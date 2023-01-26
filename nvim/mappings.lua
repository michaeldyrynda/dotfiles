--
-- Mappings
--
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Improve movement of wrapped text, by moving by terminal rows, rather than lines
-- If a count is provided, this will move by the number of lines as per normal.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

--
-- nvim mappings
-- 
vim.keymap.set('n', '<leader>ev', ':tabnew ~/.config/nvim/init.vim<cr>', { silent = true })
vim.keymap.set('n', '<leader>en', ":lua require'telescope.builtin'.edit_vim{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>ed', ":lua require'telescope.builtin'.dotfiles{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>ft', ':FloatermToggle scratch<cr>')
vim.keymap.set('t', '<leader>ft', '<C-\\><C-n>:FloatermToggle scratch<CR>')

--
-- Buffers
--
vim.keymap.set('n', '<leader>w', ':w<cr>')      -- write current buffer
vim.keymap.set('n', '<leader>wa', ':wa<cr>')    -- write all buffers
vim.keymap.set('n', '<leader>x', ':x<cr>')      -- write and close
vim.keymap.set('n', '<leader>q', ':q<cr>')      -- exit vim
vim.keymap.set('i', 'jw', '<esc>:w<cr>a')       -- write the current buffer from insert mode

-- 
-- Navigation
--
vim.keymap.set('v', 'J', ':m +1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m -2<cr>gv=gv')
vim.keymap.set('i', '<C-j>', '<esc>:m .+1<cr>==gi')
vim.keymap.set('i', '<C-k>', '<esc>:m .-2<cr>==gi')
vim.keymap.set('n', '<leader>j', ':m .+1<cr>==')
vim.keymap.set('n', '<leader>k', ':m .-2<cr>==')

-- 
-- Splits
--
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')

-- 
-- Buffers
--
vim.keymap.set('n', '<leader>bd', ':Bdelete<cr>')   -- Destroy current buffer
vim.keymap.set('n', '<leader>bda', ':bufdo bd<cr>') -- Destroy all buffers

--
-- Telescope
--
vim.keymap.set('n', '<c-p>', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<c-p><c-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>lg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_finder<cr>')

-- 
-- LSP
--
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { silent = true })
vim.keymap.set('n', '<leader>sr', '<cmd>lua vim.lsp.buf.rename()<cr>', { silent = true })
vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', { silent = true })
vim.keymap.set('n', '<leader>gd', "<cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>gv', "<cmd>lua require'telescope.builtin'.lsp_definitions{ jump_type = 'vsplit' }<cr>", { silent = true })
vim.keymap.set('n', '<leader>gt', "<cmd>lua require'telescope.builtin'.lsp_type_definitions{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>gi', "<cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>fr', "<cmd>lua require'telescope.builtin'.lsp_references{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>f', "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>fm', "<cmd>lua require'telescope.builtin'.lsp_document_symbols{ symbols = 'method' }<cr>", { silent = true })
vim.keymap.set('n', '<leader>r', "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>dg', '<cmd>lua vim.diagnostic.open_float()<cr>', { silent = true })

--
-- PhpActor
--
vim.keymap.set('n', '<leader>p', ':call phpactor#ContextMenu()<cr>', { silent = true })                             -- Open PhpActor context menu
vim.keymap.set('n', '<leader>u', ':call phpactor#ImportClass()<cr>', { silent = true })                             -- Import class under cursor
vim.keymap.set('n', '<leader>ec', ':call phpactor#ExtractConstant()<cr>', { silent = true })                        -- Extract a constant
vim.keymap.set('x', '<leader>ee', ':<c-u>call phpactor#ExtractExpression(visualmode())<cr>', { silent = true })     -- Extract an expression (variable)
vim.keymap.set('x', '<leader>em', ':<c-u>call phpactor#ExtractMethod(visualmode())<cr>', { silent = true })         -- Extract a method
vim.keymap.set('n', '<leader>cm', ':call phpactor#MoveFile()<cr>', { silent = true })                               -- Move a file
vim.keymap.set('n', '<leader>cn', ':call phpactor#ClassNew()<cr>', { silent = true })                               -- Create a new class

--
-- vim-test
--
vim.keymap.set('n', '<leader>tn', ':w<cr>:TestNearest<cr>', { silent = true })
vim.keymap.set('n', '<leader>tf', ':w<cr>:TestFile<cr>', { silent = true })
vim.keymap.set('n', '<leader>ts', ':w<cr>:TestSuite<cr>', { silent = true })
vim.keymap.set('n', '<leader>tl', ':w<cr>:TestLast<cr>', { silent = true })
vim.keymap.set('n', '<leader>tv', ':w<cr>:TestVisit<cr>', { silent = true })

-- 
-- Laravel
--
vim.keymap.set('n', '<leader>lm', ':!php artisan make:')
vim.keymap.set('n', '<leader>rw', ':vsp routes/web.php<cr>')
vim.keymap.set('n', '<leader>ra', ':vsp routes/api.php<cr>')

--
-- Plugins
--
vim.keymap.set('n', '<leader>pi', '<cmd>PlugInstall<cr>', { buffer = true, nowait = true })
vim.keymap.set('n', '<leader>pu', '<cmd>PlugUpdate<cr>', { buffer = true, nowait = true })

--
-- Miscellaneous
--
vim.keymap.set('n', 'p', 'p=`]')                                -- Corrects bad indenting when pasting
vim.keymap.set('i', ';;', '<esc>A;')                            -- Append a semicolon to the end of the line
vim.keymap.set('i', ',,', '<esc>A,')                            -- Append a comma to the end of the line
vim.keymap.set('n', 'Y', 'y$')                                  -- Make Y behave like C and D (yank to end of line) /ht @ThePrimeagen 
vim.keymap.set('n', 'n', 'nzzzv')                               -- Keep search results centred (forwards)...
vim.keymap.set('n', 'N', 'Nzzzv')                               -- ...and backwards
vim.keymap.set('n', 'J', 'mzJ`z')                               -- Keep cursor in place when joining lines (rather than jumping to end)
vim.keymap.set('v', 'y', 'myy`y')                               -- Keep cursor in place when yanking in visual mode
vim.keymap.set('v', 'p', '"_dP')                                -- Replace visual selection without copying it
vim.keymap.set('n', '<leader><space>', ':nohlsearch<cr>')       -- Stop search highlighting
vim.keymap.set('n', '<leader>v', ':vsplit<cr>')                 -- Vertical split
vim.keymap.set('n', '<leader>h', ':split<cr>')                  -- Horizontal split
vim.keymap.set('n', '<leader>-', ':wincmd _<cr>:wincmd |<cr>')  -- Focus active split
vim.keymap.set('n', '<leader>=', ':wincmd =<cr>')               -- Balance open splits
