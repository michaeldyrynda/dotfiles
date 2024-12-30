return {
    'lukas-reineke/indent-blankline.nvim',

    main = 'ibl',

    opts = {
        whitespace = {
            remove_blankline_trail = true
        },

        scope = {
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
