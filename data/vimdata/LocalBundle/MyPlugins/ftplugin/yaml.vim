nmap <buffer> <silent> ,rr :Dispatch! docker-compose -f % up -d<cr>
nmap <buffer> <silent> ,R :Dispatch! docker-compose -f % down && docker-compose -f % up -d<cr>
