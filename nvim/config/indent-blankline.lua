local highlight = {
    "CursorColumn",
    "Whitespace"
}

require('ibl').setup({
  exclude = {
    filetypes = {
      'help',
      'terminal',
      'dashboard',
      'packer',
      'lspinfo',
      'TelescopePrompt',
      'TelescopeResults',
    },
    buftypes = {
      'terminal',
      'NvimTree',
    }
  },
  whitespace = {
    remove_blankline_trail = true
  },
  scope = {
    show_start = false
  }
})
