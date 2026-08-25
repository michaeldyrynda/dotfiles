return {
    'phpactor/phpactor',

    build = 'composer install --no-dev --optimize-autoloader',

    ft = 'php',

    keys = {
        { '<leader>ec', ':call phpactor#ExtractConstant()<cr>', mode = 'v' },
        { '<leader>ee', ':<c-u>call phpactor#ExtractExpression(visualmode())<cr>', mode = 'v' },
        { '<leader>em', ':<c-u>call phpactor#ExtractMethod(visualmode())<cr>', mode = 'v' },
        { '<Leader>nc', ':PhpactorClassNew<CR>' },
        { '<Leader>mf', ':PhpactorMoveFile<CR>' },
        { '<Leader>pt', ':call phpactor#Transform()<cr>f<cr>' },
    }
}
