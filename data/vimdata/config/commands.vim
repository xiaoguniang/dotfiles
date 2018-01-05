" dirfile completion "{{{
let g:dir_file_completion = {
			\ "Gbin": {'dir': expand("$HOME/bin"), 'extension': '', 'handler': 'ShFileHandler'},
			\ "Gwiki": {'dir': g:myvimwikidir, 'extension': '.wiki', 'keymap': '<Leader>wg'},
			\ "Gvimconfig": {'dir': expand('$VIMCONFIG'), 'extension': '.vim', 'keymap': ',gv'},
			\ "Gftplugin": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/ftplugin"), 'extension': '.vim'},
			\ "Gsnips": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/MyCusSnips"), 'extension': '.snippets'},
			\ "Gblog": {'dir': expand("$HOME/Projects/Hexo/blog/source/_posts"), 'extension': '.md'}
			\ }
"}}}

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

function! ShFileHandler(filepath)
	if !filereadable(a:filepath)
		setl ft=sh
		execute(':AddHeader')
		execute(':normal G')
	endif
endfunction

function! EditBinaryFile(...)
	let cmd = "tabnew"
	if a:0 > 1
		let cmd = join(a:000[1:])
	endif
	let cmd = cmd . '| Vinarise'
	execute(printf("%s %s", cmd, a:1))
endfunction

command! -nargs=+ -complete=file BinEdit call EditBinaryFile(<f-args>)

" slack "{{{
function! SlackSendToUser(username)
	call system(printf('slacksend -u %s -t %s %s &', a:username, &ft, expand('%')))
endfunction

command! -nargs=1 SlackSend call SlackSendToUser(<f-args>)
"}}}

function! OpenFile(filepath, args)
	let cmd = ":tabnew"
	if len(a:args) > 0
		let cmd = join(a:args)
	endif
	execute(cmd ." ". a:filepath)
endfunction

function! DirFileCompletionList(lead, cmdline, ...) abort
	let cmd = split(a:cmdline)[0]
	if has_key(g:dir_file_completion, cmd)
		let complete_dir = g:dir_file_completion[cmd].dir
	endif

	return map(split(globpath(complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! GotoDirItem(cmdname, ...)
	if !has_key(g:dir_file_completion, a:cmdname)
		echoerr printf('Could not find %s setting!', a:cmdname)
	endif

	let completion_entry = g:dir_file_completion[a:cmdname]
	let dir = completion_entry.dir
	let extension = completion_entry.extension

	let filepath = printf("%s/%s%s", dir, a:1, extension)
	call OpenFile(filepath, a:000[1:])

	if !has_key(completion_entry, 'handler') | return | endif
	execute(printf("call %s('%s')", completion_entry.handler, filepath))
endfunction

function! DefineDirFileCompletionCommand()
	if !exists('g:dir_file_completion') | return | endif

	for cmd in keys(g:dir_file_completion)
		execute(printf("command! -nargs=+ -bar -complete=customlist,DirFileCompletionList %s call GotoDirItem('%s', <f-args>)", cmd, cmd))
		if has_key(g:dir_file_completion[cmd], 'keymap')
			execute(printf('nmap %s :%s ', g:dir_file_completion[cmd].keymap, cmd))
		endif
	endfor
endfunction

call DefineDirFileCompletionCommand()

function! CaptureWithCmd(cmd, bang, ...)
	let default_cmd = "bel new"
	if exists('g:capture_open_command')
		let default_cmd = g:capture_open_command
	endif
	let g:capture_open_command = a:cmd

	execute(printf(':Capture%s %s', a:bang, join(a:000)))
	execute("resize " .min([line('$') + 1, winheight('.')]))
	" resize min([line('$') + 1, winheight('.')])

	let g:capture_open_command = default_cmd
endfunction

" capture "{{{
autocmd FileType capture call LoadMotionMap()
command! -nargs=+ -bang -complete=shellcmd Ecapture call CaptureWithCmd('bel new', "<bang>", '!', <f-args>)
command! -nargs=+ -complete=shellcmd Evcapture call CaptureWithCmd('bel vnew', "<bang>", '!', <f-args>)
command! -nargs=+ -complete=shellcmd Etcapture call CaptureWithCmd('tabnew', "<bang>", '!', <f-args>)

command! -nargs=+ -complete=command Tcapture call CaptureWithCmd('tabnew', "<bang>", <f-args>)
"}}}

" man "{{{
" function! s:NewTabManPage()
	
" endfunction
command! -range=0 -complete=customlist,man#complete -nargs=* Tman execute(":tab Man " . <q-args>)
command! -range=0 -complete=customlist,man#complete -nargs=* Vman execute(":vertical botright Man " . <q-args>)
autocmd FileType man,capture nmap <buffer> g/ /^\v\s+
"}}}

function! NvrReturn(...)
	let resCode = 0
	if a:0 > 0
		let resCode = a:1
	endif

	w
	if exists('b:nvr')
		for chanid in b:nvr
			silent! call rpcnotify(chanid, 'Exit', resCode)
		endfor
	endif
	e # | bd #
endfunction

command! -nargs=? NvrReturn call NvrReturn(<f-args>)
autocmd! FileType gitcommit
            \ autocmd! BufWritePost <buffer> NvrReturn
" autocmd! BufWritePost NvrReturn

" vim:fdm=marker:
