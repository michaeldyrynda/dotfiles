return {
    'tpope/vim-commentary',

    config = function()
        -- Maintain cursor position
        vim.keymap.set('n', 'gcap', 'my<cmd>norm vip<bar>gc<cr>`y')
        vim.keymap.set('n', '<leader>c >', 'gcc<cr>')
    end,
}
