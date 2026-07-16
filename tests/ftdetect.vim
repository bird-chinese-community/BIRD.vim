set nomore
set shortmess+=I

execute 'source ' . fnameescape(getcwd() . '/ftdetect/bird2.vim')

function! s:CheckConf(lines, expected, label) abort
  let l:path = tempname() . '.conf'
  call writefile(a:lines, l:path)
  execute 'edit ' . fnameescape(l:path)
  call assert_equal(a:expected, &l:filetype, a:label)
  bwipeout!
  call delete(l:path)
endfunction

function! s:CheckNamed(filename, expected, label) abort
  let l:directory = tempname()
  call mkdir(l:directory, 'p')
  let l:path = l:directory . '/' . a:filename
  call writefile(['# filename detection'], l:path)
  execute 'edit ' . fnameescape(l:path)
  call assert_equal(a:expected, &l:filetype, a:label)
  bwipeout!
  call delete(l:path)
  call delete(l:directory, 'd')
endfunction

call s:CheckNamed('bird2.conf', 'bird2', 'exact BIRD filename is detected')
call s:CheckNamed('bluebird.conf', '', 'unrelated filename is not detected')

call s:CheckConf(['protocol evpn fabric {'], 'bird2', 'latest protocol is strong evidence')
call s:CheckConf(['protocol aggregator aggregate_routes {'], 'bird2', 'aggregator is detected')
call s:CheckConf(['table users {'], '', 'one generic table is insufficient')
call s:CheckConf(
  \ ['filter import_filter {', '  export all;'],
  \ 'bird2',
  \ 'two independent policy signals are sufficient',
  \ )

let g:bird2_heuristic_detect = 0
call s:CheckConf(['protocol bgp upstream {'], '', 'heuristic detection can be disabled')
unlet g:bird2_heuristic_detect

call s:CheckConf(
  \ repeat(['# ordinary configuration'], 200) + ['protocol bgp too_late {'],
  \ '',
  \ 'heuristic scan is bounded to 200 lines',
  \ )

new
setlocal filetype=json
call setline(1, ['protocol bgp upstream {'])
doautocmd BufRead preserved.conf
call assert_equal('json', &l:filetype, 'non-conf filetypes are preserved')
bwipeout!

new
setlocal filetype=conf
call setline(1, ['protocol bridge fabric {'])
doautocmd BufRead upgraded.conf
call assert_equal('bird2', &l:filetype, 'generic conf filetype is upgraded')
bwipeout!

if !empty(v:errors)
  for error in v:errors
    echomsg error
  endfor
  cquit
endif

qa!
