" When vimrc is edited, reload it
:autocmd! bufwritepost .vimrc source ~/.vimrc

" use pathogen to load plugins
call pathogen#infect()

" :so ~/.vim/plugin/minibufexpl.vim

set wildmenu "Turn on WiLd menu
set so=7
set diffopt+=iwhite
set sw=2
set tabstop=2
set expandtab
set bg=dark
set showmatch
set ai "Auto indent
set si "Smart indent
set number
set cc=80
hi ColorColumn ctermbg=grey guibg=darkgrey

" map invert case to tilde ~
set tildeop

" set tags dir
set tags=./tags

" use ack instead of grep
set grepprg=ack

" map leader key
let mapleader='='

" edit new file in same dir as curent
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

:ab #c ####################################
set cursorline                  " highlight current line
hi cursorline guibg=#333333     " highlight bg color of current line
hi CursorColumn guibg=#333333   " highlight cursor
set laststatus=2
set statusline=\ %{HasPaste()}\ %w\ \ CWD:\%r%{CurDir()}%h\ \ \ %F%m%r%h\ \ \ \ %=Line:\ %l/%L:%c\ \ \

function! CurDir()
    let curdir = substitute(getcwd(), '/home/jerome/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

