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

telescope.load_extension('fzf')
