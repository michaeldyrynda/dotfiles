-- Fuzzy file finder and grep (fff)

return {
  'dmtrKovalenko/fff',

  build = function()
    require('fff.download').download_or_build_binary()
  end,

  lazy = false,

  keys = {
    { '<C-p>', function() require('fff').find_files() end, desc = 'Find Files' },
    { '<leader>lg', function() require('fff').live_grep() end, desc = 'Grep Project' },
    { '<leader>lG', function() require('fff').live_grep() end, desc = 'Grep (use !pattern to include ignored)' },
  },

  config = function()
    local function apply_fff_colors()
      local colors = require('config.theme').palette()

      vim.api.nvim_set_hl(0, 'FFFNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FFFBorder', { fg = colors.fg_muted, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FFFPromptNormal', { fg = colors.fg, bg = colors.bg_float })
      vim.api.nvim_set_hl(0, 'FFFPromptBorder', { fg = colors.fg_muted, bg = colors.bg_float })
      vim.api.nvim_set_hl(0, 'FFFPreviewNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FFFPreviewBorder', { fg = colors.fg_muted, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FFFSelection', { fg = colors.fg, bg = colors.bg_selection, bold = true })
      vim.api.nvim_set_hl(0, 'FFFSelectionCaret', { fg = colors.syntax['function'], bg = colors.bg_selection })
      vim.api.nvim_set_hl(0, 'FFFTitle', { fg = colors.bg, bg = colors.syntax['function'] })
      vim.api.nvim_set_hl(0, 'FFFMatch', { fg = colors.syntax['string'], bold = true })
    end

    apply_fff_colors()

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = apply_fff_colors,
    })

    require('fff').setup({
      prompt = '   ',
      title = 'Find Files',
      layout = {
        height = 0.9,
        width = 0.9,
        prompt_position = 'top',
        preview_position = 'right',
        preview_size = 0.5,
        border = 'rounded',
      },
      keymaps = {
        close = '<Esc>',
        cycle_previous_query = '<C-Up>',
        cycle_forward_query = '<C-Down>',
      },
      frecency = {
        enabled = true,
      },
      grep = {
        smart_case = true,
        modes = { 'plain', 'regex', 'fuzzy' },
      },
      hl = {
        winhl = {
          prompt = 'Normal:FFFPromptNormal,FloatBorder:FFFPromptBorder,FloatTitle:FFFTitle',
          list = 'Normal:FFFNormal,FloatBorder:FFFBorder,FloatTitle:FFFTitle,CursorLine:FFFSelection,CursorLineSign:FFFSelectionCaret,Search:FFFMatch',
          preview = 'Normal:FFFPreviewNormal,FloatBorder:FFFPreviewBorder,FloatTitle:FFFTitle',
        },
      },
    })
  end,
}
