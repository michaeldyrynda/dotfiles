return {
    'ku1ik/vim-pasta',

    config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive', 'qf' }
    end,
}
