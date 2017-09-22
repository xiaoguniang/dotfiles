nmap <buffer> <silent> ,rr :execute(printf(":Ecapture openssl ec -in %s -pubout", expand('%')))<cr>
