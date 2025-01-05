--
-- Force filetypes
--
local force_filetype = vim.api.nvim_create_augroup('force_filetype', { clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.keymap' },
  group = force_filetype,
  callback = function ()
    vim.bo.filetype = 'devicetree'
  end,
})

--
-- Blade Treesitter hackiness
--
-- See: https://github.com/EmranMR/tree-sitter-blade, which is still unstable!
-- So we have to do funky things like this to get everything to work. Then
-- you run `:TSInstall blade`, then you add queries and injections into
-- your Neovim config's `after/queries/blade` from the repo's docs.
-- /ht @jesseleite

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade"
}

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.blade.php' },
  group = force_filetype,
  callback = function ()
    vim.bo.filetype = 'blade'
  end,
})
