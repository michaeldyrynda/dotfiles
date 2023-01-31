local fg = '#C9CCCD'
local bg = '#082F3B'
local separator = '#'

local colors = {
    color0 = '#D0D6B5',
    color1 = '#172030',
    color2 = '#FFAE8F',
    color3 = '#B87EA2',
    color4 = '#1E2A3E',
    color5 = '#4B2234',
    color6 = '#73A7A7',
}

require('lualine').setup {
    options = {
        globalstatus = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        theme = 'nord',
    },
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = {
            'branch',
            'diff',
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
        },
        lualine_c = { 
            'filename', 
        },
        lualine_x = {
            'filetype',
            'encoding',
            'fileformat',
        },
        lualine_y = {
            '(vim.bo.expandtab and "●" or "⇥ ") .. " " .. vim.bo.shiftwidth',
        },
        lualine_z = {
            'location',
            'progress',
        },
    },
}
