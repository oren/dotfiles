"=============================================================================
" File: gist.vim
" Author: Yasuhiro Matsumoto <mattn.jp@gmail.com>
" WebPage: http://github.com/mattn/gist-vim
" License: BSD
" GetLatestVimScripts: 2423 1 :AutoInstall: gist.vim
" script type: plugin

if &cp || (exists('g:loaded_gist_vim') && g:loaded_gist_vim)
  finish
endif
let g:loaded_gist_vim = 1

if (!exists('g:github_user') || !exists('g:github_token')) && !executable('git')
  echohl ErrorMsg | echomsg "Gist: require 'git' command" | echohl None
  finish
endif

if !executable('curl')
  echohl ErrorMsg | echomsg "Gist: require 'curl' command" | echohl None
  finish
endif

command! -nargs=? -range=% Gist :call gist#Gist(<count>, <line1>, <line2>, <f-args>)

" vim:set et:
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

