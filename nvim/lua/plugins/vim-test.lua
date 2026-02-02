return {
  'vim-test/vim-test',

  keys = {
    { '<Leader>tn', ':silent TestNearest<CR>' },
    { '<Leader>tf', ':silent TestFile<CR>' },
    { '<Leader>ts', ':silent TestSuite<CR>' },
    { '<Leader>tl', ':silent TestLast<CR>' },
    { '<Leader>tv', ':silent TestVisit<CR>' },
  },

  config = function()
    vim.cmd([[
      let test#php#pest#options = '-v'

      let test#strategy = 'neovim_sticky'

      let test#neovim#term_position = 'vert botright 100'
      let g:test#preserve_screen = 0
      let g:test#neovim_sticky#kill_previous = 1
      let g:test#neovim_sticky#reopen_window = 1
      let g:test#neovim_sticky#use_existing = 1
    ]])
  end
}
