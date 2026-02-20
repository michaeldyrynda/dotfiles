return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
        'adibhanna/laravel.nvim',
    },

    config = function ()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local source_map = {
            laravel = "Laravel",
            buffer = "Buffer",
            nvim_lsp = "LSP",
            nvim_lsp_signature_help = "Signature",
            luasnip = "LuaSnip",
            nvim_lua = "Lua",
            path = "Path",
        }

        cmp.setup {
            preselect = false,

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-u>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    elseif has_words_before() then
                        cmp.complete()
                        print('complete...')
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            sources = {
                { name = 'laravel' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },

            formatting = {
                fields = {"kind", "abbr", "menu"},

                format = lspkind.cmp_format({
                    mode = 'symbol',

                    -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
                    before = function(entry, vim_item)
                        local menu_text = ""
                        local item = entry.completion_item
                        
                        -- Show class path for LSP completions
                        if entry.source.name == 'nvim_lsp' then
                            menu_text = item.detail or ""
                            -- Extract class path from "use Namespace\Class" statements
                            local class_path = menu_text:match("^use%s+([^;]+)")
                            if class_path then
                                menu_text = class_path
                            end
                            if menu_text ~= "" then
                                menu_text = "  " .. menu_text
                            end
                        else
                            -- For non-LSP sources, show the source name
                            menu_text = "  " .. (source_map[entry.source.name] or entry.source.name)
                        end

                        vim_item.menu = menu_text
                        vim_item.menu_hl_group = 'SpecialComment'

                        if vim_item.kind == 'Color' and entry.completion_item.documentation then
                            local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
                            if r then
                                local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
                                local group = 'Tw_' .. color
                                if vim.fn.hlID(group) < 1 then
                                    vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                                end
                                vim_item.kind_hl_group = group
                                return vim_item
                            end
                        end

                        return vim_item
                    end
                }),
            },

            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.locality,
                    cmp.config.compare.order,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.offset,
                }
            },
        }
    end
}
