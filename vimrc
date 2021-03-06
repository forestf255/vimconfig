" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = ";"

" Better command line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Show relative line numbers
set number
set relativenumber

" Toggle relative line numbers
nnoremap <leader>r :call RelativeNumToggle()<cr>
function! RelativeNumToggle()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Filetype specific small changes here
autocmd Filetype python set tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype c set textwidth=79
autocmd Filetype cpp set textwidth=79

" Toggle line marker
nnoremap <leader>c :call MarkColumnToggle()<cr>
function! MarkColumnToggle()
  if &colorcolumn
    set colorcolumn=
  else
    set colorcolumn=80
  endif
endfunction

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader><space> :nohl<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
"Use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Native shortcuts
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>j :bn<cr>
map <leader>k :bp<cr>
map <leader>d :bd<cr>

:imap jk <Esc>

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
  " Light / Dark Mode
  :command Dark set background=dark
  :command Light set background=light
endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-airline/vim-airline'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'w0rp/ale'
Plug 'svermeulen/vim-cutlass'
call plug#end()

let g:ale_lint_delay = 3000

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" Plugin shortcuts
map <leader>o :BufExplorer<cr>
let g:ctrlp_map = '<c-f>'

" Use rg for grep searches
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" Ignore these from rg search
set wildignore+=*/.git/*,*/tmp/*,*.swp
" Always color rg output
set grepprg=grep\ --color=always\ -n\ $*\ /dev/null
