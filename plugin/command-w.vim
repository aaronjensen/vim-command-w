" Author:   Nate Kane <nathanaelkane AT gmail DOT com>
" Homepage: http://github.com/nathanaelkane/vim-command-w

if exists('g:loaded_command_w') || &cp
  finish
endif
let g:loaded_command_w = 1

function s:BByeError()
  if !exists('g:command_w_bbye_error_shown')
    echoe 'Command-W requires the bbye plugin to be installed in order to operate correctly'
    let g:command_w_bbye_error_shown = 1
  endif
endfunction

function! s:CommandW()
  let l:bufcount = len(filter(range(1, bufnr('$')), 'buflisted(v:val) == 1'))

  if l:bufcount == 1
    qall
  else
    if exists('g:loaded_bbye')
      Bdelete

      " Close window if it has a buffer open that is open in another window
      let l:curbuf = bufnr('%')
      let l:wincount = 0
      let i = 1
      let buf = winbufnr(i)
      while buf != -1
        if buf == l:curbuf
          let l:wincount += 1
        endif
        let i = i + 1
        let buf = winbufnr(i)
      endwhile

      if l:wincount > 1
        quit
      endif
    else
      call s:BByeError()
      q
    endif
  endif
endfunction

command! -bar CommandW call s:CommandW()
