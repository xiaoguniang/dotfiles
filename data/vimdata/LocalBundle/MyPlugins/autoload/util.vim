function! util#ShowMsg(msg)
    echohl WarningMsg | echom a:msg | echohl None
endfunction

function! util#DecodeBase64Str(type, ...)
    let reg_save = @@
    if a:0
        silent execute 'normal! gvy'
    else
        silent execute 'normal! `[v`]y'
    endif
    call util#ShowMsg("Base64 Decoded: " .system(printf("echo %s | base64 -D", @@)))

    let @@ = reg_save
endfunction

function! util#DecodeHex2Str(type, ...)
    let reg_save = @@

    if a:0
        silent execute 'normal! gvy'
    else
        silent execute 'normal! `[v`]y'
    endif

    call util#ShowMsg("Hex2Ascii: " .system(printf("python -c 'import sys; sys.stdout.write(\"%s\".decode(\"hex\"))'", @@)))

    let @@ = reg_save
endfunction

function! util#WindowMaxToggle()
    if !exists('w:winmax_height') || w:winmax_height < 0
        let w:winmax_height = winheight(0)
        res 1000
    else
        execute('res ' . w:winmax_height)
        unlet w:winmax_height
    endif
endfunction

function! util#RestoreWindowSize()
	if exists('w:winmax_height')
        execute('res ' . w:winmax_height)
        unlet w:winmax_height
	endif
endfunction

function! s:CloseNeoTerminal()
	if exists(":TcloseAll")
		execute(":TcloseAll")
	endif
endfunction

function! util#WinRun(cmd, ...)
    let need_input = (a:0 >= 1) ? a:1 : 0

    let args = " "
    if need_input != 0
        let args .= input("Please input the arguments: ")
    endif

	call s:CloseNeoTerminal()
	let filename = expand('%:p')
	let old_dir = getcwd()
	cd %:p:h
	botright new | res 15 " | setl nonu | setl nornu
	call termopen(a:cmd ." ". filename. " " .args)
	execute("cd " .old_dir)
	startinsert
endfunction

function! util#EditCmdOutFile(...)
    if a:0 < 1
        return 1
    endif

    let cmd = a:1
    if a:0 > 1
        let cmd .= ' ' . a:2
    endif

    execute('tabnew ' . system(cmd))
endfunction

function! util#LoadLatestFile()
	let file_dir = expand("%:h")
	execute("lcd " .file_dir)
	let latest_file = system('ls -1t | head -1')

	if !empty(latest_file)
		execute("edit " .latest_file)
	endif
endfunction

function! util#TimestampToDate(...)
    let timestamp = expand("<cword>")
    if a:0 > 0
        let timestamp = a:1
    endif

    let origin_TZ = $TZ
    let $TZ = "UTC"
    call util#ShowMsg(strftime("%Y-%m-%d %T %z", timestamp[0:9]))
    let $TZ = origin_TZ
endfunction

function! util#CopyNonFolded() range 
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

function! util#NvrReturn(...)
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


function! util#EditBinaryFile(...)
	let cmd = "tabnew"
	if a:0 > 1
		let cmd = join(a:000[1:])
	endif
	let cmd = cmd . '| Vinarise'
	execute(printf("%s %s", cmd, a:1))
endfunction
