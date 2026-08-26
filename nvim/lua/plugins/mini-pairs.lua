return {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    config = function()
        require('mini.pairs').setup({
            mappings = {
                ['`'] = { neigh_pattern = '[^\\`].' },
            },
        })

        local open_pairs = { ['{'] = '}', ['('] = ')', ['['] = ']' }
        vim.keymap.set('i', '<CR>', function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local before = line:sub(col, col)
            local after = line:sub(col + 1, col + 1)

            if open_pairs[before] == after then
                return vim.api.nvim_replace_termcodes('<CR><Esc>==ko', true, false, true)
            end

            return require('mini.pairs').cr()
        end, { expr = true, replace_keycodes = false })
    end,
}
