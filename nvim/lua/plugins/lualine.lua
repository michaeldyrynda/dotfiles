return {
    'nvim-lualine/lualine.nvim',

    lazy = false,

    dependencies = {
        'arkav/lualine-lsp-progress',
        'nvim-tree/nvim-web-devicons',
    },

    opts = {
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
            lualine_b = {
                'branch',
                {
                    'diff',
                    symbols = { added = ' ', modified = ' ', removed = ' ' },
                },
                function ()
                    return '󰅭 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_clients())) or '')
                end,
                { 'diagnostics', sources = { 'nvim_diagnostic' } },
            },
            lualine_c = {
                {
                    'buffers',
                    show_filename_only = false,
                    mode = 0,
                    buffers_color = {
                        active = 'Delimiter',
                        inactive = 'Comment',
                    }
                }
            },
            lualine_x = {
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = { fg = "#ff9e64" },
                },
            },
            lualine_y = {
                'encoding',
                'fileformat',
                '(vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth',
            },
            lualine_z = {
                'location',
                'progress',
            },
        },
    },
}
