" Install vim-plug if it is not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    source ~/.config/nvim/plugins.vim
call plug#end()

call sourcery#source_defer('config/tokyonight.lua')
call sourcery#source_defer('config/bufferline.lua')
call sourcery#source_defer('config/lualine.lua')
call sourcery#init()
