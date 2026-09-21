-- Telescope (LSP pickers, buffers, ui-select)

return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },

  keys = {
    { '<leader>b', function() require('telescope.builtin').buffers() end },
    { '<leader>fb', function() require('telescope.builtin').lsp_document_symbols() end },
  },

  config = function()
    local actions = require('telescope.actions')

    local function apply_telescope_colors()
      local colors = require('config.theme').palette()

      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = colors.bg, fg = colors.border })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.fg, bg = colors.bg_line })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = colors.bg_line, fg = colors.bg_line })
      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = colors.bg, fg = colors.border })
      vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = colors.bg, fg = colors.border })
      vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = colors.fg, bg = colors.bg_line, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = colors.syntax["function"], bg = colors.bg_line })
      vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = colors.syntax["string"], bold = true })
      vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.syntax["function"], bg = colors.bg_line })
      vim.api.nvim_set_hl(0, 'TelescopeTitle', { bg = colors.syntax["function"], fg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = colors.syntax["function"], fg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = colors.syntax["function"], fg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = colors.syntax["function"], fg = colors.bg })
    end

    require('telescope').setup({
      defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = '   ',
        selection_caret = '  ',
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
          horizontal = {
            width = 0.9,
            height = 0.9,
            preview_width = 0.5,
          },
        },
        preview = {
          filesize_limit = 1,
          timeout = 200,
          msg_bg_fillchar = ' ',
        },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
          },
        },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        winblend = 0,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      pickers = {
        buffers = {
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            }
          },
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = 'History',
        },
        lsp_references = {
          previewer = false,
        },
        lsp_definitions = {
          previewer = false,
        },
        lsp_document_symbols = {
          symbol_width = 55,
        },
      },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = apply_telescope_colors,
    })

    apply_telescope_colors()
  end,
}
