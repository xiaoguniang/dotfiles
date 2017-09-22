if did_filetype()
    finish
endif

if getline(1) =~# '^-----BEGIN CERTIFICATE-----'
    setfiletype cert
endif

if getline(1) =~# '^-----BEGIN\s\=[A-Z]* PRIVATE KEY-----'
    setfiletype key
endif
