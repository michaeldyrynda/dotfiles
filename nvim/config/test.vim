" 
" Use a custom strategy for running vim-test inside of floaterm
" preventing auto close and piping output through less so you
" don't have to scroll stacktrace on failure /ht @jessarcher
function! FloatermStrategy(cmd)
    execute 'silent FloatermKill scratch'
    execute 'FloatermNew! --autoclose=2 --name=scratch '.a:cmd.' |less'
endfunction

let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
let g:test#strategy = 'floaterm'
