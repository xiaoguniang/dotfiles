if exists('g:paste_loaded')
	finish
endif
let g:paste_loaded = 1

function! paste#from_clipboard(filetype, cmd)
    let type = a:filetype

    if empty(type)
        let type = "txt"
    endif
	
	let option_paste = &paste
	execute a:cmd | set nopaste | 0put *
	let &filetype = type
	let &paste = option_paste

    setlocal bufhidden=hide
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal foldcolumn=0
    setlocal nofoldenable
    setlocal nonumber
    setlocal noswapfile
    setlocal winfixheight
    setlocal winfixwidth
endfunction

command! -nargs=? TPaste call paste#from_clipboard("<f-args>", "tabnew")
command! -nargs=? Paste call paste#from_clipboard("<f-args>", "new")
command! -nargs=? VPaste call paste#from_clipboard("<f-args>", "vnew")
command! -nargs=? SPaste call paste#from_clipboard("<f-args>", "new")
