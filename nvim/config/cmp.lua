local cmp = require('cmp') 
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local compare = require('cmp.config.compare')


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = '[LSP]',
                buffer = '[BUF]',
            },
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

    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    snippet = {
        expand = function (args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    sources = {
        { name = 'gh_issues', priority = 60 },
        { name = 'nvim_lsp', priority = 50 },
        { name = 'nvim_lsp_signature_help', priority = 40 },
        { name = 'luasnip', priority = 30 },
        { name = 'path', priority = 20 },
        { name = 'buffer', priority = 10 },
    }
})

require('luasnip/loaders/from_vscode').load({
    paths = {
        "./luasnip"
    },
})
