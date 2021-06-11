--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
    defaults = {
        prompt_prefix = '  ',
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            }
        },
        file_ignore_patterns = { 'node_modules' },
    }
}

telescope.load_extension('fzf')
