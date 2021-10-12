local cmp = require('cmp') 

cmp.setup({
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = function (fallback)
            if cmp.visible() then
                cmp.next_select_item()
            else
                fallback()
            end
        end
    },

    documentation = {
        maxwidth = 120,
        maxheight = 180,
    },

    min_length = 1;
    preselect = true;

    sources = {
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'buffer', priority = 500 },
    },

    source = {
        sort = true;
        buffer = { sort = true; priority = 500; };
        nvim_lsp = { sort = false; priority = 1000; };
    };
})
