--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
    defaults = {
        prompt_prefix = '$  ',
        shorten_path = true,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            }
        },
        file_ignore_patterns = { 'node_modules' },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },

        winblend = 10,
        results_width = 0.25,
    },

    pickers = {
        find_files = {
            prompt_title = 'All files',
            color_devicons = true,
        },
        current_buffer_fuzzy_find = {
            prompt_title = 'Current buffer',
            theme = 'dropdown',
            sorting_strategy = 'ascending',
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
    theme = 'dropdown',
  })
end

builtin.dotfiles = function ()
    builtin.find_files({
        prompt_title = 'Dotfiles',
        cwd = "$HOME/dotfiles",
    })
end
