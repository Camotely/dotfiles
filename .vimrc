" Vim-plug start
call plug#begin('~/.vim/plugged')

" Markdown preview
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Sensible defaults
"Plug 'tpope/vim-sensible'

" Directories on the left
"Plug 'scrooloose/nerdtree'

" Status bar
"Plug 'itchyny/lightline.vim'

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

" Set <F13> to the corresponding output
set <F13>=^[[25~

" Bind <F13> to Normal mode
inoremap <F13> <Esc>l
