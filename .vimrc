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

" Stop using the arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Nerd tree keybind
map <C-n> :NERDTreeToggle<CR>

" Markdown Preview keybind
map <C-p> :MarkdownPreview<CR>

" Tomorrow Night theme for Lightline
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night',
	\ }

" Show numbers
set nu

" Show relative line numbers
set rnu

" Set indenting to 4 spaces (tabstop and shiftwidth)
set ts=4 sw=4

" Show matching brackets
set showmatch

" Always shows location in file
set ruler

" Auto tabbing
set smarttab

" Remapping <Esc>
inoremap jk <Esc>
