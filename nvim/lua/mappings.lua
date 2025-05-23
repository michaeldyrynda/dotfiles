--
-- Mappings
--

vim.keymap.set('n', '-', '<cmd>Oil<cr>', {desc = 'Open parent directory'})

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
vim.keymap.set('n', '-', '<cmd>Oil<cr>')

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
vim.keymap.set('n', '<leader>bda', ':bufdo bd<cr>') -- Destroy all buffers

--
-- LSP
--
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { silent = true })
vim.keymap.set('n', '<leader>sr', '<cmd>lua vim.lsp.buf.rename()<cr>', { silent = true })
vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', { silent = true })
vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>", { silent = true })
vim.keymap.set('n', '<leader>gv', "<cmd>lua require'telescope.builtin'.lsp_definitions{ jump_type = 'vsplit' }<cr>", { silent = true })
vim.keymap.set('n', '<leader>gt', "<cmd>lua vim.lsp.buf.type_definition()<cr>", { silent = true })
vim.keymap.set('n', '<leader>gi', "<cmd>lua vim.lsp.buf.implementation()<cr>", { silent = true })
vim.keymap.set('n', '<leader>fr', ":Telescope lsp_references<CR>", { silent = true })
vim.keymap.set('n', '<leader>f', "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>fm', "<cmd>lua require'telescope.builtin'.lsp_document_symbols{ symbols = 'method' }<cr>", { silent = true })
vim.keymap.set('n', '<leader>r', "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>", { silent = true })
vim.keymap.set('n', '<leader>dg', '<cmd>lua vim.diagnostic.open_float()<cr>', { silent = true })

--
-- Laravel
--
vim.keymap.set('n', '<leader>lm', ':!php artisan make:')
vim.keymap.set('n', '<leader>rw', ':vsp routes/web.php<cr>')
vim.keymap.set('n', '<leader>ra', ':vsp routes/api.php<cr>')

--
-- Trouble
--
vim.keymap.set('n', '<leader>tt', ':TroubleToggle<cr>')

--
-- Plugins
--
vim.keymap.set('n', '<leader>pi', '<cmd>Lazy install<cr>', { buffer = true, nowait = true })
vim.keymap.set('n', '<leader>pu', '<cmd>Lazy update<cr>', { buffer = true, nowait = true })

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

--
-- Git
--
vim.keymap.set('n', '<leader>gb', ':Git blame<cr>');
vim.keymap.set('i', '<leader>gb', ':Git blame<cr>');
vim.keymap.set('n', '<leader>gco', ':Git checkout %<cr>:e %<cr>');

hidden_all = false

local function hide_all_chrome()
  if not hidden_all then
    hidden_all = true
    vim.o.number = false
    vim.o.ruler = false
    vim.o.relativenumber = false
    vim.o.laststatus = 0
    vim.o.signcolumn = "yes:1"
    vim.o.colorcolumn = "0"
    vim.o.cursorline = false

    require('gitsigns').detach()
    require('treesitter-context').disable()
    require('ibl').update {enabled = false}
  else
    hidden_all = false
    vim.o.number = true
    vim.o.ruler = true
    vim.o.relativenumber = true
    vim.o.laststatus = 3
    vim.o.signcolumn = "yes:2"
    vim.o.colorcolumn = "120"
    vim.o.cursorline = true

    require('gitsigns').attach()
    require('treesitter-context').enable()
    require('ibl').update {enabled = true}
  end
end

vim.keymap.set('n', '<leader>ha', hide_all_chrome, {noremap = true})
