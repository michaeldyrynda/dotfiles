return {
    'echasnovski/mini.splitjoin',

    config = function ()
        local splitjoin = require('mini.splitjoin')
        local hooks = require('splitjoin.hooks')

        splitjoin.setup {
            join = { hooks_post = { hooks.pad_curly } },
        }
    end,
}
