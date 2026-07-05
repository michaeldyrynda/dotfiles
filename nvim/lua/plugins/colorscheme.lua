local tw_theme_path = vim.fn.expand("~/code/tw-theme")

local function has_tw_theme()
    return vim.uv.fs_stat(tw_theme_path .. "/lua/twtheme/init.lua") ~= nil
end

return {
    {
        dir = tw_theme_path,
        name = "tw-theme",
        priority = 1000,
        lazy = false,
        cond = has_tw_theme,

        config = function()
            require("twtheme").setup({
                variant = "dark", -- dark | dark-enhanced | light | light-enhanced
            })

            vim.cmd.colorscheme("tailwind-dark")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 900,
        lazy = false,
        cond = function()
            return not has_tw_theme()
        end,

        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
                custom_highlights = function(colors)
                    return {
                        -- Active tab/buffer highlighting
                        TabLineSel = { bg = colors.blue, fg = colors.base, style = { "bold" } },
                        TabLine = { bg = colors.mantle, fg = colors.subtext0 },
                        TabLineFill = { bg = colors.mantle },

                        -- Window separator colors (if using splits)
                        WinSeparator = { fg = colors.surface0 },

                        -- Lualine buffer icon highlighting
                        LualineBufferIconActive = { fg = colors.base, bg = colors.lavender, style = { "bold" } },
                    }
                end,
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
