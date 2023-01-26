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
        format = function (diagnostic)
            if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
                return string.format('%s: %s', diagnostic.user_data.lsp.code, diagnostic.message)
            end
            return diagnostic.message
        end,
    }
})

lspconfig.intelephense.setup({ 
    capabilities = capabilities,
})

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
