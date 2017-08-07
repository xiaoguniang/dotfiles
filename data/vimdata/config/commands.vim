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

" goto vimconfig files "{{{
function! OpenFile(filepath, args)
	let cmd = ":tabnew"
	if len(a:args) > 1
		let cmd = join(a:args[1:])
	endif
	execute(cmd ." ". a:filepath)
endfunction

function! ListDirItems(lead, ...) abort
	let default_complete_dir = expand('$VIMCONFIG')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gvimconfig(...) abort
	let filepath = expand("$VIMCONFIG") ."/". a:1 . '.vim'
	call OpenFile(filepath, a:000)
endfunction

command! -nargs=+ -bar -complete=customlist,ListDirItems Gvimconfig  call Gvimconfig(<f-args>)
map ,gv :Gvimconfig 
"}}}

" gotto ultisnips files "{{{
function! ListSnipItems(lead, ...) abort
	let default_complete_dir = expand('$CUSDATA/LocalBundle/MyPlugins/MyCusSnips')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gusnips(...) abort
	let filepath = expand("$CUSDATA/LocalBundle/MyPlugins/MyCusSnips") ."/". a:1 . '.snippets'
	call OpenFile(filepath, a:000)
endfunction

command! -nargs=+ -bar -complete=customlist,ListSnipItems Gusnips  call Gusnips(<f-args>)
map ,gu :Gusnips 
"}}}


" goto ftplugin files "{{{
function! ListFtpluginItems(lead, ...) abort
	let default_complete_dir = expand('$CUSDATA/LocalBundle/MyPlugins/ftplugin')
	return map(split(globpath(default_complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Gftplugin(...) abort
	let filepath = expand("$CUSDATA/LocalBundle/MyPlugins/ftplugin") ."/". a:1 . '.vim'
	call OpenFile(filepath, a:000)
endfunction

command! -nargs=+ -bar -complete=customlist,ListFtpluginItems Gftplugin  call Gftplugin(<f-args>)
"}}}

" vim:fdm=marker:
