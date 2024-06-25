local separator = { '"▏"', color = 'StatusLineNonText' }

local colors = require("tokyonight.colors").setup({ transform = true })
local config = require("tokyonight.config").options

local tokyonight = {}

require('lualine').setup({
  options = {
    component_separators = { left = '', right = ''},
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
      separator
    },
    lualine_b = {
      'branch',
      'diff',
      separator,
      'tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_c = {
        {'filename', show_filename_only = false},
    },
     lualine_x = {
      'encoding',
      'filetype',
      'fileformat',
    },
    lualine_y = {
      separator,
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
      separator,
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})

tokyonight.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.blue },
  c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
}

tokyonight.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.green },
}

tokyonight.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.yellow },
}

tokyonight.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.magenta },
}

tokyonight.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.red },
}

tokyonight.terminal = {
  a = {bg = colors.green1, fg = colors.black },
  b = {bg = colors.fg_gutter, fg=colors.green1 },
}

tokyonight.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
  for _, mode in pairs(tokyonight) do
    mode.a.gui = "bold"
  end
end

return tokyonight
