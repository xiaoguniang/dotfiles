Plug 'https://github.com/arecarn/vim-selection' " Required by crunch
Plug 'https://github.com/arecarn/vim-crunch'
" Plug 'https://github.com/sk1418/HowMuch'

" Plug 'https://github.com/christoomey/vim-run-interactive'
Plug 'https://github.com/vim-scripts/a.vim.git'
Plug 'https://github.com/DataWraith/auto_mkdir'
Plug 'https://github.com/tpope/vim-unimpaired.git'
" file:linenum:col
Plug 'https://github.com/kopischke/vim-fetch'
" unix file manipulation
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/djoshea/vim-autoread'
Plug 'https://github.com/sjl/vitality.vim'

" function! ColumnsMerge()
" 	let prefix = "("
" 	let suffix = ");"
" 	let delimiter = ",,"

" 	let result = []
" 	for l in getline(1, '$')
" 		for c in split(l, delimiter)
" 		endfor
" 	endfor
" endfunction

" sql view "{{{
" Plug expand('$CUSDATA/LocalBundle/dbext_2500')
" Plug 'https://github.com/cosminadrianpopescu/vim-sql-workbench'

let g:sw_exe = '/Users/hbliu/Downloads/Workbench-Build122-with-optional-libs/sqlwbconsole.sh'
let g:sw_config_dir = '/Users/hbliu/.sqlworkbench'

let g:dbext_default_profile_mySQL = 'type=MYSQL:user=ads:passwd=ads:host=192.168.0.32:port=23306:dbname=fwmrm_oltp' 
let g:dbext_default_profile_fwprd = 'type=MYSQL:user=qa:passwd=Qa0602@@:host=OLTPdb1a.fwmrm.net:dbname=fwmrm_oltp' 
"}}}
