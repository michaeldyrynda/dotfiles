return {
    'nvim-lualine/lualine.nvim',

    lazy = false,

    dependencies = {
        'arkav/lualine-lsp-progress',
        'nvim-tree/nvim-web-devicons',
        'catppuccin/nvim',
    },

    config = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")

        require('lualine').setup({
        options = {
            section_separators = '',
            component_separators = '',
            globalstatus = true,
            theme = {
                normal = {
                    a = 'StatusLine',
                    b = 'StatusLine',
                    c = 'StatusLine',
                },
            },
        },
        sections = {
            lualine_a = {
                'mode',
            },
            lualine_b = {},
            lualine_c = {
                {
                    'buffers',
                    show_filename_only = false,
                    mode = 0,
                    buffers_color = {
                        active = { fg = colors.base, bg = colors.lavender, gui = 'bold' },
                        inactive = { fg = colors.overlay0, bg = colors.base },
                    },
                    symbols = {
                        modified = ' ●',
                        alternate_file = '',
                        directory = '',
                    },
                }
            },
            lualine_x = {
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = { fg = colors.peach },
                },
                {
                    'diff',
                    symbols = { added = '+', modified = '*', removed = '-' },
                },
                function ()
                    return '󰅭 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_clients())) or '')
                end,
                { 'diagnostics', sources = { 'nvim_diagnostic' } },
            },
            lualine_y = {
                'encoding',
                'fileformat',
                '(vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth',
                'branch',
            },
            lualine_z = {
                'location',
                'progress',
            },
        },
        })
    end,
}
