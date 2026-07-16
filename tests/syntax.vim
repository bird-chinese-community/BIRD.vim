set nomore
syntax enable

new
execute 'source ' . fnameescape(getcwd() . '/syntax/bird2.vim')
call setline(1, [
  \ 'mac set allowed = [ 02:00:00:00:00:01 ];',
  \ 'int flags = (ifindex | 2) & 7;',
  \ 'if ready && enabled || fallback then accept;',
  \ 'local_metric = bgp_unknown_0x2a;',
  \ 'proto_protocol_type = AF_IPV6;',
  \ 'kbr_source = KBR_SRC_DYNAMIC;',
  \ 'debug events;',
  \ 'trie yes;',
  \ ])

function! s:Group(line, needle) abort
  let l:column = stridx(getline(a:line), a:needle) + 1
  return synIDattr(synID(a:line, l:column, 1), 'name')
endfunction

call assert_equal('bird2Type', s:Group(1, 'mac set'), 'mac set type')
call assert_equal('bird2Bitwise', s:Group(2, '|'), 'bitwise or')
call assert_equal('bird2Bitwise', s:Group(2, '&'), 'bitwise and')
call assert_equal('bird2Logical', s:Group(3, '&&'), 'logical and remains intact')
call assert_equal('bird2Logical', s:Group(3, '||'), 'logical or remains intact')
call assert_equal('bird2RouteAttr', s:Group(4, 'local_metric'), 'BIRD 3 local metric')
call assert_equal('bird2RouteAttr', s:Group(4, 'bgp_unknown_0x2a'), 'unknown BGP attr')
call assert_equal('bird2RuntimeAttr', s:Group(5, 'proto_protocol_type'), 'runtime attr')
call assert_equal('bird2AddressFamilyConst', s:Group(5, 'AF_IPV6'), 'address family enum')
call assert_equal('bird2BridgeSourceConst', s:Group(6, 'KBR_SRC_DYNAMIC'), 'bridge enum')
call assert_equal('bird2DiagnosticsPhraseKw', s:Group(7, 'debug'), 'debug CLI phrase')
call assert_equal('bird2TablePhraseKw', s:Group(8, 'trie'), 'trie table option')

if !empty(v:errors)
  for error in v:errors
    echomsg error
  endfor
  cquit
endif

qa!
