" Helper function"{{{
function! ShowMsg(msg)
    echohl WarningMsg | echom a:msg | echohl None
endfunction

function! WindowMaxToggle()
    if !exists('w:winmax_height') || w:winmax_height < 0
        let w:winmax_height = winheight(0)
        res 1000
    else
        execute('res ' . w:winmax_height)
        let w:winmax_height = -1
    endif
endfunction

function! EditCmdOutFile(...)
    if a:0 < 1
        return 1
    endif

    let cmd = a:1
    if a:0 > 1
        let cmd .= ' ' . a:2
    endif

    execute('tabnew ' . system(cmd))
endfunction

function! EditRemoteFile(host, filename)
    execute('tabnew scp://' .a:host. '/' .a:filename)
endfunction

function! LoadLatestFile()
	let file_dir = expand("%:h")
	execute("lcd " .file_dir)
	let latest_file = system('ls -1t | head -1')

	if !empty(latest_file)
		execute("edit " .latest_file)
	endif
endfunction

function! CloseNeoTerminal()
	if exists(":TcloseAll")
		execute(":TcloseAll")
	endif
endfunction

function! WinRun(cmd, ...)
    let need_input = (a:0 >= 1) ? a:1 : 0

    let args = " "
    if need_input != 0
        let args .= input("Please input the arguments: ")
    endif

	call CloseNeoTerminal()
	let filename = expand('%')
	let old_dir = getcwd()
	cd %:p:h
	botright new | res 15 " | setl nonu | setl nornu
	call termopen(a:cmd ." ". filename. " " .args)
	execute("cd " .old_dir)
	startinsert
endfunction

command! -nargs=0 LatestFile call LoadLatestFile()
command! -nargs=+ RE call EditRemoteFile(<f-args>)
command! -nargs=? FWlog call EditCmdOutFile('fwlog <f-args>')
"}}}

 " vim:fdm=marker
