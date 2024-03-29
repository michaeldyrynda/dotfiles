--
-- LSP config
--
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        source = true,
        focus = false,
    }
})

lspconfig.bashls.setup({
  capabilities = capabilities,
})

lspconfig.emmet_ls.setup({
  capabilities = capabilities,
})

lspconfig.intelephense.setup({ 
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    capabilities = capabilities,
    settings = {
        intelephense = {
            diagnostics = {
                enable = true
            }
        }
    }
})

lspconfig.vuels.setup {
    capabilities = capabilities,
}

lspconfig.sqlls.setup {
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

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
