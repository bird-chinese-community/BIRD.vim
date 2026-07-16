augroup bird2_ftdetect
  autocmd!

  " Filename-based detection. Keep patterns specific enough to avoid files
  " such as bluebird.conf or hummingbird.conf.
  autocmd BufRead,BufNewFile *.bird,*.bird2,*.bird3 setfiletype bird2
  autocmd BufRead,BufNewFile bird.conf,bird2.conf,bird3.conf,bird6.conf setfiletype bird2
  autocmd BufRead,BufNewFile bird-*.conf,bird_*.conf,bird.*.conf setfiletype bird2
  autocmd BufRead,BufNewFile *.bird.conf,*.bird2.conf,*.bird3.conf setfiletype bird2
  autocmd BufRead,BufNewFile */bird/*.conf,*/bird2/*.conf,*/bird3/*.conf setfiletype bird2

  function! s:SetBird2Filetype() abort
    if &l:filetype ==# 'conf'
      setlocal filetype=bird2
    else
      setfiletype bird2
    endif
  endfunction

  function! s:Bird2MaybeSetFiletype() abort
    if !get(g:, 'bird2_heuristic_detect', 1)
      return
    endif

    if &l:filetype !=# '' && &l:filetype !=# 'conf'
      return
    endif

    let l:max_lines = min([200, line('$')])
    if l:max_lines <= 0
      return
    endif

    let l:protocols = '\%(aggregator\|babel\|bfd\|bgp\|bmp\|bridge\|device\|direct\|evpn\|kernel\|l3vpn\|mrt\|ospf\|perf\|pipe\|radv\|rip\|rpki\|static\)'
    let l:strong_patterns = [
      \ '^\s*router\s\+id\>',
      \ '^\s*\%(protocol\|template\)\s\+' . l:protocols . '\>',
      \ '^\s*\%(ipv4\|ipv6\|vpn4\|vpn6\|flow4\|flow6\|roa4\|roa6\|eth\|aspa\|evpn\|mpls\|neighbor\)\s\+table\>',
      \ '^\s*ipv6\s\+sadr\s\+table\>',
      \ ]
    let l:signal_patterns = {
      \ 'filter': '^\s*filter\s\+\S\+',
      \ 'function': '^\s*function\s\+\S\+',
      \ 'define': '^\s*define\s\+\S\+\s*=',
      \ 'table': '^\s*table\s\+\S\+\s*{',
      \ 'policy': '^\s*\%(import\|export\)\s\+\%(all\|none\|filter\|where\)\>',
      \ 'decision': '^\s*\%(accept\|reject\)\s*;',
      \ 'include': '^\s*include\s\+["'']',
      \ }
    let l:seen = {}
    let l:score = 0
    let l:in_block_comment = 0

    for l:lnum in range(1, l:max_lines)
      let l:line = getline(l:lnum)

      if l:in_block_comment
        if l:line !~# '\*/'
          continue
        endif
        let l:line = substitute(l:line, '^.*\*/', '', '')
        let l:in_block_comment = 0
      endif

      if l:line =~# '/\*'
        if l:line !~# '\*/'
          let l:in_block_comment = 1
        endif
        let l:line = substitute(l:line, '/\*.*\%\(\*/\|$\)', '', 'g')
      endif

      let l:line = substitute(l:line, '#.*$', '', '')
      if l:line =~# '^\s*$'
        continue
      endif

      for l:pattern in l:strong_patterns
        if l:line =~? l:pattern
          call s:SetBird2Filetype()
          return
        endif
      endfor

      for [l:name, l:pattern] in items(l:signal_patterns)
        if !has_key(l:seen, l:name) && l:line =~? l:pattern
          let l:seen[l:name] = 1
          let l:score += 1
          if l:score >= 2
            call s:SetBird2Filetype()
            return
          endif
        endif
      endfor
    endfor
  endfunction

  autocmd BufRead,BufNewFile,BufWritePost *.conf call s:Bird2MaybeSetFiletype()
  autocmd FileType conf call s:Bird2MaybeSetFiletype()
augroup END
