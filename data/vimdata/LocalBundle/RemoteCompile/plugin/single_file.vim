let s:remote_dir = expand("/tmp/$USER")
let g:remote_compile_host = "32"

function! SyncFile()
    call system(printf("rsync %s %s:%s", expand('%:p'), g:remote_compile_host, GetRemoteFilePath()))
endfunction

function! GetRemoteFilePath()
    return printf("%s/%s", s:remote_dir, expand("%:t"))
endfunction

function! GetRemoteDestFile()
    return printf("%s/%s", s:remote_dir, expand("%:t:r"))
endfunction

function! RemoteCompile()
    call SyncFile()

    if &ft == "c"
        let compile_cmd = printf("gcc -o %s ", GetRemoteDestFile())
    elseif &ft == "cpp"
        let compile_cmd = printf("g++ -std=c++11 -o %s ", GetRemoteDestFile())
    endif

    let &makeprg = printf("(ssh %s '%s %s \\\|& sed s,^%s,%s,g' 1>&2)", g:remote_compile_host, compile_cmd, GetRemoteFilePath(), s:remote_dir, expand('%:p:h'))
    execute("silent make!")

    if len(getqflist()) > 0
        copen
        return -1
    else
        cclose
    endif

    return 0
endfunction

function! RemoteCompileRun()
    let dest_binary = GetRemoteDestFile()
    if RemoteCompile() < 0 | return | endif
    call RemoteCmdRun(printf("ssh %s %s", g:remote_compile_host, dest_binary))
endfunction

function! RemoteCmdRun(cmd)
    botright new | res 15 " | setl nonu | setl nornu
    call termopen(a:cmd)
endfunction

nmap ,lr :call RemoteCompileRun()<cr>
command! -nargs=0 RemoteRun :call RemoteCompileRun()<cr>
