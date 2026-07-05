return {
    'nvim-lualine/lualine.nvim',

    lazy = false,

    dependencies = {
        'arkav/lualine-lsp-progress',
        'nvim-tree/nvim-web-devicons',
    },

    config = function()
        local colors = require("config.theme").palette()

        require('lualine').setup({
        options = {
            section_separators = '',
            component_separators = '',
            globalstatus = true,
            theme = {
                normal = {
                    a = { fg = colors.fg, bg = colors.bg_statusline, gui = 'bold' },
                    b = { fg = colors.fg_alt, bg = colors.bg_statusline },
                    c = { fg = colors.fg_alt, bg = colors.bg_statusline },
                },
                inactive = {
                    a = { fg = colors.fg_muted, bg = colors.bg_statusline },
                    b = { fg = colors.fg_muted, bg = colors.bg_statusline },
                    c = { fg = colors.fg_muted, bg = colors.bg_statusline },
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
                        active = { fg = colors.fg, bg = colors.bg_line, gui = 'bold' },
                        inactive = { fg = colors.fg_muted, bg = colors.bg_statusline },
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
                    color = { fg = colors.diag.warning, bg = colors.bg_statusline },
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
