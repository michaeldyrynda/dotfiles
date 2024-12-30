return {
    'phpactor/phpactor',

    build = 'composer install --no-dev --optimize-autoloader',

    ft = 'php',

    keys = {
        { '<Leader>p', ':PhpactorContextMenu<CR>' },
        { '<Leader>u', ':call phpactor#ImportClass()<CR>' },
        { '<leader>ec', ':call phpactor#ExtractConstant()<cr>' },                    -- Extract a constant
        { '<leader>ee', ':<c-u>call phpactor#ExtractExpression(visualmode())<cr>' }, -- Extract an expression (variable)
        { '<leader>em', ':<c-u>call phpactor#ExtractMethod(visualmode())<cr>' },     -- Extract a method
        { '<Leader>nc', ':PhpactorClassNew<CR>' },
        { '<Leader>mf', ':PhpactorMovileFile<CR>' },
        { '<Leader>fu', ':PhpactorFindReferences<CR>' },
    }
}
