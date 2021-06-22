"
" Filetype config
"
augroup filetype_settings
    autocmd!
    autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab iskeyword+=$
    autocmd FileType html setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType blade setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType css setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType javascript setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType json setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType lua setlocal ts=2 sw=2 sts=2 expandtab
augroup END

augroup framework_filetype_settings
    autocmd!
    autocmd BufRead,BufNewFile *.blade.php setlocal commentstring={{--\ %s\ --}} filetype=blade
augroup END
