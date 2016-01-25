filetype plugin indent on
let g:mapleader = "\<Space>"
syntax on " syntax highlighting

" Plugins {{{
" ====================================================================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
" Appearance
" ====================================================================
Plug 'romainl/flattened' " solarized-like colorscheme

Plug 'tpope/vim-commentary'                " gcc
  xmap <silent><Leader>c <Plug>Commentary
  nmap <silent><Leader>c <Plug>CommentaryLine

Plug 'itchyny/lightline.vim'

Plug 'benekastah/neomake'
  nnoremap <silent> <Leader>m :Neomake<CR>

Plug 'mhinz/vim-signify'                    "show git diff
  let g:signify_vcs_list = [ 'git' ]

" languages
Plug 'fatih/vim-go'
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  let g:go_auto_type_info = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  " add missing imports on save
  let g:go_fmt_command = "goimports"

Plug 'lambdatoast/elm.vim'

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting
  let $FZF_DEFAULT_COMMAND = 'ag -l -g ""' "respect .gitignore

  nnoremap <silent> <Leader><space> :Files<CR>
  nnoremap <silent> <Leader>a :Buffers<CR>
  nnoremap <silent> <Leader>; :BLines<CR>
  nnoremap <silent> <Leader>. :Lines<CR>
  nnoremap <silent> <Leader>o :BTags<CR>
  nnoremap <silent> <Leader>O :Tags<CR>
  nnoremap <silent> <Leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <Leader>gl :Commits<CR>
  nnoremap <silent> <Leader>ga :BCommits<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

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

Plug 'tpope/vim-fugitive'
" {{{
  " Fix broken syntax highlight in gitcommit files
  " (https://github.com/tpope/vim-git/issues/12)
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  nnoremap <silent> <leader>gE :Gedit<space>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gR :Gread<space>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gW :Gwrite!<CR>
  nnoremap <silent> <leader>gq :Gwq<CR>
  nnoremap <silent> <leader>gQ :Gwq!<CR>

  function! ReviewLastCommit()
    if exists('b:git_dir')
      Gtabedit HEAD^{}
      nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
      echo 'No git a git repository:' expand('%:p')
    endif
  endfunction
  nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

  augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
" }}}

" Utility
Plug 'tpope/vim-unimpaired'
" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim'

" markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer')  }
  let g:markdown_composer_open_browser = 0
call plug#end()
"}}}

" General settings {{{
" ====================================================================

" ; is easier than :
nnoremap ; :

" hh is easier than esc
inoremap hh <ESC>

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

" set list " show hidden characters
" set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

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

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
" }}}

" Indentation {{{
" ====================================================================
set expandtab     " replace <Tab with spaces
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)
" }}}

" Search {{{
" ====================================================================
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on
" }}}

" Colors and highlightings {{{
" ====================================================================
" set background=dark
colorscheme flattened_dark
fun! ToggleColorScheme()
    if &background == "dark"
      exe "colorscheme flattened_light"
    else
      exe "colorscheme flattened_dark"
    endif
endfun

nnoremap <F5> :call ToggleColorScheme()<CR>

set cursorline     " highlight current line

" Various columns
" highlight! FoldColumn ctermbg=233 guibg=#0D0D0D

" Show trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS>s :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G
" }}}

" Key Mappings " {{{
" ====================================================================
" open init.vim
nnoremap <Leader>vi :e $MYVIMRC<CR>

nnoremap <F3> :set nonumber!<CR>

" fix indentation
map <F7> mzgg=G`z

" Quick way to save file
nnoremap <Leader>w :w<CR>

" Y behave like D or C
nnoremap Y y$

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select all text
noremap vA ggVG

" Same as normal H/L behavior, but preserves scrolloff
nnoremap H :call JumpWithScrollOff('H')<CR>
nnoremap L :call JumpWithScrollOff('L')<CR>
function! JumpWithScrollOff(key) " {{{
  set scrolloff=0
  execute 'normal! ' . a:key
  set scrolloff=999
endfunction " }}}

map <C-h> <Esc>:bp<CR>
map <C-t> <Esc>:bn<CR>

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}
nnoremap <silent> <Leader>h :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>l :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>k :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>j :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Same as above, except it opens unite at the end
nnoremap <silent> <Leader>h<Space> :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 1)<CR>
nnoremap <silent> <Leader>l<Space> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 1)<CR>
nnoremap <silent> <Leader>k<Space> :call JumpOrOpenNewSplit('k', ':leftabove split', 1)<CR>
nnoremap <silent> <Leader>j<Space> :call JumpOrOpenNewSplit('j', ':rightbelow split', 1)<CR>

" When opening with 'gf' search for the file extension and add
autocmd FileType <filetype> setl suffixesadd+=<exts>

" Universal closing behavior
nnoremap <silent> Q :call CloseSplitOrDeleteBuffer()<CR>
nnoremap <silent> Й :call CloseSplitOrDeleteBuffer()<CR>
function! CloseSplitOrDeleteBuffer() " {{{
  if winnr('$') > 1
    wincmd c
  else
    execute 'bdelete'
  endif
endfunction " }}}

" Delete all hidden buffers
nnoremap <silent> <Leader><BS>b :call DeleteHiddenBuffers()<CR>
function! DeleteHiddenBuffers() " {{{
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction " }}}
" }}}

" Netrw {{{
" ====================================================================
map <F1> :edit .<CR>
map <F2> :Explore<CR>

let g:netrw_banner = 0 " disable netrw banner with
let g:netrw_hide   = 1 " show not-hidden files by default
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles

function! s:NetrwCustomSettings()
  setlocal nolist
  map <buffer> <F1> :Rexplore<CR>
  map <buffer> <F2> :Rexplore<CR>
  nmap <buffer> l <CR>
  nmap <buffer> h -
  nnoremap <buffer> ~ :edit ~/<CR>
  nnoremap <buffer> <silent> q :Rexplore<CR>
endfunction

augroup enterNetrw
  autocmd!
  autocmd FileType netrw call s:NetrwCustomSettings()
augroup END
" }}}

" Autocommands {{{
" ====================================================================
augroup vimGeneralCallbacks
  autocmd!
  autocmd BufWritePost .nvimrc nested source ~/.nvimrc
augroup END

augroup fileTypeSpecific
  autocmd!
  " Rabl support
  autocmd BufRead,BufNewFile *.rabl setfiletype ruby
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " JST support
  autocmd BufNewFile,BufRead *.ejs set filetype=jst
  autocmd BufNewFile,BufRead *.jst set filetype=jst
  autocmd BufNewFile,BufRead *.djs set filetype=jst
  autocmd BufNewFile,BufRead *.hamljs set filetype=jst
  autocmd BufNewFile,BufRead *.ect set filetype=jst

  " Gnuplot support
  autocmd BufNewFile,BufRead *.plt set filetype=gnuplot

  autocmd FileType jst set syntax=htmldjango
augroup END

augroup quickFixSettings
  autocmd!
  autocmd FileType qf
        \ nnoremap <buffer> <silent> q :close<CR> |
        \ map <buffer> <silent> <F4> :close<CR> |
        \ map <buffer> <silent> <F8> :close<CR>
augroup END

augroup terminalCallbacks
  autocmd!
  autocmd TermClose * call feedkeys('<cr>')
augroup END

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

" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}

" shortcuts {{{
" Leader key for buffers:
" buffers
" h            jump or new buffer left
" l            jump or new buffer right
" k            jump or new buffer above
" j            jump or new buffer below
" hn           new buffer on the left
" ln           new buffer on the right
" kn           new buffer above
" jn           new buffer below
" h space      new buffer + fzf
" l space      new buffer + fzf
" k space      new buffer + fzf
" j space      new buffer + fzf

" m            Neomake
" backspace s  remove whitespace
" f            toggle folds

" Leader key for fzf:
" space        files
" a            buffers
" ;            lines in current buffer
" .            lines in buffers
" o            tags in current buffer
" O            tags in buffers
" /            Ag
" K            not sure
" gl           git commits
" ga           git commits of current buffer

" Leader key for git:
" gs, gd, gc, gb, ge, gE, gr, gR, gw, gW, gq, gQ

" vi           open init.vim
" w            save
" dv           go-def-vertical
" gb           go-doc-browser
"
" F keys:
" F1           Explore directory of current dir
" F2           Explore directory of current file
" F3           :toggle numbers
" F5           :toggle colorscheme
"}}}
"

" figure out why i can't put it after the signify plugin
highlight SignColumn ctermbg=233 guibg=#0D0D0D

let g:deoplete#enable_at_startup = 1
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)


" this line set some stuff only for this file
" vim: set sw=2 ts=2 et foldlevel=99 foldmethod=marker:
