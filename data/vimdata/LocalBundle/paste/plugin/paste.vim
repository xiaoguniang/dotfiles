if exists('g:paste_loaded')
	finish
endif
let g:paste_loaded = 1

function! paste#from_clipboard(filetype, cmd)
	
	let option_paste = &paste
	execute a:cmd | set nopaste | 0put *
	let &filetype = a:filetype
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

command! -nargs=1 TPaste call paste#from_clipboard(<f-args>, "tabnew")
command! -nargs=1 Paste call paste#from_clipboard(<f-args>, "tabnew")
command! -nargs=1 VPaste call paste#from_clipboard(<f-args>, "vnew")
command! -nargs=1 SPaste call paste#from_clipboard(<f-args>, "new")
