--
-- Telescope config
--
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

vim.cmd([[
  highlight link TelescopePromptTitle PMenuSel
  highlight link TelescopePreviewTitle PMenuSel
  highlight link TelescopePromptNormal NormalFloat
  highlight link TelescopePromptBorder FloatBorder
  highlight link TelescopeNormal CursorLine
  highlight link TelescopeBorder CursorLineBg
]])

telescope.setup {
    defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = '   ',
        selection_caret = '  ',

        file_ignore_patterns = { 'node_modules', '_ide_helper' },

        layout_config = {
            prompt_position = 'top',
        },

        sorting_strategy = 'ascending',

        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },

        winblend = 10,
    },

    pickers = {
        find_files = {
            previewer = false,
            prompt_title = 'All Files',
            find_command = {'rg', '--files', '--no-ignore', '--hidden'},
            sorting_strategy = 'ascending',
            layout_config = {
                width = 0.5,
            },
        },

        git_files = {
            prompt_title = 'Project Files',
            find_command = {'rg', '--files'},
            previewer = false,
            layout_config = {
                width = 0.5,
            },
        },

        current_buffer_fuzzy_find = {
            prompt_title = 'Current buffer',
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
  })
end

builtin.dotfiles = function ()
  builtin.find_files(require('telescope.themes').get_dropdown{
    cwd = "$HOME/dotfiles",
    prompt_title = 'Dotfiles',
  })
end

telescope.load_extension('fzf')
