return {
    'echasnovski/mini.bufremove',

    keys = {
        { '<Leader>bd', function () require('mini.bufremove').delete() end, silent = true },
    },
}
