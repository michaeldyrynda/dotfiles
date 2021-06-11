let g:airline#extensions#coc#enabled = 1

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-emmet',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-phpls',
  \ 'coc-snippets',
  \ 'coc-sql',
  \ 'https://github.com/petertriho/coc-tailwind-intellisense',
\ ]

nmap <Leader>a <Plug>(coc-codeaction)
nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gr <Plug>(coc-references)
nmap <Leader>gi <Plug>(coc-implementation)
nmap <Leader>gt <Plug>(coc-type-definition)
nmap <Leader>sr <Plug>(coc-rename)
nmap <Leader>rf <Plug>(coc-refactor)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
