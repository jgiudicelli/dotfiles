" install
"mkdir -p ~/.vim/autoload ~/.vim/bundle; \
"curl -Sso ~/.vim/autoload/pathogen.vim \
"    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" cd ~/.vim/bundle

" git clone https://github.com/scrooloose/nerdtree.git

" git clone https://github.com/honza/vim-snippets.git
" git clone git://github.com/garbas/vim-snipmate.git
" needed for vim-snipmate
" git clone https://github.com/tomtom/tlib_vim.git
" git clone https://github.com/MarcWeber/vim-addon-mw-utils.git

" git clone git://github.com/tomtom/tcomment_vim.git
" git clone https://github.com/terryma/vim-multiple-cursors.git
" git clone git://github.com/majutsushi/tagbar
" git clone https://github.com/bling/vim-airline.git¬
" git clone git@github.com:kien/ctrlp.vim.git¬
" git clone git@github.com:tpope/vim-surround.git
" git clone git://github.com/tpope/vim-rails.git
" git clone git@github.com:vim-ruby/vim-ruby.git
" git clone git@github.com:tpope/vim-fugitive.git

" When vimrc is edited, reload it
:autocmd! bufwritepost .vimrc source ~/.vimrc
" open .vimrc in a v split
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" use pathogen to load plugins
call pathogen#infect()

" disable arrow keys
nnoremap  <Up>     <NOP>
nnoremap  <Down>   <NOP>
nnoremap  <Left>   <NOP>
nnoremap  <Right>  <NOP>

noremap <F8> :TagbarToggle<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" add line above return to command mode
nnoremap - <S-o><Esc>
" add line below return to command mode
nnoremap _ o<Esc>

set t_Co=256
syntax on
set background=dark
" let g:solarized_termcolors = 256
colorscheme solarized
" colorscheme Tomorrow-Night-Eighties
" colorscheme slate
set relativenumber
set number
set noswapfile
set hidden
set wildmenu "Turn on WiLd menu
set so=7 " scrolloff
set diffopt+=iwhite
set sw=2 " shiftwidth
set tabstop=2
set expandtab
set bg=dark
set ai "Auto indent
set si "Smart indent
set list
set listchars=tab:▸\ ,trail:.,eol:¬
set showmatch
set backspace=indent,eol,start
let g:gist_post_private = 1
let g:gist_show_privates = 1

" map invert case to tilde ~
set tildeop

set incsearch
set hlsearch
" searches are case insensitive
set ignorecase
" unless they contain at least one capital letter
set smartcase

set showcmd
" set tags dir
set tags=tags,./tags
" use ag instead of grep
set grepprg=ag
" remap next and previous grep matches
nnoremap <C-n> :cn <CR>
nnoremap <C-p> :cp <CR>

" edit new file in same dir as curent
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>r :set rnu
nnoremap <Leader>n :set number
nnoremap <Leader>t :! bundle exec ruby -Itest %<CR>
nnoremap <Leader>w <C-W><C-W>

command! Debug :normal i require 'debugger';debugger;<ESC>
command! Screenshot :normal i page.save_screenshot('/Users/jg/screenshot.png', full: true)<ESC>

set cursorline                  " highlight current line
set cc=80

hi ColorColumn ctermbg=white
hi CursorLineNr ctermfg=white

set laststatus=2
" set statusline=\ %{HasPaste()}\ %w\ \ CWD:\%r%{CurDir()}%h\ \ \ %F%m%r%h\ \ \ \ %=Line:\ %l/%L:%c\ \ \

" toggle highlighting search results
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" function! CurDir()
"     let curdir = substitute(getcwd(), '/home/jerome/', "~/", "g")
"     return curdir
" endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" reopen file on same line as when closed¬
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" SML make code {{{
autocmd FileType sml setlocal makeprg=sml\ -P\ full\ '%'
" }}}
