return {
    'saghen/blink.cmp',

    version = '1.*',

    dependencies = {
        'L3MON4D3/LuaSnip',
    },

    opts = {
        keymap = {
            preset = 'default',
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_down', 'fallback' },
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            ['<C-o>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        },

        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },

            menu = {
                border = 'rounded',
                winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
                draw = {
                    columns = {
                        { 'kind_icon' },
                        { 'label', 'label_description', gap = 1 },
                        { 'source_name' },
                    },
                    components = {
                        source_name = {
                            text = function(ctx)
                                if ctx.source_name == 'LSP' and ctx.item.detail and ctx.item.detail ~= '' then
                                    local detail = ctx.item.detail:gsub('\n', ' '):gsub('%s+', ' ')
                                    local class_path = detail:match("^use%s+([^;]+)")
                                    if class_path then
                                        return class_path:match("^(.-)%s+as%s+") or class_path
                                    end
                                    return detail
                                end
                                return ctx.source_name
                            end,
                            highlight = 'BlinkCmpSource',
                        },
                    },
                },
            },

            documentation = {
                auto_show = false,
                auto_show_delay_ms = 200,
                window = {
                    border = 'rounded',
                    winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder',
                },
            },

            ghost_text = {
                enabled = false,
            },
        },

        signature = {
            enabled = false,
        },

        snippets = {
            preset = 'luasnip',
        },

        sources = {
            default = { 'lsp', 'snippets', 'buffer', 'path' },
            providers = {
                buffer = {
                    score_offset = -3,
                },
            },
        },

        cmdline = {
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == '/' or type == '?' then
                    return { 'buffer' }
                end
                if type == ':' then
                    return { 'cmdline', 'path' }
                end
                return {}
            end,
        },

        appearance = {
            kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            },
        },
    },

    config = function(_, opts)
        require('blink.cmp').setup(opts)

        local palette = require("config.theme").palette()
        local colors = {
            fg = palette.fg,
            muted = palette.fg_muted,
            subtle = palette.fg_subtle,
            bg = palette.bg_float,
            bg_selected = palette.bg_line,
            border = palette.raw["input.border"] or palette.border,
            match = palette.syntax["string"],
            fn = palette.syntax["function"],
            type = palette.syntax["type"],
            keyword = palette.syntax["keyword"],
            constant = palette.syntax.constant,
            variable = palette.syntax.variable,
            operator = palette.syntax.operator,
        }

        local hl_groups = {
            BlinkCmpMenu = { fg = colors.fg, bg = colors.bg },
            BlinkCmpMenuBorder = { fg = colors.border, bg = colors.bg },
            BlinkCmpMenuSelection = { fg = colors.fg, bg = colors.bg_selected, bold = true },
            BlinkCmpScrollBarThumb = { bg = colors.border },
            BlinkCmpScrollBarGutter = { bg = colors.bg },
            BlinkCmpLabel = { fg = colors.fg },
            BlinkCmpLabelDeprecated = { fg = colors.muted, strikethrough = true },
            BlinkCmpLabelMatch = { fg = colors.match, bold = true },
            BlinkCmpLabelDetail = { fg = colors.muted },
            BlinkCmpLabelDescription = { fg = colors.muted },
            BlinkCmpSource = { fg = colors.muted },
            BlinkCmpGhostText = { fg = colors.muted, italic = true },
            BlinkCmpDoc = { fg = colors.fg, bg = colors.bg },
            BlinkCmpDocBorder = { fg = colors.border, bg = colors.bg },
            BlinkCmpSignatureHelp = { fg = colors.fg, bg = colors.bg },
            BlinkCmpSignatureHelpBorder = { fg = colors.border, bg = colors.bg },
            BlinkCmpSignatureHelpActiveParameter = { fg = colors.fn, bold = true },
            BlinkCmpKind = { fg = colors.fn },
            BlinkCmpKindText = { fg = colors.variable },
            BlinkCmpKindMethod = { fg = colors.fn },
            BlinkCmpKindFunction = { fg = colors.fn },
            BlinkCmpKindConstructor = { fg = colors.type },
            BlinkCmpKindField = { fg = colors.variable },
            BlinkCmpKindProperty = { fg = colors.variable },
            BlinkCmpKindVariable = { fg = colors.variable },
            BlinkCmpKindClass = { fg = colors.type },
            BlinkCmpKindInterface = { fg = colors.type },
            BlinkCmpKindStruct = { fg = colors.type },
            BlinkCmpKindEnum = { fg = colors.type },
            BlinkCmpKindEnumMember = { fg = colors.constant },
            BlinkCmpKindModule = { fg = colors.type },
            BlinkCmpKindKeyword = { fg = colors.keyword },
            BlinkCmpKindSnippet = { fg = colors.fn },
            BlinkCmpKindFile = { fg = colors.variable },
            BlinkCmpKindFolder = { fg = colors.fn },
            BlinkCmpKindValue = { fg = colors.constant },
            BlinkCmpKindUnit = { fg = colors.constant },
            BlinkCmpKindConstant = { fg = colors.constant },
            BlinkCmpKindColor = { fg = colors.constant },
            BlinkCmpKindOperator = { fg = colors.operator },
            BlinkCmpKindReference = { fg = colors.variable },
            BlinkCmpKindEvent = { fg = colors.fn },
            BlinkCmpKindTypeParameter = { fg = colors.type },
        }

        for name, hl_opts in pairs(hl_groups) do
            vim.api.nvim_set_hl(0, name, hl_opts)
        end
    end,
}
