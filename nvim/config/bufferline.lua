require('bufferline').setup({
  options = {
    indicator = {
        style = 'none'
    },
    show_close_icon = false,
    buffer_close_icon = "",
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
    background = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    tab = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    tab_close = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    close_button = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    close_button_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    close_button_selected = {
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    buffer_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    modified = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    modified_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    duplicate = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    duplicate_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'Normal' }
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
  },
})
