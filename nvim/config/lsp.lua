--
-- LSP config
--
local lspconfig = require('lspconfig')

lspconfig.intelephense.setup { }

lspconfig.vuels.setup { }

lspconfig.html.setup({
    cmd = { 'html-languageserver', '--stdio' },
    filetypes = { 'html', 'blade' }
})

lspconfig.tailwindcss.setup { }
