com! -range=% CopyFolds :<line1>,<line2>call util#CopyNonFolded() 
vmap ,zy :CopyFolds<cr>

command! -nargs=+ -complete=file BinEdit call util#EditBinaryFile(<f-args>)

" slack "{{{
function! SlackSendToUser(username)
	call system(printf('slack-cli -d %s -f %s &', a:username, expand('%')))
endfunction

command! -nargs=1 SlackSend call SlackSendToUser(<f-args>)
"}}}

" capture "{{{
function! s:CaptureWithCmd(cmd, bang, ...)
	let default_cmd = "bel new"
	if exists('g:capture_open_command')
		let default_cmd = g:capture_open_command
	endif
	let g:capture_open_command = a:cmd

	execute(printf(':Capture%s %s', a:bang, join(a:000)))
    if winnr('$') > 1
        execute("resize " .min([line('$') + 1, winheight('.')]))
    endif
    set buflisted
	" resize min([line('$') + 1, winheight('.')])

	let g:capture_open_command = default_cmd
endfunction

autocmd FileType capture call LoadMotionMap()
command! -nargs=+ -bang -complete=shellcmd Ecapture call s:CaptureWithCmd('bel new', "<bang>", '!', <f-args>)
command! -nargs=+ -complete=shellcmd Evcapture call s:CaptureWithCmd('bel vnew', "<bang>", '!', <f-args>)
command! -nargs=+ -complete=shellcmd Etcapture call s:CaptureWithCmd('tabnew', "<bang>", '!', <f-args>)

command! -nargs=+ -complete=command Tcapture call s:CaptureWithCmd('tabnew', "<bang>", <f-args>)
"}}}

" man "{{{
command! -range=0 -complete=customlist,man#complete -nargs=* Tman execute(":tab Man " . <q-args>)
command! -range=0 -complete=customlist,man#complete -nargs=* Vman execute(":vertical botright Man " . <q-args>)
autocmd FileType man,capture nmap <buffer> g/ /^\v\s+
"}}}

command! -nargs=? NvrReturn call util#NvrReturn(<f-args>)
autocmd! BufWritePost * call util#NvrReturn()

" Remote "{{{
function! EditRemoteFile(file_url, ...)
    let host_file = split(a:file_url, ':')
	let port = ""
	if a:0 > 0
		let port = ":" .a:1
	endif
    execute(printf('tabnew scp://%s%s/%s', host_file[0], port, host_file[1]))
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

command! -nargs=0 LatestFile call util#LoadLatestFile()
command! -nargs=? FWlog call util#EditCmdOutFile('fwlog <f-args>')

command! -nargs=? PDate call util#TimestampToDate(<f-args>)

" vim:fdm=marker:
