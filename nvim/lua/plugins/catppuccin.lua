return {
    "catppuccin/nvim",

    name = "catppuccin",
    priority = 1000,

    config = function (plugin, opts)
        require('catppuccin').setup({
            flavor = "mocha",
            custom_highlights = function(colors)
                return {
                    -- Active tab/buffer highlighting
                    TabLineSel = { bg = colors.blue, fg = colors.base, style = { "bold" } },
                    TabLine = { bg = colors.mantle, fg = colors.subtext0 },
                    TabLineFill = { bg = colors.mantle },

                    -- Window separator colors (if using splits)
                    WinSeparator = { fg = colors.surface0 },
                }
            end
        })

        vim.cmd('colorscheme catppuccin')
    end
}
