--
-- LSP config
--
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.intelephense.setup { 
    capabilities = capabilities,
}

lspconfig.vuels.setup {
    capabilities = capabilities,
}

lspconfig.html.setup({
    cmd = { 'html-languageserver', '--stdio' },
    filetypes = { 'html', 'blade' },
    capabilities = capabilities,
})

lspconfig.tailwindcss.setup {
    capabilities = capabilities,
}
