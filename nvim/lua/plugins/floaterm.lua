return {
    'voldikss/vim-floaterm',

    keys = {
        { '<Leader>ft', ':FloatermToggle<CR>' },
        { '<Leader>ft', '<Esc>:FloatermToggle<CR>', mode = 'i' },
        { '<Leader>ft', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
    },

    cmd = { 'FloatermToggle' },

    init = function()
        vim.g.floaterm_gitcommit = 'floaterm'
        vim.g.floaterm_autoinsert = 1
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
    end,
}
