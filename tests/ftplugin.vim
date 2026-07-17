set nomore
let mapleader = ','

new
call setline(1, ['protocol bgp upstream {', '  ipv4;', '}'])
execute 'source ' . fnameescape(getcwd() . '/ftplugin/bird2.vim')

call assert_equal('# %s', &l:commentstring, 'comment string')
call assert_equal(':#', &l:comments, 'comments option')
call assert_equal('syntaxcomplete#Complete', &l:omnifunc, 'syntax completion')
call assert_match('<SNR>\d\+_ToggleCommentLine', maparg('<Plug>Bird2Comment', 'n'), 'normal plug mapping')
call assert_match('<SNR>\d\+_ToggleCommentRange', maparg('<Plug>Bird2Comment', 'x'), 'visual plug mapping')

call feedkeys("\<Plug>Bird2Comment", 'xt')
call assert_equal('# protocol bgp upstream {', getline(1), 'normal comment mapping')
call feedkeys("\<Plug>Bird2Comment", 'xt')
call assert_equal('protocol bgp upstream {', getline(1), 'normal uncomment mapping')
bwipeout!

new
nnoremap <buffer> <Leader>c :let g:bird2_preserved_mapping = 1<CR>
execute 'source ' . fnameescape(getcwd() . '/ftplugin/bird2.vim')
call assert_match('bird2_preserved_mapping', maparg('<Leader>c', 'n'), 'existing leader mapping is preserved')
bwipeout!

if !empty(v:errors)
  for error in v:errors
    echomsg error
  endfor
  cquit
endif

qa!
