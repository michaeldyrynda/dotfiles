local cmp = require('cmp') 

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
    },

    documentation = {
        maxwidth = 120,
        maxheight = 180,
    },

    min_length = 1;
    preselect = true;

    sources = {
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'buffer', priority = 500, keyword_length = 5 },
        { name = 'ultisnips' },
    }
})
