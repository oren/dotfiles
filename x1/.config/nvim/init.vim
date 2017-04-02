call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
  let g:go_fmt_command = "goimports"
Plug 'romainl/flattened'
Plug 'iCyMind/NeoSolarized'
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
" colorscheme flattened_dark
set background=dark
colorscheme NeoSolarized

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

set showcmd      " always show current command
set laststatus=2

set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file


set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set cursorline

" Disable search highlighting with esc
nnoremap <silent> <esc> :silent :nohlsearch<cr>

set expandtab     " replace Tab with spaces
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)

" search
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on

" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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

" if file was modified, enter will save it. no need for :w
nnoremap <CR> :<C-u>update<CR>

" replace current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" open init.vim
nnoremap <Leader>vi :e $MYVIMRC<CR>

" Netrw
let g:netrw_banner = 0 " disable netrw banner with
let g:netrw_hide   = 1 " don't show hidden files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles

" Show trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

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

" autocmd BufNewFile,BuRead *.txt setlocal spell spelllang=en_us
" :setlocal spell spelllang=en_us
" :setlocal nospell

" this line set some stuff only for this file
" vim: set sw=2 ts=2 et foldlevel=99 foldmethod=marker:
