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

lspconfig.phpactor.setup {
    capabilities = capabilities,

    on_attach = function(client, bufnr)
        client.server_capabilities.completionProvider = false
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.implementationProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.selectionRangeProvider = false
        client.server_capabilities.signatureHelpProvider = false
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.workspaceSymbolProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.documentHighlightProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,

    init_options = {
        ["language_server_worse_reflection.inlay_hints.enable"] = true,
        ["language_server_worse_reflection.inlay_hints.params"] = true,
        ["language_server_worse_reflection.inlay_hints.types"] = false,
    },

    handlers = {
        ['textDocument/publishDiagnostics'] = function() end
    }
}

lspconfig.vuels.setup {
    capabilities = capabilities,
}

lspconfig.ts_ls.setup ({
    capabilities = capabilities,

    root_dir = function(...)
        return require("lspconfig.util").root_pattern(".git")(...)
    end,
    single_file_support = false,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
})

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
