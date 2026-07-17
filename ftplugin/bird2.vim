" BIRD 2/3 filetype plugin
" Language: BIRD 2/3 Configuration
" License:  MPL-2.0
" Author:   BIRD Chinese Community

" Only load this file once
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Set comment format
setlocal comments=:#
setlocal commentstring=#\ %s

" Format options
setlocal formatoptions-=t formatoptions+=croql

" Make sure syntax highlighting is enabled
if exists("g:syntax_on")
  syntax sync fromstart
endif

function! s:ToggleCommentLine(lnum) abort
  let l:line = getline(a:lnum)

  if l:line =~# '^\s*#'
    call setline(a:lnum, substitute(l:line, '^\(\s*\)#\s\?', '\1', ''))
    return
  endif

  let l:indent = matchstr(l:line, '^\s*')
  call setline(a:lnum, l:indent . '# ' . strpart(l:line, strlen(l:indent)))
endfunction

function! s:ToggleCommentRange(first, last) abort
  for l:lnum in range(a:first, a:last)
    call s:ToggleCommentLine(l:lnum)
  endfor
endfunction

" Provide stable <Plug> mappings and only claim <Leader>c when it is unused.
nnoremap <silent> <buffer> <Plug>Bird2Comment :<C-U>call <SID>ToggleCommentLine(line('.'))<CR>
xnoremap <silent> <buffer> <Plug>Bird2Comment :<C-U>call <SID>ToggleCommentRange(line("'<"), line("'>"))<CR>

let b:undo_ftplugin = 'setlocal comments< commentstring< formatoptions< matchpairs< omnifunc<'
      \ . ' | silent! nunmap <buffer> <Plug>Bird2Comment'
      \ . ' | silent! xunmap <buffer> <Plug>Bird2Comment'

if empty(maparg('<Leader>c', 'n'))
  nmap <silent> <buffer> <Leader>c <Plug>Bird2Comment
  let b:undo_ftplugin .= ' | silent! nunmap <buffer> <Leader>c'
endif

if empty(maparg('<Leader>c', 'x'))
  xmap <silent> <buffer> <Leader>c <Plug>Bird2Comment
  let b:undo_ftplugin .= ' | silent! xunmap <buffer> <Leader>c'
endif

" Set 'matchpairs' for BIRD2 config braces
setlocal matchpairs+=(:),{:},[:]

" Omni completion function (can be extended)
setlocal omnifunc=syntaxcomplete#Complete
