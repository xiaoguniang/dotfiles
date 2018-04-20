" html "{{{
Plug 'https://github.com/maksimr/vim-jsbeautify'
Plug 'https://github.com/sukima/xmledit.git', { 'for': ['xml', 'html'] }
Plug 'https://github.com/mattn/emmet-vim.git', { 'for': ['xml', 'html'] }
Plug 'https://github.com/diepm/vim-rest-console'
" let g:vrc_curl_opts = { '-s' : '', '-i' : ''}
let g:vrc_curl_opts = { '-s' : ''}
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 0
" let g:vrc_auto_format_uhex = 1
" let g:vrc_horizontal_split = 1

" Plug 'https://github.com/elzr/vim-json'
" Plug 'https://github.com/Rykka/colorv.vim'
" Plug 'https://github.com/Valloric/MatchTagAlways'
"}}}

" PlugLazy 'https://github.com/pangloss/vim-javascript.git', {'autoload':{'filetypes':['javascript']}}
" PlugLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git', {'for': ['js', 'javascript']}
Plug 'https://github.com/swekaj/php-foldexpr.vim', {'for': 'php'}
Plug 'https://github.com/ternjs/tern_for_vim', {'for': ['js', 'javascript']}

" jsbeautify "{{{
if has('vim_starting')
    autocmd FileType javascript noremap <buffer>  <c-\> :call JsBeautify()<cr>
    autocmd FileType json noremap <buffer> <c-\> :call JsonBeautify()<cr>
    autocmd FileType jsx noremap <buffer> <c-\> :call JsxBeautify()<cr>
    autocmd FileType html,xml noremap <buffer> <c-\> :call HtmlBeautify()<cr>
    autocmd FileType css noremap <buffer> <c-\> :call CSSBeautify()<cr>

    autocmd FileType javascript vnoremap <buffer>  <c-\> :call RangeJsBeautify()<cr>
    autocmd FileType json vnoremap <buffer> <c-\> :call RangeJsonBeautify()<cr>
    autocmd FileType jsx vnoremap <buffer> <c-\> :call RangeJsxBeautify()<cr>
    autocmd FileType html vnoremap <buffer> <c-\> :call RangeHtmlBeautify()<cr>
    autocmd FileType css vnoremap <buffer> <c-\> :call RangeCSSBeautify()<cr>
endif
"}}}

