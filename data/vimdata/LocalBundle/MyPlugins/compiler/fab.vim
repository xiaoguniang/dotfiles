if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=fab

CompilerSet errorformat=%f:%l:%c:\ error:%m
CompilerSet errorformat+=%f:%l:\ error:%m
CompilerSet errorformat+=%f:%l:%c:\ fatal\ error:%m
CompilerSet errorformat+=Blade(error):%m
" CompilerSet errorformat+=%f:%l:%c:\ warning:%m

" CompilerSet errorformat+=%-Gmake%.%#
CompilerSet errorformat+=%-GDisconnecting%.%#
" CompilerSet errorformat+=%-GMaking%.%#
CompilerSet errorformat+=%-GDone.
CompilerSet errorformat+=%-G

let g:compiler_fab = 1
