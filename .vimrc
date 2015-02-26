set t_ut=
set nocompatible
set timeout
set timeoutlen=300

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'bling/vim-airline'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'gregsexton/gitv'
Plugin 'gavinbeatty/vmath.vim'
Plugin 'sjl/gundo.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/Conque-Shell'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'gioele/vim-autoswap'
Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'paradigm/vim-multicursor'
"Plugin 'hlissner/vim-multiedit'
call vundle#end()
filetype plugin on
filetype plugin indent on
""""""""""""""""""""""""" Mappings """""""""""""""""""""""""

let mapleader = ","

map <leader>m :tabe ~/.vimrc<CR>
map <leader>w :w<CR>
map <leader>q :q<CR>

nmap <CR> a<CR>
nmap <BS> i<BS>

map <leader>y "+y
map <leader>p "+p
map <leader>ü "*p
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set autochdir
let NERDTreeChDirMode=2
noremap <silent> <C-D> :NERDTreeToggle .<CR>


map þ <ESC>pa
map ¨ <ESC>,pa
nmap þ p
nmap ¨ ,p


nnoremap j :m .+1<CR>==
nnoremap k :m .-2<CR>==
inoremap j <ESC>:m .+1<CR>==gi
inoremap k <ESC>:m .-2<CR>==gi
vnoremap j :m '>+1<CR>gv=gv
vnoremap k :m '<-2<CR>gv=gv



map [1;3A k
map [1;3B j

""""""""""""""""""""""""" behavioral """""""""""""""""""""

noremap j gj
noremap k gk

set smartcase
set whichwrap+=<,>,h,l,[,]

set undofile
set backupdir =~/.vim/backup//
set directory  =~/.vim/swp//
set undodir=~/.vim/undo//

set clipboard=unnamedplus

cabbrev shv ConqueTermVSplit bash
cabbrev sht ConqueTermTab bash
cabbrev sh ConqueTerm bash
cabbrev shs ConqueTermSplit bash
cabbrev git Git
""""""""""""""""""""""""" GUI      """"""""""""""""""""""""

syntax on
set t_Co=256
colorscheme badwolf

set cursorline
set hlsearch
set mouse=ar mousemodel=extend
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


set nu
set relativenumber

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>


map <leader>h :split<CR>
map <leader>v :vsplit<CR>
map <leader>t :tab split<CR>
map <leader>a :tabonly<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map +  vw*

noremap <silent> <F3> :let @/ = ""<CR>
nmap <F8> :TagbarToggle<CR>
vmap <expr>  <F9>  VMATH_YankAndAnalyse()
nmap         <F9>  vip<F9>
nnoremap <F4> :Gitv --all<CR>
nnoremap <F5> :GundoToggle<CR>
""""""""""""""""""""""" text      """""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSelection('f')<CR>

"thanks to evan hahn
if has('autocmd')
  if has('spell')
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
  endif
  au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
endif


autocmd BufWritePre * :%s/\s\+$//e
