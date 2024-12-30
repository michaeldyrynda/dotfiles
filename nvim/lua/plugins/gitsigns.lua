return {
    'lewis6991/gitsigns.nvim',

    lazy = false,

    opts = {
        signs = {
            add          = { text = '▎' },
            change       = { text = '▎' },
            untracked    = { text = '▎' },
        }
    },

    keys = {
        { ']h', function () require('gitsigns').next_hunk() end },
        { '[h', function () require('gitsigns').prev_hunk() end },
    },
}
