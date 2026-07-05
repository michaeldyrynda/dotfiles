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

config = function (plugin, opts)
        -- `nvim-treesitter` on its `main` branch ships queries under
        -- `runtime/queries/` rather than the modern `queries/` directory
        -- that Neovim 0.10+ searches via runtimepath. Prepend that
        -- `runtime/` directory so the queries become discoverable.
        local runtime_dir = plugin.dir .. '/runtime'
        if vim.uv.fs_stat(runtime_dir) and not vim.tbl_contains(vim.opt.rtp:get(), runtime_dir) then
            vim.opt.rtp:prepend(runtime_dir)
        end

        require('nvim-treesitter.config').setup(opts)

        -- The `main` branch no longer reliably starts highlight modules from
        -- the legacy `highlight.enable` option alone. Start Neovim's native
        -- highlighter for each buffer so normal buffers get the same
        -- Treesitter captures that preview windows use.
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not lang then
                    return
                end

                pcall(vim.treesitter.start, args.buf, lang)
            end,
        })

        require('treesitter-context').setup(opts.context)
    end
}
