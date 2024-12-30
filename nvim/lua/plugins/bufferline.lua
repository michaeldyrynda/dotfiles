local inactiveBg = {
    bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
}

return {
    'akinsho/bufferline.nvim',

    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    options = {
        indicator = {
            style = 'none',
            icon = ' ',
        },
        show_close_icon = false,
        tab_size = 0,
        max_name_length = 25,
        separator_style = 'slope',
        custom_areas = {
            left = function()
                return {
                    { text = '    ', fg = '#8fff6d' },
                }
            end,
        },
    },

    highlights = {
        fill = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        background = inactiveBg,
        close_button = inactiveBg,
        diagnostic = inactiveBg,
        diagnostic_visible = inactiveBg,
        modified = inactiveBg,
        modified_visible = inactiveBg,
        hint = inactiveBg,
        hint_visible = inactiveBg,
        info = inactiveBg,
        info_visible = inactiveBg,
        warning = inactiveBg,
        warning_visible = inactiveBg,
        error = inactiveBg,
        error_visible = inactiveBg,
        hint_diagnostic = inactiveBg,
        hint_diagnostic_visible = inactiveBg,
        info_diagnostic = inactiveBg,
        info_diagnostic_visible = inactiveBg,
        warning_diagnostic = inactiveBg,
        warning_diagnostic_visible = inactiveBg,
        error_diagnostic = inactiveBg,
        error_diagnostic_visible = inactiveBg,
        duplicate = inactiveBg,
        duplicate_visible = inactiveBg,
        separator = {
            fg = { attribute = 'bg', highlight = 'StatusLine' },
            bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
        },
        separator_selected = {
            fg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        separator_visible = {
            fg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        trunc_marker = {
            bg = { attribute = 'bg', highlight = 'StatusLine' },
        },

        -- Tabs
        tab = inactiveBg,
        tab_separator = {
            fg = { attribute = 'bg', highlight = 'StatusLine' },
            bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
        },
        tab_separator_selected = {
            fg = { attribute = 'bg', highlight = 'StatusLine' },
        },
        tab_close = {
            bg = 'yellow',
        },
    },
}
