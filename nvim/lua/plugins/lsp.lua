return {
    'neovim/nvim-lspconfig',

    event = 'VeryLazy',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
    },

    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup({
            ui = {
                height = 0.8,
            },
        })

        require('mason-lspconfig').setup({ automatic_installation = true })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        require('lspconfig').bashls.setup({
            capabilities = capabilities,
        })

        require('lspconfig').emmet_ls.setup({
            capabilities = capabilities,
        })

        require('lspconfig').intelephense.setup({
            commands = {
                IntelephenseIndex = {
                    function()
                        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
                    end,
                },
            },

            settings = {
                intelephense = {
                    telemetry = {
                        enabled = false
                    },
                    files = {
                        maxSize = 5000000
                    }
                },
                environment = {
                    phpVersion = '8.4.4'
                }
            },
        })

        -- Vue, JavaScript, TypeScript
        require('lspconfig').volar.setup({
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,

            capabilities = capabilities,
        })

        require('lspconfig').ts_ls.setup({
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                        languages = {"javascript", "typescript", "vue"},
                    },
                },
            },

            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
            },
        })

        -- Tailwind CSS
        require('lspconfig').tailwindcss.setup({
            capabilities = capabilities
        })

        -- JSON
        require('lspconfig').jsonls.setup({
            capabilities = capabilities,

            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                },
            },
        })

        -- Lua
        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            '${3rd}/luv/library',
                            unpack(vim.api.nvim_get_runtime_file('', true)),
                        },
                    }
                }
            }
        })

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = false,

            float = {
                source = true,
            }
        })

        -- Sign configuration
        vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    end
}
