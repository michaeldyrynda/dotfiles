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

        local function apply_floaterm_colors()
            local colors = require('config.theme').palette()

            vim.api.nvim_set_hl(0, 'Floaterm', { fg = colors.fg, bg = colors.bg })
            vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = colors.bg, fg = colors.border })
        end

        -- Match telescope/editor colors.
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = '*',
            callback = apply_floaterm_colors,
        })

        apply_floaterm_colors()
    end,
}
