tls_construct_cke_dhe proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r15, s
    mov     [rbp+keybytes], 0
    mov     [rbp+encoded_pub], 0
    mov     rbx, [rdi+4B0h]
    test    skey, skey
    jz      loc_43E066
    mov     r12, pkt
    mov     rdi, s; s
    mov     rsi, skey; pm
    call    ssl_generate_pkey
    test    rax, rax
    jz      loc_43E080
    mov     r14, rax
    xor     r13d, r13d
    mov     rdi, s; s
    mov     rsi, rax; privkey
    mov     rdx, skey; pubkey
    xor     ecx, ecx; gensecret
    call    ssl_derive
    test    eax, eax
    jz      err
    lea     rsi, [rbp+encoded_pub]; ppub
    mov     rdi, ckey; pkey
    call    EVP_PKEY_get1_encoded_public_key
    test    rax, rax
    jz      loc_43E0E8
    mov     r13, rax
    mov     rdi, ckey; pkey
    call    EVP_PKEY_get_size
    movsxd  skey, eax
    sub     pad_len, encoded_pub_len
    jz      short loc_43E02B
    lea     rdx, [rbp+keybytes]; allocbytes
    mov     ecx, 2; lenbytes
    mov     rdi, pkt; pkt
    mov     rsi, rbx; len
    call    WPACKET_sub_allocate_bytes__
    test    eax, eax
    jz      loc_43E123
    mov     rdi, [rbp+keybytes]; s
    xor     esi, esi; c
    mov     rdx, rbx; n
    call    _memset
loc_43E02B:
    mov     rsi, [rbp+encoded_pub]; src
    mov     ecx, 2; lenbytes
    mov     rdi, pkt; pkt
    mov     rdx, encoded_pub_len; len
    call    WPACKET_sub_memcpy__
    mov     r13d, 1
    test    eax, eax
    jnz     short err
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_1; "tls_construct_cke_dhe"
    mov     esi, 0B8Eh
    jmp     loc_43E13B
loc_43E066:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_1; "tls_construct_cke_dhe"
    mov     esi, 0B60h
    jmp     short loc_43E098
loc_43E080:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_1; "tls_construct_cke_dhe"
    mov     esi, 0B67h; line
loc_43E098:
    call    ERR_set_debug
    xor     r14d, r14d
    mov     rdi, s; s
    mov     esi, 50h ; 'P'; al_0
    mov     edx, 0C0103h; reason
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
    xor     r13d, r13d
    mov     rdi, [rbp+encoded_pub]; str
    lea     rsi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    mov     edx, 0B94h; line
    call    CRYPTO_free
    mov     rdi, ckey; x
loc_43E0D1:
    call    EVP_PKEY_free
    mov     eax, r13d
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     ckey
    pop     s
    pop     rbp
    retn
loc_43E0E8:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_1; "tls_construct_cke_dhe"
    mov     esi, 0B79h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     rdi, s; s
    mov     esi, 50h ; 'P'; al_0
    mov     edx, 0C0103h; reason
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
    mov     rdi, skey
    jmp     short loc_43E0D1
loc_43E123:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_1; "tls_construct_cke_dhe"
    mov     esi, 0B87h; line
loc_43E13B:
    call    ERR_set_debug
    xor     r13d, r13d
    mov     rdi, s; s
    mov     esi, 50h ; 'P'; al_0
    mov     edx, 0C0103h; reason
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
    jmp     err
tls_construct_cke_dhe endp



tls_construct_cke_ecdhe proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r13, s
    mov     [rbp+encodedPoint], 0
    mov     rbx, [rdi+4B0h]
    test    skey, skey
    jz      loc_43E227
    mov     r12, pkt
    mov     rdi, s; s
    mov     rsi, skey; pm
    call    ssl_generate_pkey
    mov     r14, rax
    test    rax, rax
    jz      loc_43E262
    xor     r15d, r15d
    mov     rdi, s; s
    mov     rsi, ckey; privkey
    mov     rdx, skey; pubkey
    xor     ecx, ecx; gensecret
    call    ssl_derive
    test    eax, eax
    jz      err
    lea     rsi, [rbp+encodedPoint]; ppub
    mov     rdi, ckey; pkey
    call    EVP_PKEY_get1_encoded_public_key
    test    encoded_pt_len, encoded_pt_len
    jz      loc_43E291
    mov     rsi, [rbp+encodedPoint]; src
    mov     ecx, 1; lenbytes
    mov     rdi, pkt; pkt
    mov     rdx, encoded_pt_len; len
    call    WPACKET_sub_memcpy__
    mov     r15d, 1
    test    eax, eax
    jnz     err
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_2; "tls_construct_cke_ecdhe"
    mov     esi, 0BBFh; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     rdi, s
    mov     esi, 50h ; 'P'
    mov     edx, 0C0103h
    jmp     loc_43E2BE
loc_43E227:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_2; "tls_construct_cke_ecdhe"
    mov     esi, 0BA2h; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     rdi, s; s
    mov     esi, 50h ; 'P'; al_0
    mov     edx, 0C0103h; reason
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
    jmp     loc_43E2E4
loc_43E262:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_2; "tls_construct_cke_ecdhe"
    mov     esi, 0BA9h; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     rdi, s
    mov     esi, 50h ; 'P'
    mov     edx, 0C0100h
    jmp     short loc_43E2BE
loc_43E291:
    call    ERR_new
    lea     rdi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    lea     rdx, aTlsConstructCk_2; "tls_construct_cke_ecdhe"
    mov     esi, 0BBAh; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     rdi, s; s
    mov     esi, 50h ; 'P'; al_0
    mov     edx, 80010h; reason
loc_43E2BE:
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
    mov     rdi, [rbp+encodedPoint]; str
    lea     rsi, aSslStatemState_0; "ssl/statem/statem_clnt.c"
    mov     edx, 0BC5h; line
    call    CRYPTO_free
    mov     rdi, ckey; x
    call    EVP_PKEY_free
loc_43E2E4:
    mov     eax, r15d
    add     rsp, 8
    pop     skey
    pop     r12
    pop     s
    pop     r14
    pop     r15
    pop     rbp
    retn
tls_construct_cke_ecdhe endp



ssl_generate_pkey proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rax
    mov     [rbp+pkey], 0
    test    pm, pm
    jz      short loc_40712C
    mov     rax, [s+9A8h]
    mov     s, [rax]; libctx
    mov     rdx, [rax+440h]; propquery
    call    EVP_PKEY_CTX_new_from_pkey
    mov     rbx, rax
    test    rax, rax
    jz      short err
    mov     rdi, pctx; ctx
    call    EVP_PKEY_keygen_init
    test    eax, eax
    jle     short err
    lea     rsi, [rbp+pkey]; ppkey
    mov     rdi, pctx; ctx
    call    EVP_PKEY_keygen
    test    eax, eax
    jg      short err
    mov     rdi, [rbp+pkey]; x
    call    EVP_PKEY_free
    mov     [rbp+pkey], 0
    mov     rdi, pctx; ctx
    call    EVP_PKEY_CTX_free
    mov     rax, [rbp+pkey]
    jmp     short loc_40712E
loc_40712C:
    xor     eax, eax
loc_40712E:
    add     rsp, 8
    pop     rbx
    pop     rbp
    retn
ssl_generate_pkey endp

