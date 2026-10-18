return {
    'christoomey/vim-tmux-navigator',

    -- Rex handles this itself, see mappings.lua
    cond = vim.env.TMUX ~= nil,
}
