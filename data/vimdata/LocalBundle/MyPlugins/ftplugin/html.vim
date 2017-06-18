function! LiveServer()
	let res = globpath(getcwd(), expand('%'))

	if !empty(res)
		execute('Dispatch live-server --open=' .expand('%'))
	else
		execute('Dispatch live-server --open=' .expand('%:t'). ' ' .expand('%:p:h'))
	endif
endfunction

command! -nargs=0 LiveServer call LiveServer()

if &ft == "html"
	nmap <buffer> <silent> ,rr :LiveServer<cr>
endif
