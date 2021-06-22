--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
    defaults = {
        prompt_prefix = '  ',
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            }
        },
        file_ignore_patterns = { 'node_modules' },
        vimgrep_arguments = {
            'ag',
            '--vimgrep'
        }
    }
}

builtin.edit_vim = function ()
  builtin.find_files({
    cwd = "~/.config/nvim",
    prompt_title = "~ nvim config ~",
    theme = 'dropdown',
  })
end

telescope.load_extension('fzf')
