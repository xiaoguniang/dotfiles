" Helper function"{{{
function! ShowMsg(msg)
    echohl WarningMsg | echom a:msg | echohl None
endfunction

function! DecodeBase64Str(type, ...)
    let reg_save = @@
    if a:0
        silent execute 'normal! gvy'
    else
        silent execute 'normal! `[v`]y'
    endif
    call ShowMsg("Base64 Decoded: " .system(printf("echo %s | base64 -D", @@)))

    let @@ = reg_save
endfunction
nmap <silent> ,db :set opfunc=DecodeBase64Str<cr>g@
vmap <silent> ,db :<c-u>call DecodeBase64Str(visualmode(), 1)<cr>

function! DecodeHex2Str(type, ...)
    let reg_save = @@

    if a:0
        silent execute 'normal! gvy'
    else
        silent execute 'normal! `[v`]y'
    endif

    call ShowMsg("Hex2Ascii: " .system(printf("python -c 'import sys; sys.stdout.write(\"%s\".decode(\"hex\"))'", @@)))

    let @@ = reg_save
endfunction
nmap <silent> ,dh :set opfunc=DecodeHex2Str<cr>g@
vmap <silent> ,dh :<c-u>call DecodeHex2Str(visualmode(), 1)<cr>

function! WindowMaxToggle()
    if !exists('w:winmax_height') || w:winmax_height < 0
        let w:winmax_height = winheight(0)
        res 1000
    else
        execute('res ' . w:winmax_height)
        unlet w:winmax_height
    endif
endfunction

function! RestoreWindowSize()
	if exists('w:winmax_height')
        execute('res ' . w:winmax_height)
        unlet w:winmax_height
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
	let filename = expand('%:p')
	let old_dir = getcwd()
	cd %:p:h
	botright new | res 15 " | setl nonu | setl nornu
	call termopen(a:cmd ." ". filename. " " .args)
	execute("cd " .old_dir)
	startinsert
endfunction

command! -nargs=0 LatestFile call LoadLatestFile()
command! -nargs=? FWlog call EditCmdOutFile('fwlog <f-args>')
"}}}

 " vim:fdm=marker
