" RulerStr() comes from http://www.vanhemert.co.uk/vim/vimacros/ruler2.vim
if exists('g:loaded_ColumonRuler')
    finish
endif
let g:loaded_ColumonRuler = 1

function! RulerStr()
  let columns = &columns
  let inc = 0
  let str = ""
  while (inc < columns)
    let inc10 = inc / 10 + 1
    let buffer = "."
    if (inc10 > 9)
      let buffer = ""
    endif
    let str .= "....+..." . buffer . inc10
    let inc += 10
  endwhile
  let str = strpart(str, 0, columns)
  return str
endfunction

let s:saved_stl = {}
function! s:ToggleRuler()
  let buf = bufnr('%')
  if has_key(s:saved_stl, buf)
    let &l:stl = s:saved_stl[buf]
    unlet s:saved_stl[buf]
  else
    let s:saved_stl[buf] = &l:stl
    setlocal stl=%{RulerStr()}
  endif
endfunction

nnoremap <silent> <Leader>sr :call <sid>ToggleRuler()<cr>
