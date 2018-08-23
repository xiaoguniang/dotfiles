if exists('b:loaded_java_vim')
    finish
endif
let b:loaded_java_vim = 1

let b:binary_filename = expand('%:p:r') . '.class'

function! s:CompileJava() "{{{
	if &modified | w | endif

    if filereadable(b:binary_filename) && delete(b:binary_filename)
		set makeprg=make
    endif

    let &makeprg = "javac %"
    execute "silent make!"
    
    if !filereadable(b:binary_filename)
        execute "copen"
        return -3
    endif

    return 0
endfunction "}}}

function! s:NormalRunJava() "{{{
    if s:CompileJava() < 0 | return | endif
	let binary = b:binary_filename
    call util#WinRun("java " .expand('%:r'))
endfunction "}}}

nmap <buffer> <silent> ,rr :call <SID>NormalRunJava()<cr>
