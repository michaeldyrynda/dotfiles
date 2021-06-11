--
-- LSP config
--
local lspconfig = require('lspconfig')

lspconfig.intelephense.setup { }

lspconfig.html.setup({
    filetypes = { 'html', 'blade' }
})
