--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    preview = false,
    file_ignore_patterns = { 'node_modules' },

    winblend = 10,

    layout_config = {
      prompt_position = 'top',
      width = 0.75
    },
  },

  pickers = {
    find_files = {
      prompt_title = 'All Files',
      find_command = {'rg', '--files', '--no-ignore', '--hidden'},
      hidden = true,
      no_ignore = true,
      theme = 'dropdown',
      preview = false,
    },

    current_buffer_fuzzy_find = {
      prompt_title = 'Current buffer',
      sorting_strategy = 'descending'
    },

    buffers = {
      sort_lastused = true,
      theme = 'dropdown',
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

--
-- Custom finders
--
builtin.edit_vim = function ()
  builtin.find_files(require('telescope.themes').get_dropdown{
    cwd = "$HOME/.config/nvim",
    prompt_title = "nvim config",
    previewer = false
  })
end

builtin.dotfiles = function ()
  builtin.find_files(require('telescope.themes').get_dropdown{
    cwd = "$HOME/dotfiles",
    prompt_title = 'Dotfiles',
    previewer = false,
  })
end

telescope.load_extension('fzf')
