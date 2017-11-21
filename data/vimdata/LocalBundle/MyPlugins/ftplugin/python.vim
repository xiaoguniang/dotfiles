""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Loaded when filetype is python
"                       map to auto execute the script
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('b:loaded_py_vim')
    finish
endif

let b:loaded_py_vim = 1

setl tabstop=4
setl expandtab

map <buffer> <silent> ,rr :call WinRun("python")<cr>
map <buffer> <silent> ,ra :call WinRun("python", 1)<cr>
map <buffer> <silent> ,ri :call WinRun("python -i")<cr>
map <buffer> <silent> ,ti :T ipython<cr>

" textobj python {{{
call textobj#user#map('python', {
	  \   'class': {
	  \     'select-a': '<buffer>ac',
	  \     'select-i': '<buffer>ic',
	  \     'move-n': '<buffer>]]c',
	  \     'move-p': '<buffer>[[c',
	  \   },
	  \   'function': {
	  \     'select-a': '<buffer>af',
	  \     'select-i': '<buffer>if',
	  \     'move-n': '<buffer>]]f',
	  \     'move-p': '<buffer>[[f',
	  \   }
	  \ })
"}}}

