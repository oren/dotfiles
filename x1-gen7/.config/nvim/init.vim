call plug#begin()
  Plug 'fatih/vim-go'
  Plug 'w0rp/ale'                            " run prettier for js files
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
	Plug 'rhysd/vim-crystal'
  Plug 'iCyMind/NeoSolarized'
  Plug 'tpope/vim-commentary'                " gcc
    xmap <silent><Leader>c <Plug>Commentary
    nmap <silent><Leader>c <Plug>CommentaryLine
	Plug 'leafgarland/typescript-vim'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:mapleader = "\<Space>"
set background=dark
"set background=light
colorscheme NeoSolarized

" ; is easier than :
nnoremap ; :

" hh is easier than esc
inoremap hh <ESC>

" save on esc
inoremap <Esc> <Esc>:w<CR>

map <C-h> <Esc>:bp<CR>
map <C-t> <Esc>:bn<CR>

" F5 - toggle spell. hit ctrl+n to correct a spelling
noremap <F5> :call Spelling()<CR>

set clipboard=unnamed,unnamedplus
set number         " show line numbers
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse

set scrolloff=3       " always keep cursor 3 lines from the top and bottom
set virtualedit=onemore " allow the cursor to move just past the end of the line
set undolevels=5000     " set maximum undo levels
set nobackup            " no backup files

" Go
" not sure
" set autowrite
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <F9> <Plug>(go-def)
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1 "Show type information in status line
"""

" Rust
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"""

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

