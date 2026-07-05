-- Fuzzy finder


return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },

  keys = {
    { '<c-p>', function() require('telescope.builtin').find_files() end },
    { '<c-p><c-p>', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' }) end },
    { '<leader>b', function() require('telescope.builtin').buffers() end },
    { '<leader>lg', function() require('telescope').extensions.live_grep_args.live_grep_args({
      prompt_title = 'Grep Project',
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "-L",
        "--color=never",
        "--sort=path",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      }
    }) end },
    { '<leader>lG', function() require('telescope').extensions.live_grep_args.live_grep_args({
      prompt_title = 'Grep All Files',
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--no-ignore",
        "-L",
        "--color=never",
        "--sort=path",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    }) end },
    { '<leader>fb', function() require('telescope.builtin').lsp_document_symbols() end },
  },

  config = function ()
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
        prompt_prefix = '   ',
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
        file_ignore_patterns = { '.git/', 'node_modules', '_ide_helper' },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        winblend = 0,
      },
      extensions = {
        live_grep_args = {
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-space>"] = actions.to_fuzzy_refine,
            },
          },
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          prompt_title = 'All Files',
        },
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

    require('telescope.builtin').edit_vim = function ()
      require('telescope.builtin').find_files({
        cwd = "$HOME/.config/nvim",
        prompt_title = "nvim config"
      })
    end

    require('telescope.builtin').dotfiles = function ()
      require('telescope.builtin').find_files({
        cwd = "$HOME/dotfiles",
        prompt_title = "Dotfiles"
      })
    end

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')

    -- Fix background colors to match editor
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = apply_telescope_colors,
    })

    apply_telescope_colors()
  end,
}
