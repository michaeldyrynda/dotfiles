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
        vim.g.floaterm_borderchars = '─│─│┌┐┘└'
        vim.g.floaterm_title = ''
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_position = 'center'

        -- Match telescope colors
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = '*',
            callback = function()
                local catppuccin = require('catppuccin.palettes').get_palette('mocha')
                vim.api.nvim_set_hl(0, 'Floaterm', { bg = catppuccin.base })
                vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = catppuccin.base, fg = catppuccin.surface0 })
            end,
        })
    end,
}
