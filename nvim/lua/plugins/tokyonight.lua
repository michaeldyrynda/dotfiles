return {
  'folke/tokyonight.nvim',

  lazy = false,

  priority = 1000,

  opts = { -- test
    on_colors = function (colors)
      colors.gitSigns = {
        add = colors.teal,
        change = colors.purple,
        delete = colors.red,
      }
    end,

    on_highlights = function(hl, c)
      local util = require('tokyonight.util')
      local prompt = "#2d3149"

      hl.ColorColumn = {
        bg = c.fg_gutter,
      }

      hl.GitSignsCurrentLineBlame = {
        fg = c.fg_gutter,
      }

      hl.StatusLine = {
        bg = util.darken(c.bg_dark, 0.98, '#000000'),
        fg = c.fg_dark,
      }

      hl.StatusLineComment = {
        bg = util.darken(c.bg_dark, 0.85, '#000000'),
        fg = c.comment,
      }

      hl.LineNrAbove = {
        fg = c.fg_gutter,
      }

      hl.LineNr = {
        fg = util.lighten(c.fg_gutter, 0.7),
      }

      hl.LineNrBelow = {
        fg = c.fg_gutter,
      }

      hl.MsgArea = {
        bg = util.darken(c.bg_dark, 0.85, '#000000'),
      }

      -- Spelling
      hl.SpellBad = {
        undercurl = true,
        sp = '#7F3A43',
      }

      -- Telescope
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }

      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = prompt,
      }

      hl.TelescopePromptNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }

      hl.TelescopePromptBorder = {
        bg = c.bg_dark,
        fg = prompt,
      }

      hl.TelescopePromptTitle = {
        fg = c.git.change,
      }

      hl.TelescopePreviewTitle = {
        fg = c.git.change,
      }

      hl.TelescopeResultsTitle = {
        fg = c.git.change,
      }

      -- Indent
      hl.IblIndent = {
        fg = c.bg_dark,
      }

      -- Floaterm
      hl.Floaterm = {
        bg = prompt,
      }

      hl.FloatermBorder = {
        bg = c.bg,
        fg = c.bg,
      }
    end,
  },

  config = function (plugin, opts)
    require('tokyonight').setup(opts)

    vim.cmd('colorscheme tokyonight')
  end,
}
