Plug 'https://github.com/vimwiki/vimwiki.git'

" vimwiki "{{{
let g:vimwiki_conceallevel = 0
let g:vimwiki_use_mouse = 1
let g:vimwiki_url_maxsave = 0
let g:vimwiki_folding = 'syntax'
let wiki_1 = {}
let wiki_1.nested_syntaxes = {
            \ 'python': 'python',
            \ 'cpp': 'cpp',
            \ 'vim': 'vim',
            \ 'make': 'make',
            \ 'java': 'java',
            \ 'sh': 'sh',
            \ 'tex': 'tex',
            \ 'go': 'go',
            \ 'js': 'javascript',
            \ 'automake': 'automake',
            \ 'sql': 'sql',
            \ 'xml': 'xml'
            \}

" let wiki_2 = {}
" let wiki_2.path = '~/vimwiki/markdown'
" let wiki_2.syntax = 'markdown'
" let wiki_2.ext = '.md'

let g:vimwiki_list = [ wiki_1 ]
"let g:vimwiki_ext2syntax = {'.md': 'markdown', 
            "\ '.mkd': 'markdown',
            "\ '.wiki': 'media'}
"let g:vimwiki_list = [{'path': '~/my_site/', 'path_html': '~/public_html/'},
            "\ {'path': '~/my_docs/', 'ext': '.mdox'}]

let g:myvimwikidir = expand('$HOME/vimwiki')
let g:vimwiki_use_mouse = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_use_mouse = 1

function! ListWikiItems(lead, ...) abort
  return map(split(globpath(g:myvimwikidir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! Vwiki(...) abort
	let filepath = g:myvimwikidir ."/". a:1 . '.wiki'
	call OpenFile(filepath, a:000)
endfunction

function! VimwikiBufferMap()
    " nmap <nowait> <silent> <buffer> qq :q<CR>
    nmap <silent> <buffer> <leader>tt <Plug>VimwikiToggleListItem
    vmap <silent> <buffer> <leader>tt <Plug>VimwikiToggleListItem
    setl noswapfile
endfunction

command! -nargs=+ -bar -complete=customlist,ListWikiItems Vwiki     call Vwiki(<f-args>)

nmap <leader>wg :Vwiki 
nmap <leader>td :execute('new ' . g:myvimwikidir . '/Tasks.wiki')<cr>

autocmd! FileType vimwiki call VimwikiBufferMap()
"}}}
