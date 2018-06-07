function! fold#CallRepeat(funcHandler)
    let countRepeat = v:count1
    while countRepeat > 0
        execute('call ' . a:funcHandler)
        let countRepeat -= 1
    endwhile
endfunction

function! fold#NavigateFolds(direction, foldStatus)
    if a:direction " == "next"
        normal zj
        let posDelta = 1
    else
        normal zk
        let posDelta = -1
    endif
    let curLineNum = line('.')

    if a:foldStatus " == "closed"
        while foldclosed(curLineNum) == -1
            let curLineNum += posDelta
        endwhile
    else
        while foldclosed(curLineNum) != -1
            let curLineNum += 1
        endwhile
    endif
    call cursor(curLineNum, 0)
endfunction
