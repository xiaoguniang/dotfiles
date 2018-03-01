" if exists('b:loaded_haskell_vim')
    " finish
" endif
" let b:loaded_haskell_vim = 1

let b:binary_filename = expand('%:p:r') . '.bin'
let b:makeprg = "ghc % -o " . b:binary_filename

function! s:ErrReturn(msg)
	echohl ErrorMsg | echom a:msg | echohl None
	return -1
endfunction

function! s:NormalReturn(msg)
	echohl WarningMsg | echo a:msg | echohl None
	return 0
endfunction

function! <SID>CompileCCpp() "{{{
	if &modified | w | endif

    if filereadable(b:binary_filename) && delete(b:binary_filename)
		set makeprg=make
		return s:ErrReturn("Delete " . b:binary_filename . " failed")
    endif

    let &makeprg = b:makeprg
    execute "silent make!"
    
    if !filereadable(b:binary_filename)
        execute "copen"
        return -3
    endif

    return 0
endfunction "}}}

function! <SID>NormalRun() "{{{
    if s:CompileCCpp() < 0 | return | endif
	let binary = b:binary_filename
	botright new | res 12
	let cmd = binary ." ; if [[ $? == 139 ]]; then echo 'Segmentation Fault'; fi"
	call termopen(cmd)
	startinsert
endfunction "}}}

map <buffer> <silent> ,rr :call <SID>NormalRun()<CR>

" vim:fdm=marker:
