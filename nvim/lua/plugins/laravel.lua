return {
    'adibhanna/laravel.nvim',

    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
    },

    -- cmd = { 'Artisan', 'Composer', 'Laravel*' },

    keys = {
        { '<leader>la', ':Artisan<cr>', desc = 'Laravel Artisan' },
        { '<leader>lc', ':Composer<cr>', desc = 'Composer' },
        { '<leader>lr', ':LaravelRoute<cr>', desc = 'Laravel Routes' },
        { '<leader>lm', ':LaravelMake<cr>', desc = 'Laravel Make' },
    },
    event = { 'VeryLazy' },
    config = function()
        require('laravel').setup()
    end,
}
