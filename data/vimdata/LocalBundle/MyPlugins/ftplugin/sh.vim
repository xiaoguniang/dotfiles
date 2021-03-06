if exists('b:loaded_sh_vim')
    finish
endif
let b:loaded_sh_vim = 1

function! RunScript()
	let shell_cmd = expand("$SHELL") ." ". expand('%')
	botright new | res 15
	call termopen(shell_cmd)
	startinsert
endfunction

function! AddExecutePerm()
	if getfperm('.') =~ 'x'
		return
	endif
	call system('chmod +x' .expand('%'))
endfunction

let b:did_indent = 1

autocmd! BufWritePost call AddExecutePerm()

map <buffer> <silent> ,rr :call RunScript()<cr>
