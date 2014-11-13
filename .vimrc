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
" git clone https://github.com/rizzatti/dash.vim.git


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

set t_Co=256 " term colors
syntax on
set background=dark
" let g:solarized_termcolors = 256
colorscheme solarized
" colorscheme Tomorrow-Night-Eighties
" colorscheme slate
set relativenumber
set number
set noswapfile
set hidden " don't complain about unsaved files when switching or closing
set wildmenu "Turn on WiLd menu
set so=7 " scrolloff
set diffopt+=iwhite " ignore whitespace differences in diffs
set sw=2 " shiftwidth controls indentation through < & >
set tabstop=2
set expandtab " use spaces instead of tabs
set ai "Auto indent
set si "Smart indent
set list " show end of line char
set listchars=tab:▸\ ,trail:.,eol:¬
set showmatch
set backspace=indent,eol,start
set tildeop " map invert case to tilde ~
let g:gist_post_private = 1
let g:gist_show_privates = 1


" SEARCH
set incsearch
set hlsearch
set ignorecase " searches are case insensitive
set smartcase " unless they contain at least one capital letter
" toggle highlighting search results
nnoremap <CR> :nohlsearch<CR>

set showcmd
set tags=tags,./tags " set tags dir
set grepprg=ag " use ag instead of grep
" remap next and previous grep matches
nnoremap <C-n> :cn <CR>
nnoremap <C-p> :cp <CR>

" leader mapped commands
" edit/split/vsplit new file in same dir as curent
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
nnoremap <Leader>r :set relativenumber!<CR>
nnoremap <Leader>n :set number!<CR>
nnoremap <Leader>l :set list!<CR>
" run test for current buffer
nnoremap <Leader>t :! bundle exec ruby -Itest %<CR>
" switch buffer split
nnoremap <Leader>w <C-W><C-W>
" show current color scheme
nnoremap <Leader>c :echo g:colors_name<CR>
" open .vimrc in a v split
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>bg :set bg=light<CR>
nnoremap <Leader>bg! :set bg=dark<CR>

command! Debug :normal i require 'debugger';debugger;<ESC>
command! Screenshot :normal i page.save_screenshot('~/screenshot.png', full: true)<ESC>!

set cursorline " highlight current line
set colorcolumn=80 " cc
hi ColorColumn ctermbg=white
" set line number color
hi CursorLineNr ctermfg=white

set laststatus=2

:augroup vimtricks
: autocmd!
: autocmd bufwritepost .vimrc source ~/.vimrc " When vimrc is edited, reload it :echom reloaded
" reopen file on same line as when closed¬
: autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
" SML make code
": autocmd FileType sml setlocal makeprg=sml\ -P\ full\ '%'
:augroup END

