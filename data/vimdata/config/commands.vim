let g:file_jumper_command = {
            \ "Gbin": {'dir': expand("$HOME/bin")},
            \ "Gwiki": {'dir': g:myvimwikidir, 'keymap': '<Leader>wg'},
            \ "Gvimconfig": {'dir': expand('$VIMCONFIG'), 'keymap': ',gv'},
            \ "Gftplugin": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/ftplugin")},
            \ "Gsnips": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/MyCusSnips")},
            \ }

function! s:DefineDirFileCompletionCommand()
	for cmd in keys(g:file_jumper_command)
		execute(printf("command! -nargs=0 %s CtrlP %s", cmd, g:file_jumper_command[cmd].dir))
		if has_key(g:file_jumper_command[cmd], 'keymap')
			execute(printf('nmap %s :%s<cr>', g:file_jumper_command[cmd].keymap, cmd))
		endif
	endfor
endfunction

call s:DefineDirFileCompletionCommand()

" RD report "{{{
" command! -nargs=0 TSReport RE 201 ~/gitlab/rd/ts_regression/report/
" command! -nargs=0 APIReport RE 201 ~/gitlab/rd/api_regression/report/

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
	call system(printf('slack-cli -d %s -f %s &', a:username, expand('%')))
endfunction

command! -nargs=1 SlackSend call SlackSendToUser(<f-args>)
"}}}

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
    if ! exists('b:nvr')
        return
    endif

	let resCode = 0
	if a:0 > 0
		let resCode = a:1
	endif

	" w
    for chanid in b:nvr
        silent! call rpcnotify(chanid, 'Exit', resCode)
    endfor

    if bufnr('#') != bufnr('%')
        e # | bd #
    endif
endfunction

command! -nargs=? NvrReturn call NvrReturn(<f-args>)
autocmd! BufWritePost * call NvrReturn()

" Remote "{{{
function! EditRemoteFile(file_url)
    let host_file = split(a:file_url, ':')
    execute('tabnew scp://' .host_file[0]. '/' .host_file[1])
endfunction

function! SshHostCompletionList(lead, cmdline, ...) abort
    let ssh_hosts = system('grep -w -i "Host" ~/.ssh/config | sed "s/Host//" | xargs -n1')
    let hosts_list = split(ssh_hosts)

    return filter(hosts_list, 'v:val =~ a:lead')
endfunction

command! -nargs=+ -complete=customlist,SshHostCompletionList EditRemote call EditRemoteFile(<f-args>)
command! -nargs=+ -complete=customlist,SshHostCompletionList Scp Dispatch scp % <f-args>
"}}}

" kubernetes "{{{
function! EnablePlugins(plugin_list)
    execute(printf("silent PlugLoad %s", join(a:plugin_list)))

    if exists(":CmdPaletteReload")
        silent CmdPaletteReload
    endif
endfunction

command! -nargs=0 EnableKubernetes call EnablePlugins(["helper.vim", "treemenu.vim", "vikube.vim"])
"}}}

" vim:fdm=marker:
