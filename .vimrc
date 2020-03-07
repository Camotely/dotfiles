" Disabling viminfo
set viminfo=

" Vim-plug start
call plug#begin('~/.vim/plugged')

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Sensible defaults
Plug 'tpope/vim-sensible'

" Directories on the left
Plug 'scrooloose/nerdtree'

" Status bar
Plug 'itchyny/lightline.vim'

" Vim-plug end
call plug#end()

" Nerd tree keybind
map <C-n> :NERDTreeToggle<CR>

" Markdown Preview keybind
map <C-p> :MarkdownPreview<CR>

" Tomorrow Night theme for Lightline
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night',
	\ }

" Enable syntax
syntax on

" Enable filetype specific indentation based on files in
" ~/.vim/ftplugin/<filetype>.vim
filetype plugin indent on

" Show numbers
set nu

" Show relative line numbers
set rnu

" Set encoding
set encoding=utf-8

" Set indenting to 4 spaces (tabstop and shiftwidth)
set ts=4 sw=4

" Insert spaces on tab
set expandtab

" Show matching brackets
set showmatch

" Wildmenu allows for command tab in vim
set wildmenu

" Don't update screen when during macro and script execution
set lazyredraw

" Always shows location in file
set ruler

" Ignore case when searching
set ignorecase

" Enable search highlighting
set hlsearch

" Enable incremental search matching
set incsearch

" No error bells
set noerrorbells

" No screen flash on errors
set t_vb=

" Time in ms for mapping delays
set timeoutlen=500

" Time in ms for key code delays
set ttimeoutlen=0

" Set confirm when closing unsaved file
set confirm

" Remapping <Esc>
inoremap jk <Esc>

" Stop using the arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
