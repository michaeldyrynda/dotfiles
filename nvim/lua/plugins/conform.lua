return {
  'stevearc/conform.nvim',

  lazy = false,

  opts = {
    formatters_by_ft = {
      php = {'pint'},
      json = {'jq', 'pint'},
      lua = {'lua-format'},
    },

    format_on_save = {
      lsp_fallback = false,
      timeout_ms = 500,
    },
  },
}
