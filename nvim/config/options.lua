vim.o.colorcolumn = "120"
vim.o.completeopt = menuone,longest,preview
vim.o.mouse = ""
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes:2"
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.timeoutlen = 300
vim.o.updatetime = 300
vim.o.wildmode = "longest:full,full"

vim.o.autowriteall = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.backup = false
vim.o.showmode = false
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftround = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.title = true
vim.o.undofile = true
vim.o.wrap = false

vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})
