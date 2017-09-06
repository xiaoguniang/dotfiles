nmap <buffer> <silent> ,rr :execute(printf(":Ecapture openssl x509 -in %s -text -noout -pubkey", expand('%')))<cr>
