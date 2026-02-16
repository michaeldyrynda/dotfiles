return {
    'neovim/nvim-lspconfig',

    event = 'VeryLazy',

    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
    },

    config = function()
        -- Setup Mason to automatically install LSP servers
        vim.lsp.config('mason', {
            ui = {
                height = 0.8,
            },
        })

        vim.lsp.config('mason-lspconfig', {
            automatic_installation = true,
            automatic_enable = {
                exclude = {
                    "phpactor",
                    "intelephense"
                }
            }
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        vim.lsp.config('bashls', {
            capabilities = capabilities,
        })

        vim.lsp.config('emmet_ls', {
            capabilities = capabilities,
        })

        vim.lsp.config('intelephense', {
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
        vim.lsp.config('vue_ls', {
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,

            capabilities = capabilities,
        })

        vim.lsp.config('ts_ls', {
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
        vim.lsp.config('tailwindcss', {
            capabilities = capabilities
        })

        -- JSON
        vim.lsp.config('jsonls', {
            capabilities = capabilities,

            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true }
                },
            },
        })

        -- Lua
        vim.lsp.config('lua_ls', {
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

        -- Go
        vim.lsp.config('gopls', {
            capabilities = capabilities
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

        vim.lsp.enable('mason')
        vim.lsp.enable('mason-lspconfig')
        vim.lsp.enable('bashls')
        vim.lsp.enable('emmet_ls')
        vim.lsp.enable('intelephense')
        vim.lsp.enable('vue_ls')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('jsonls')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('gopls')
    end
}
