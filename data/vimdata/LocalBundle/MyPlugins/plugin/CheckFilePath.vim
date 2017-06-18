if exists('g:loaded_checkfilepath')
    finish
endif
let g:loaded_checkfilepath= 1

function! s:ShowColorMsg(msg)
	echohl WarningMsg | echomsg a:msg | echohl None
endfunction

function! CheckFilePath(...)
    if a:0 == 0
        let s:filename = expand(expand('<cfile>:p'))
    else
        let s:filename = expand(a:1)
    endif

    if isdirectory(s:filename)
		call s:ShowColorMsg("Directory: " . s:filename)
	elseif filewritable(s:filename)
		call s:ShowColorMsg("FW: " . s:filename)
    elseif filereadable(s:filename)
        call s:ShowColorMsg("FR: " . s:filename)
    else
		echohl ErrorMsg | echomsg "Not Exist or Can't Read: " . s:filename | echohl None
    endif
endfunction

command! -nargs=? CheckPath :call CheckFilePath(<f-args>)
