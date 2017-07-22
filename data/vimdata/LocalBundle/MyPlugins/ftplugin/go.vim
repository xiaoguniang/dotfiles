if exists('b:loaded_go_vim')
    finish
endif
let b:loaded_go_vim = 1

setl fdm=syntax

map <buffer> <silent> ,rr :call WinRun("go run")<cr>
map <buffer> <silent> ,gi :GoImports<cr>
map <buffer> <silent> ,rt :GoTest<cr>
nmap <buffer> <silent> gd :GoDef<CR>

command! -buffer -nargs=0 -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -buffer -nargs=0 -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -buffer -nargs=0 -bang AS call go#alternate#Switch(<bang>0, 'split')

map <buffer> <Leader>ve :let g:EasyGrepFilesToExclude = "*.swp,tags,*_test.go"<cr>:echomsg g:EasyGrepFilesToExclude<cr>
map <buffer> <Leader>vE :let g:EasyGrepFilesToExclude = "*.swp,tags"<cr>:echomsg g:EasyGrepFilesToExclude<cr>

if exists('g:EasyGrepFilesToExclude')
	let origin_exclude = g:EasyGrepFilesToExclude
endif
