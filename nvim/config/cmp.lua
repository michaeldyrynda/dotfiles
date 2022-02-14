local cmp = require('cmp') 
local luasnip = require('luasnip')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    experimental = {
        ghost_text = true,
    },

    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    documentation = {
        maxwidth = 120,
        maxheight = 180,
    },

    min_length = 1;
    preselect = true;

    snippet = {
        expand = function (args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    sources = {
        { name = 'gh_issues', priority = 1050 },
        { name = 'luasnip', priority = 1025 },
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'path', priority = 750 },
        { name = 'buffer', priority = 500 },
    }
})

require('luasnip/loaders/from_vscode').load({
    paths = {
        "./luasnip"
    },
})
