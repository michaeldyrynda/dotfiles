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
    local catppuccin = require('catppuccin.palettes').get_palette('mocha')
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = catppuccin.base, fg = catppuccin.surface0 })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = catppuccin.surface0 })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = catppuccin.surface0, fg = catppuccin.surface0 })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = catppuccin.base, fg = catppuccin.surface0 })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = catppuccin.base, fg = catppuccin.surface0 })
    vim.api.nvim_set_hl(0, 'TelescopeTitle', { bg = catppuccin.blue, fg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = catppuccin.blue, fg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = catppuccin.blue, fg = catppuccin.base })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = catppuccin.blue, fg = catppuccin.base })
  end,
}
