Plug expand('$CUSDATA/LocalBundle/dbext_2500')

Plug 'https://github.com/cosminadrianpopescu/vim-sql-workbench'

let g:sw_exe = '/Users/hbliu/Downloads/Workbench-Build122-with-optional-libs/sqlwbconsole.sh'
let g:sw_config_dir = '/Users/hbliu/.sqlworkbench'

let g:dbext_default_profile_mySQL = 'type=MYSQL:user=ads:passwd=ads:host=192.168.0.32:port=23306:dbname=fwmrm_oltp' 
let g:dbext_default_profile_fwprd = 'type=MYSQL:user=qa:passwd=Qa0602@@:host=OLTPdb1a.fwmrm.net:dbname=fwmrm_oltp' 

