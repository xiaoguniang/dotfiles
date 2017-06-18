" ============================================================================
" File:        fs_menu.vim
" Description: plugin for the NERD Tree that provides a file system menu
" Maintainer:  Martin Grenfell <martin.grenfell at gmail dot com>
" Last Change: 17 July, 2009
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================
if exists("g:loaded_nerdtree_cus_fs_menu")
    finish
endif
let g:loaded_nerdtree_cus_fs_menu = 1
if has('mac')
    let s:open_with_command = 'open >/dev/zero '
elseif has('unix')
    let s:open_with_command = 'xdg-open >/dev/zero '
endif

"Automatically delete the buffer after deleting or renaming a file
if !exists("g:NERDTreeAutoDeleteBuffer")
    let g:NERDTreeAutoDeleteBuffer = 0
endif

call NERDTreeAddMenuItem({'text': '(o)open with default', 'shortcut': 'o', 'callback': 'NERDTreeOpenNode'})

function! NERDTreeOpenNode()
    let currentNode = g:NERDTreeFileNode.GetSelected()
    let command_str = s:open_with_command . ' ' . currentNode.path.str() . ' &'
    let out = system(command_str)
endfunction

"FUNCTION: s:echo(msg){{{1
function! s:echo(msg)
    redraw
    echomsg "NERDTree: " . a:msg
endfunction

"FUNCTION: s:echoWarning(msg){{{1
function! s:echoWarning(msg)
    echohl warningmsg
    call s:echo(a:msg)
    echohl normal
endfunction

"FUNCTION: s:promptToDelBuffer(bufnum, msg){{{1
"prints out the given msg and, if the user responds by pushing 'y' then the
"buffer with the given bufnum is deleted
"
"Args:
"bufnum: the buffer that may be deleted
"msg: a message that will be echoed to the user asking them if they wish to
"     del the buffer
function! s:promptToDelBuffer(bufnum, msg)
    echo a:msg
    if g:NERDTreeAutoDeleteBuffer || nr2char(getchar()) ==# 'y'
        " 1. ensure that all windows which display the just deleted filename
        " now display an empty buffer (so a layout is preserved).
        " Is not it better to close single tabs with this file only ?
        let s:originalTabNumber = tabpagenr()
        let s:originalWindowNumber = winnr()
        exec "tabdo windo if winbufnr(0) == " . a:bufnum . " | exec ':enew! ' | endif"
        exec "tabnext " . s:originalTabNumber
        exec s:originalWindowNumber . "wincmd w"
        " 3. We don't need a previous buffer anymore
        exec "bwipeout! " . a:bufnum
    endif
endfunction

