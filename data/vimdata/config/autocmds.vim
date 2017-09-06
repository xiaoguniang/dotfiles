autocmd BufWritePost .vimrc source ~/.vimrc
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd FileType tex setl sw=2 " | setl iskeyword+=:
" autocmd BufReadPost *.txx setl ft=cpp " | setl iskeyword+=:
autocmd FileType html setl sw=2 | setl fdm=syntax
autocmd FileType json,ruby setl fdm=syntax

let g:extension_filtype_map = {
			\ "*.pem,*.cert": "cert",
			\ "*.txx": "cpp"
			\ }

function! SetFileTypes()
	if !exists('g:extension_filtype_map')
		return
	endif

	for [key, value] in items(g:extension_filtype_map)
		execute(printf(":autocmd BufReadPost %s setfiletype %s", key, value))
	endfor
endfunction

call SetFileTypes()

autocmd BufReadPost *.bin Vinarise

" restore cursor position
autocmd bufreadpost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

" vim:fdm=marker:
