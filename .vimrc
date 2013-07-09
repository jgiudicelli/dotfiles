" install
"mkdir -p ~/.vim/autoload ~/.vim/bundle; \
"curl -Sso ~/.vim/autoload/pathogen.vim \
"    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-rails.git
" git clone https://github.com/scrooloose/nerdtree.git
" git clone git://github.com/garbas/vim-snipmate.git
" git clone https://github.com/tomtom/tlib_vim.git
" git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
" git clone https://github.com/honza/snipmate-snippets.git
" git clone git://github.com/tomtom/tcomment_vim.git

" When vimrc is edited, reload it
:autocmd! bufwritepost .vimrc source ~/.vimrc

" use pathogen to load plugins
call pathogen#infect()

" disable arrow keys
inoremap jj <esc>
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
nnoremap   <Up>     <NOP>
nnoremap   <Down>   <NOP>
nnoremap   <Left>   <NOP>
nnoremap   <Right>  <NOP>

syntax on
set noswapfile
set hidden
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
set list
set listchars=tab:▸\ ,trail:.,eol:¬
set cc=80
"hi ColorColumn ctermbg=232 guibg=257
hi ColorColumn ctermbg=darkgrey
hi ColorColumn ctermbg=white

" map invert case to tilde ~
set tildeop

" set tags dir
set tags=./tags

" use ack instead of grep
set grepprg=ack
" remap next and previous grep matches
map <C-n> :cn <CR>
map <C-p> :cp <CR>

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

