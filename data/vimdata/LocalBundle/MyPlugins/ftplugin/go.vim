if exists('b:loaded_go_vim')
    finish
endif
let b:loaded_go_vim = 1

setl fdm=syntax

function! GoDebugRun()
	let b:binary_filename = expand('%:p:r') . '.bin'
	let &makeprg = printf("go build -gcflags '-N -l' -o %s %s", b:binary_filename, expand('%:p'))
    execute "silent make!"

    if !filereadable(b:binary_filename)
        execute "copen"
        return -1
    endif

	if has('nvim')
		silent execute "GdbStart " . b:binary_filename
	endif
endfunction

map <buffer> <silent> ,rr :up<cr>:GoRun<cr>
" nmap <buffer> <silent> ,rd :call GoDebugRun()<cr>
nmap <buffer> <silent> ,rd :up<cr>:GoDebug!<cr>
nmap <buffer> <silent> ,rb :up<cr>:GoBuild<cr>
nmap <buffer> <silent> ,rf :up<cr>:call util#WinRun('go run')<cr>
map <buffer> <silent> ,rt :GoTest<cr>
map <buffer> <silent> ,gi :GoImports<cr>
" nmap <buffer> <silent> gd :GoDef<CR>

command! -buffer -nargs=0 -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -buffer -nargs=0 -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -buffer -nargs=0 -bang AS call go#alternate#Switch(<bang>0, 'split')

map <buffer> <Leader>ve :let g:EasyGrepFilesToExclude = "*.swp,tags,*_test.go"<cr>:echomsg g:EasyGrepFilesToExclude<cr>
map <buffer> <Leader>vE :let g:EasyGrepFilesToExclude = "*.swp,tags"<cr>:echomsg g:EasyGrepFilesToExclude<cr>

if exists('g:EasyGrepFilesToExclude')
	let origin_exclude = g:EasyGrepFilesToExclude
endif