" ignore pattern for wildmenu
" try this:
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set wildignore+=node_modules/*      " ignores node_modules
set wildignore+=build/*      " ignores node_modules
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

" (perfermance improvement) only syntax highlighting the first 200 characters of each line
set synmaxcol=200

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set cursorline

" Disable search highlighting with esc
nnoremap <silent> <esc> :silent :nohlsearch<cr>

set noexpandtab   " Use tabs
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)

" search
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on

" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"open all files in a dir where current file is
" nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
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

set autoread


" When this is enabled the Go imports doesn't work
" Autosave will automatically save to disk the currently edited buffer upon leaving insert mode as well as after a text edit has occurred.
" Autoread will automatically update an open buffer if it has been changed outside the current edit session, usually by an external program.
" augroup autoSaveAndRead
"     autocmd!
"     autocmd TextChanged,InsertLeave,FocusLost * silent! wall
"     autocmd CursorHold * silent! checktime
" augroup END


" ALE Plugin
let g:ale_linters_explicit = 1
let g:ale_javascript_prettier_options = '--single-quote --no-semi'
let g:ale_fixers = { 'javascript': ['prettier'], 'css': ['prettier'], }
let g:ale_linters = { 'javascript': ['eslint'], }
let g:ale_fix_on_save = 1 "run it on save

" equalize Vim splits that have been munged by some type of resize event
autocmd VimResized * wincmd =

" Toggle spelling mode and add the dictionary to the completion list of
" sources if spelling mode has been entered, otherwise remove it when
" leaving spelling mode.
"
function! Spelling()
    setlocal spell!
    if &spell
        set complete+=kspell
        echo "Spell mode enabled"
    else
        set complete-=kspell
        echo "Spell mode disabled"
    endif
endfunction

" navigate in the quickfix list with ctr+n, ctr+p, and leader a
map <C-n> :cnext<CR>
" when this is enabled, everytime i hit enter I see 'E42: No Error'
" map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" use quickfix instead of location lists
let g:go_list_type = "quickfix"

" treat all *.svelte files as HTML
au! BufNewFile,BufRead *.svelte set ft=html

" fix bug with svelte/sapper - https://github.com/rollup/rollup/issues/2988
set backupcopy=yes

" autocmd BufNewFile,BuRead *.txt setlocal spell spelllang=en_us
" :setlocal spell spelllang=en_us
" :setlocal nospell

" this line set some stuff only for this file
" vim: set sw=2 ts=2 et foldlevel=99 foldmethod=marker:

" TIPS & TRICKS
"
" Useful insert mode commands:
"   Ctrl-o       for one time normal mode command (zz being most useful)
"   Ctrl-r<reg>  for insertion from a named register
"   Ctrl-b       delete backward a word
"   Ctrl-r=      expression register (eg 43 + 44 --> 87)
"
" Useful cursor positioning and movement commands:
"   zt      move text under cursor to the top
"   zz      move text under cursor to the center
"   zb      move text under cursor to the bottom
"   zl      move text under cursor one character to the left
"   zL      move text under cursor half a screen to the left
"   H       move to top of screen
"   M       move to middle of screen
"   L       move to end of screen
"   g;      move back to where you were last editing
"   mm      set a mark in the current file
"   'm      return back to 'm' mark in the current file
"   mM      set a global mark
"   'M      return back to the global 'M' mark
"   {/}     move between paragraphs
"   (/)     move between sentences
"   ge/gE   move to the end of the previous word/WORD
"   Ctrl-e  scroll file up one line at a time
"   Ctrl-y  scroll file down one line at a time
"
" Completion sub-types when in insert completion-mode initiated via Ctrl-x:
"   Ctrl-f  file name completion based on files in the CWD
"   Ctrl-k  dictionary completion
"   Ctrl-l  line completion
"   Ctrl-o  omni completion
"   Ctrl-]  tag completion
"
" Spelling commands:
"   z=      Suggest spelling correction
"   ]s      Move to next spelling error
"   [s      Move to previous spelling error
"   zg      Add current word to dictionary
"   zw      Delete current word from dictionary
"
" Tag navigation:
"   Ctrl-]  find definition under cursor
"   Ctrl-o  return back from definition
"
" Visual mode commands:
"   gv           repeat last visual selection
"   u/U          change visual selection to lower or upper case
"   vip/vap      visual select paragraph
"   vis/vas      visual select sentence
"   vit/vat      visual select tag
"   :'<,'>!sort  sort visual selection
"   :'<,'>!uniq  uniq visual selection
"   gx           open link in a browser
"
" Substitute in visual block:
"   '<,'>s/\%Vfoo/bar/c
"
" Misc commands:
"   X                  delete backwards
"   gf                 go to file under cursor
"   gq                 format text
"   :r !ls *.txt       read in selected filenames
"   /<term>            search forward for 'term'
"   ?<term>            search backward for 'term'
"   :%s//<new>         replace last search 'term' with 'new'
"   :%s//<new>/c       replace, with confirmation, last search 'term' with 'new'
"   :%s///n            list match count for the last search
"   :g/<pattern>       list all lines containing 'pattern'
"   :g/<pattern>/d     delete all lines containing 'pattern'
"   :v/<pattern>       list all lines NOT containing 'pattern'
"   :v/<pattern>/d     delete all lines NOT containing 'pattern'
"   :g/<pattern/normal @q execute macro 'q' over all lines that match pattern
"
"   /<term>            search for 'term'
"   cgn                replace last search match
"   dgn                delete last search match
"   .                  repeat last change
"
"   % vim $(find **/*.txt)  edit all txt files from the current path down
"   % vim $(ag -l foo)      edit all files that contain foo
"
"   % cat do.vim
"   :%s/term/new/g
"   :wq
"   % vim -es file.txt < do.vim  'sed' style scripted edits
"
"   :h digraph-table             list all displayable characters
"
"   :syntime on      start syntax performance monitoring
"   :syntime report  display sorted list of expensive syntax patterns
"
"   :term            start nvim terminal
"
" Plugin details:
"
"   vim-grepper.vim:
"     '-G extension$ <searchterm>' to restrict ag to a particular file extension
"     '-t<type> <searchterm>' to restrict rg to a particular file type
"
"   vim-bundler:
"     Run 'gem ctags' to generate ctags for installed gems (required just once).
"
"   vim-rails:
"     Use a visual selection in conjunction with ':Rextract <<partial-name>>'
"     to move a block of code from a view to a new partial.
"
"   vim-abolish:
"     :S/<pattern>                     - smartly search for pattern
"
"     :%S/facilit{y,ies}/building{,s}/ - change all facilities to buildings
"     :%S/old_name/new_description/    - old_name --> new_description
"                                        OldName  --> NewDescription
"     :%S/h{2,3}/h{3,2}/               - change all h2 to h3
"
"     crs - change to snake_case
"     crc - change to camelCase
"     crm - change to MixCase
"
"     ~/dotfiles/vim/after/plugin/abolish.vim - list of abbreviations
"
"   vim-commentary:
"     gc                 - comment out a visual block
"
"   vim-surround:
"     Normal mode:
"       ds<surround>     - delete a surround
"       cs<old><new>     - change a surround
"       ysiw<surround>   - add a surround to the current word
"
"     Visual mode:
"       S                - add a surround
"
"     Insert mode:
"       <CTRL-s>         - add a surround
"       <CTRL-s><CTRL-s> - add a new line + surround + indent
"
"
