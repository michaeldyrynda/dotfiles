--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    path_display = {
      'shorten',
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      }
    },
    file_ignore_patterns = { 'node_modules' },

    winblend = 10,

    layout_config = {
      prompt_position = 'top',
      width = 0.75
    },
  },

  pickers = {
    find_files = {
      prompt_title = 'All files',
      hidden = true
    },

    current_buffer_fuzzy_find = {
      prompt_title = 'Current buffer',
      sorting_strategy = 'descending'
    },
  }
}

--
-- Custom finders
--
builtin.edit_vim = function ()
  builtin.find_files({
    cwd = "~/.config/nvim",
    prompt_title = "~ nvim config ~",
    theme = "dropdown",
    previewer = false
  })
end

builtin.dotfiles = function ()
  builtin.find_files({
    prompt_title = 'Dotfiles',
    cwd = "$HOME/dotfiles",
  })
end
