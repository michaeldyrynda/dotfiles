--
-- Options
--
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.markdown_recommended_style = 0

-- LazyVim autoformat
vim.g.autoformat = true

vim.o.autowrite = true
vim.o.backup = false
vim.o.colorcolumn = "120"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.laststatus = 3 -- global statusline
vim.o.list = true
vim.o.mouse = ""
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false -- disable default ruler
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.sidescrolloff = 8
vim.o.showmatch = true
vim.o.showmode = false
vim.o.signcolumn = "yes:2"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.smoothscroll = true
vim.o.splitbelow = true -- put new horizontal splits below
vim.o.splitright = true -- put new vertical splits to the right
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200 -- update swapfile and trigger CursorHold
vim.o.wildmode = "longest:full,full" -- command line completion mode
vim.o.wrap = false -- disable line wrap

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})
