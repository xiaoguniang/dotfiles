" RD report "{{{
command! -nargs=0 TSReport RE 201 ~/gitlab/rd/ts_regression/report/
command! -nargs=0 APIReport RE 201 ~/gitlab/rd/api_regression/report/

function! CopyNonFolded() range 
	let lnum= a:firstline 
	let buffer=[] 
	while lnum <= a:lastline 
		if (foldclosed(lnum) == -1) 
			let buffer += getline(lnum, lnum) 
			let lnum += 1 
		else 
			let buffer += [ foldtextresult(lnum) ] 
			let lnum = foldclosedend(lnum) + 1 
		endif 
	endwhile 
	top new 
	set bt=nofile 
	call append(".",buffer) 
	0d_ 
endfu 

com! -range=% CopyFolds :<line1>,<line2>call CopyNonFolded() 
vmap ,zy :CopyFolds<cr>
"}}}

function! OpenFile(filepath, args)
	let cmd = ":tabnew"
	if len(a:args) > 0
		let cmd = join(a:args)
	endif
	execute(cmd ." ". a:filepath)
endfunction

" goto vimconfig files "{{{
function! ListDirItems(lead, ...) abort
	let default_complete_dir = expand('$VIMCONFIG')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gvimconfig(...)
	let filepath = printf("%s/%s.vim", expand("$VIMCONFIG"), a:1)
	call OpenFile(filepath, a:000[1:])
endfunction

command! -nargs=+ -bar -complete=customlist,ListDirItems Gvimconfig  call Gvimconfig(<f-args>)
map ,gv :Gvimconfig 
"}}}

" vimwiki "{{{
function! ListWikiItems(lead, ...) abort
  return map(split(globpath(g:myvimwikidir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Vwiki(...)
	let filepath = printf("%s/%s.wiki", g:myvimwikidir, a:1)
	call OpenFile(filepath, a:000[1:])
endfunction

command! -nargs=+ -bar -complete=customlist,ListWikiItems Gwiki call Vwiki(<f-args>)
nmap <leader>wg :Gwiki 
"}}}

function! EditBinaryFile(...)
	let cmd = "tabnew"
	if a:0 > 1
		let cmd = join(a:000[1:])
	endif
	let cmd = cmd . '| Vinarise'
	execute(printf("%s %s", cmd, a:1))
endfunction

command! -nargs=+ -complete=file BinEdit call EditBinaryFile(<f-args>)

" gotto ultisnips files "{{{
function! ListSnipItems(lead, ...) abort
	let default_complete_dir = expand('$CUSDATA/LocalBundle/MyPlugins/MyCusSnips')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gusnips(...) abort
	let filepath = expand("$CUSDATA/LocalBundle/MyPlugins/MyCusSnips") ."/". a:1 . '.snippets'
	call OpenFile(filepath, a:000[1:0])
endfunction

command! -nargs=+ -bar -complete=customlist,ListSnipItems Gusnips  call Gusnips(<f-args>)
map ,gu :Gusnips 
"}}}

" AddBinary "{{{
function! ListBinItems(lead, ...) abort
	let default_complete_dir = expand('$HOME/bin')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gbin(...) abort
	let filepath = expand("$HOME/bin") ."/". a:1
	call OpenFile(filepath, a:000[1:0])
	if !filereadable(filepath)
		setl ft=sh
		execute(':AddHeader')
		execute(':w')
		call system('chmod +x ' .expand('%'))
	endif
endfunction

command! -nargs=+ -bar -complete=customlist,ListBinItems Gbin  call Gbin(<f-args>)
"}}}

" goto ftplugin files "{{{
function! ListFtpluginItems(lead, ...) abort
	let default_complete_dir = expand('$CUSDATA/LocalBundle/MyPlugins/ftplugin')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gftplugin(...) abort
	let filepath = expand("$CUSDATA/LocalBundle/MyPlugins/ftplugin") ."/". a:1 . '.vim'
	call OpenFile(filepath, a:000[1:0])
endfunction

command! -nargs=+ -bar -complete=customlist,ListFtpluginItems Gftplugin call Gftplugin(<f-args>)
"}}}

" slack "{{{
function! SlackSendToUser(username)
	call system(printf('slacksend -u %s -t %s %s &', a:username, &ft, expand('%')))
endfunction

command! -nargs=1 SlackSend call SlackSendToUser(<f-args>)
"}}}

" vim:fdm=marker:
