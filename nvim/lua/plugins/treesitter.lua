local t

return {
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',
    branch = 'main',
    lazy = false,

    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
        'nvim-treesitter/nvim-treesitter-context',
        { 'JoosepAlviste/nvim-ts-context-commentstring', branch = 'main' },
    },

    opts = {
        ensure_installed = 'all',
        ignore_install = {'phpdoc'},

        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["iC"] = "@class.inner",
                    ["aC"] = "@class.outer",
                    ["if"] = "@function.inner",
                    ["af"] = "@function.outer",
                    ['ic'] = '@conditional.inner',
                    ['ac'] = '@conditional.outer',
                    ['il'] = '@loop.inner',
                    ['al'] = '@loop.outer',
                    ['ia'] = '@parameter.inner', -- a for argument because p is paragraph
                    ['aa'] = '@parameter.outer',
                    ['ih'] = '@attribute.inner', -- `h` for html, because `a` is argument above
                    ['ah'] = '@attribute.outer',
                },

                selection_modes = {
                    ['@class.inner'] = 'V',
                    ['@class.outer'] = 'V',
                    ['@function.inner'] = 'V',
                    ['@function.outer'] = 'V',
                    ['@conditional.inner'] = 'V',
                    ['@conditional.outer'] = 'V',
                    ['@loop.inner'] = 'V',
                    ['@loop.outer'] = 'V',
                    ['@statement.outer'] = 'V',
                },
            },
        },

        context = {
            enable = false,
            mode = 'topline',
            multiwindow = true,
            multiline_threshold = 1,
            separator = '0',
        },
    },

    config = function (_, opts)
        require('nvim-treesitter.config').setup(opts)
        require('treesitter-context').setup(opts.context)
    end
}
