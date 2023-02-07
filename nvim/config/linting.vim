augroup linting
  autocmd!
augroup END

let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1

let g:ale_fixers = {
    \ 'php': ['pint'],
    \ 'html': ['prettier'],
    \ 'blade': ['prettier'],
    \ 'javascript': ['prettier'],
    \ 'css': ['prettier'],
    \ 'json': ['prettier'],
\ }

" Fallback to my global php-cs-fixer binary if not installed in local project
function! FallbackToGlobalPhpCsFixerBinary()
  if filereadable('vendor/bin/php-cs-fixer')
    let g:ale_php_cs_fixer_executable = 'vendor/bin/php-cs-fixer'
  else
    let g:ale_php_cs_fixer_executable = 'php-cs-fixer'
  endif
endfunction

call FallbackToGlobalPhpCsFixerBinary()

" When the current project does not have a php-cs-fixer config, we will fall
" back to a locally defined `.php_cs.local` file if it exists, otherwise we
" will just use PSR12.
function! FallbackToCustomLocalOrPsr12PhpCsFixerConfig()
  if (filereadable('.php-cs-fixer.php') || filereadable('.php-cs-fixer.dist.php') || filereadable('.php_cs'))
    return
  else
    let g:ale_php_cs_fixer_options = '--using-cache=no --path-mode=override --rules=@PSR12'
  endif
endfunction

call FallbackToCustomLocalOrPsr12PhpCsFixerConfig()

" -----------------------------------------------------------------------------
"  Linters
" -----------------------------------------------------------------------------

" Use the following linters, in this order, when any are available
autocmd linting FileType php let b:ale_linters = ['psalm', 'php', 'phpstan']

" Only look for a binary once
let g:ale_cache_executable_check_failures = 1

" Lint when a buffer is entered for the first time
let g:ale_lint_on_enter = 1

" Don't lint every time we exit insert mode
let g:ale_lint_on_insert_leave = 0

" Don't lint every time I change text
let g:ale_lint_on_text_changed = 0

" Use the local PHPStan binary instead of the global binary
let g:ale_php_phpstan_executable = 'vendor/bin/phpstan'

" Use the local Psalm binary instead of the global binary
let g:ale_php_psalm_executable = 'vendor/bin/psalm'

" Use this as a marker in the sidebar when an linting error is found
let g:ale_sign_error = '👀'
