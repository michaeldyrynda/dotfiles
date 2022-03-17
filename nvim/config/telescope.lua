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
      theme = 'dropdown',
    },

    git_files = {
      prompt_title = 'Project Files',
      find_command = {'rg', '--files'},
      theme = 'dropdown',
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
    fzf = { }
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
