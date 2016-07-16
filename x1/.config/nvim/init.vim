call plug#begin()
Plug 'fatih/vim-go'
Plug 'romainl/flattened'
Plug 'tpope/vim-commentary'                " gcc
  xmap <silent><Leader>c <Plug>Commentary
  nmap <silent><Leader>c <Plug>CommentaryLine
Plug 'ludovicchabant/vim-gutentags' " {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/python2.7/*',
      \ '*/migrate/*.rb'
      \ ]
  let g:gutentags_generate_on_missing = 0
  let g:gutentags_generate_on_write = 0
  let g:gutentags_generate_on_new = 0
  nnoremap <Leader>t! :GutentagsUpdate!<CR>
" }}}
call plug#end()

let g:mapleader = "\<Space>"
colorscheme flattened_dark

" if file was modified, enter will save it. no need for :w
nnoremap <CR> :<C-u>update<CR>

" open init.vim
nnoremap <Leader>vi :e $MYVIMRC<CR>

" ; is easier than :
nnoremap ; :

" hh is easier than esc
inoremap hh <ESC>

map <C-h> <Esc>:bp<CR>
map <C-t> <Esc>:bn<CR>

set clipboard=unnamed,unnamedplus
set number         " show line numbers
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse

set scrolloff=3       " always keep cursor 3 lines from the top and bottom
set virtualedit=onemore " allow the cursor to move just past the end of the line
set undolevels=5000     " set maximum undo levels

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

" ignore pattern for wildmenu
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set wildmode=list:longest,full

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

"folds
set foldmethod=manual
" remove underscores. sets every time after a colorscheme was chosen
:au ColorScheme * hi Folded cterm=NONE
" remove dashes
set fillchars="fold: "
" toggle folds
fun! ToggleFold()
    if &foldlevel == 0
      exe "normal zR"
    else
      exe "normal zM"
    endif
endfun

nnoremap <Leader>f :call ToggleFold()<CR>

" Disable search highlighting
" ====================================================================
" if file was modified, enter will save it. no need for :w
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

set expandtab     " replace <Tab with spaces
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)

set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    +-- current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>b :b <C-d>
nnoremap <leader>e :e **/
nnoremap <leader>g :grep<space>
nnoremap <leader>i :Ilist<space>
nnoremap <leader>j :tjump /
nnoremap <leader>m :make<cr>
nnoremap <leader>s :call StripTrailingWhitespace()<cr>
nnoremap <leader>q :b#<cr>
nnoremap <leader>t :TTags<space>*<space>*<space>.<cr>

inoremap <silent> ,f <C-x><C-f>
inoremap <silent> ,i <C-x><C-i>
inoremap <silent> ,l <C-x><C-l>
inoremap <silent> ,n <C-x><C-n>
inoremap <silent> ,o <C-x><C-o>
inoremap <silent> ,t <C-x><C-]>
inoremap <silent> ,u <C-x><C-u>

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction
"}}}

" this line set some stuff only for this file
" vim: set sw=2 ts=2 et foldlevel=99 foldmethod=marker:
