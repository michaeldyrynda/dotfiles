return {
    "catppuccin/nvim",

    name = "catppuccin",
    priority = 1000,

    config = function (plugin, opts)
        require('catppuccin').setup({
            flavor = "mocha"
        })

        vim.cmd('colorscheme catppuccin')
    end
}
