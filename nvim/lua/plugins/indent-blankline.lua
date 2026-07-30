return {
    'lukas-reineke/indent-blankline.nvim',

    main = 'ibl',

    opts = {
        indent = {
            char = '▏',
            tab_char = '▏',
        },

        whitespace = {
            remove_blankline_trail = true
        },

        scope = {
            char = '▏',
            show_start = false,
        },

        exclude = {
            filetypes = {
                'help',
                'terminal',
                'dashboard',
                'packer',
                'lspinfo',
                'TelescopePrompt',
                'TelescopeResults',
            },
            buftypes = {
                'terminal',
            }
        },
    }
}
