"MetaPost filetype
"Language: metapost
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

runtime /usr/share/vim/vim73/ftplugin/mp.vim

nmap <buffer> <Leader>ll :!mptopdf %<CR>
nmap <buffer> <Leader>lv :!evince %:r*.pdf<CR>

setlocal softtabstop=4

let &cpo = s:cpo_save
unlet s:cpo_save
