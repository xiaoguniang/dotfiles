" if exists('b:loaded_markdown_cleaver')
  " finish
" endif
" let b:loaded_markdown_cleaver = 1

function! s:ShowMsgHighlight(msg)
	echohl WarningMsg | echom a:msg | echohl None
endfunction

function! <SID>CompileMd()
	execute('lcd %:p:h')
	call system('cleaver ' .expand('%') . ' &')
	call s:ShowMsgHighlight("Compile complete !")
endfunction

function! <SID>ViewResult()
	execute('lcd %:p:h')
	call system('open ' .expand('%:p:r') . '.html')
	call s:ShowMsgHighlight("view result html !")
endfunction

nmap <nowait> <buffer> <silent> ,ll :call <SID>CompileMd()<cr>
" nmap <nowait> <buffer> <silent> ,rr :InstantMarkdownPreview<cr>
nmap <nowait> <buffer> <silent> ,rr :MarkdownPreview<cr>
nmap <nowait> <buffer> <silent> ,lv :call <SID>ViewResult()<cr>
command! -nargs=0 Gtoc call system('markdown-toc -i ' .expand('%'))
