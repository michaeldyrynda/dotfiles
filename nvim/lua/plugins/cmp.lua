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

                ['<C-o>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if cmp.visible_docs() then
                            cmp.close_docs()
                        else
                            cmp.open_docs()
                        end
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

            window = {
                completion = cmp.config.window.bordered({
                    col_offset = -3,
                    side_padding = 0,
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
                }),
                documentation = cmp.config.window.bordered({
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:CmpDocBorder',
                    max_width = 80,
                    max_height = 20,
                    position = 'below',
                }),
            },

            experimental = {
                ghost_text = false,
            },

            formatting = {
                fields = {"kind", "abbr", "menu"},

                format = function(entry, vim_item)
                    -- Custom icon mapping
                    local kind_icons = {
                        Text = "",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰇽",
                        Variable = "󰂡",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "󰅲",
                    }
                    
                    -- Set icon
                    vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
                    
                    local menu_text = ""
                    local item = entry.completion_item
                    
                    -- Show class path for LSP completions inline
                    if entry.source.name == 'nvim_lsp' then
                        menu_text = item.detail or ""
                        
                        -- Extract class path from "use Namespace\Class" statements
                        local class_path = menu_text:match("^use%s+([^;]+)")
                        if class_path then
                            -- Remove alias if present (e.g., "use Foo\Bar as Baz" -> "Foo\Bar")
                            menu_text = class_path:match("^(.-)%s+as%s+") or class_path
                        end
                        if menu_text ~= "" then
                            menu_text = " " .. menu_text
                        end
                    else
                        -- For non-LSP sources, show the source name
                        menu_text = " " .. (source_map[entry.source.name] or entry.source.name)
                    end
                    
                    vim_item.menu = menu_text
                    vim_item.menu_hl_group = 'SpecialComment'
                    
                    -- Color support for Tailwind
                    if entry.completion_item.kind == 15 and entry.completion_item.documentation then  -- 15 = Color
                        local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
                        if r then
                            local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
                            local group = 'Tw_' .. color
                            if vim.fn.hlID(group) < 1 then
                                vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                            end
                            vim_item.kind_hl_group = group
                        end
                    end

                    return vim_item
                end,
            },

            sorting = {
                comparators = {
                    -- Priority: Classes (7) > Methods (2) > Properties (10) > everything else > Buffer
                    function(entry1, entry2)
                        local kind_priority = {
                            [7] = 1,   -- Class
                            [2] = 2,   -- Method
                            [10] = 3,  -- Property
                            [5] = 3,   -- Field (treat as property)
                        }
                        
                        local kind1 = entry1:get_kind()
                        local kind2 = entry2:get_kind()
                        
                        local priority1 = kind_priority[kind1] or 4
                        local priority2 = kind_priority[kind2] or 4
                        
                        -- Buffer source always last
                        if entry1.source.name == 'buffer' then priority1 = 5 end
                        if entry2.source.name == 'buffer' then priority2 = 5 end
                        
                        if priority1 ~= priority2 then
                            return priority1 < priority2
                        end
                        return nil
                    end,
                    -- Sort alphabetically within each priority group
                    cmp.config.compare.sort_text,
                    cmp.config.compare.score,
                    cmp.config.compare.locality,
                    cmp.config.compare.order,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.offset,
                }
            },

            view = {
                entries = {
                    name = 'custom',
                    selection_order = 'near_cursor',
                },
                docs = {
                    auto_open = false,
                },
            },
        }

        -- Configure documentation window to show class info
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                { { name = 'path' } },
                { { name = 'cmdline' } }
            )
        })

        -- Set up highlight groups using Catppuccin Mocha colors
        local hl_groups = {
            -- Completion menu border - soft lavender
            CmpBorder = { fg = '#b4befe' },
            -- Documentation window border - soft pink  
            CmpDocBorder = { fg = '#f5c2e7' },
            -- Make Pmenu more distinct but still subtle
            Pmenu = { bg = '#1e1e2e', fg = '#cdd6f4' },
            PmenuSel = { bg = '#45475a', fg = '#cdd6f4', bold = true },
        }

        for name, opts in pairs(hl_groups) do
            vim.api.nvim_set_hl(0, name, opts)
        end
    end
}
