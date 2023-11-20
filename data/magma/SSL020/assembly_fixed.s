tls_decrypt_ticket proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0A8h
    mov     r13, s
    test    eticklen_0, eticklen_0
    mov     [rbp+var_50], psess
    mov     [rbp+nctick], etick
    jz      loc_41C5F6
    mov     r14, sesslen_0
    mov     r12, [s+0B88h]
    mov     rax, [s+8]
    mov     rdi, [rax+0C0h]
    test    byte ptr [rdi+60h], 8
    mov     [rbp+keyname_len], eticklen_0
    jnz     short loc_41C58A
    mov     eax, [rax]
    cmp     eax, 304h
    jl      short loc_41C58A
    cmp     eax, 10000h
    jz      short loc_41C58A
    cmp     eticklen_0, 20h ; ' '
    jnb     short loc_41C5A2
    mov     r15d, 4
    xor     ebx, ebx
    jmp     loc_41C616
loc_41C58A:
    xor     ebx, ebx
    mov     r15d, 4
    cmp     eticklen_0, 20h ; ' '
    jb      short loc_41C616
    cmp     qword ptr [s+0AF8h], 0
    jnz     short loc_41C616
loc_41C5A2:
    mov     [rbp+sess_id], sess_id_0
    mov     rdi, tctx; ctx
    call    ssl_hmac_new
    test    rax, rax
    jz      short loc_41C60C
    mov     rbx, rax
    call    EVP_CIPHER_CTX_new
    mov     [rbp+ctx], ctx_0
    test    rax, rax
    jz      short loc_41C613
    mov     [rbp+sesslen], sesslen_0
    mov     [rbp+hctx], hctx_0
    mov     r14, [tctx+248h]
    test    r14, r14
    jz      loc_41C761
    mov     r15, [rbp+nctick]
    lea     rbx, [nctick_0+10h]
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_get0_EVP_MAC_CTX
    jmp     loc_41C783
loc_41C5F6:
    mov     r15d, 3
    xor     ebx, ebx
    xor     r12d, r12d
    xor     r14d, r14d
    xor     eax, eax
    mov     [rbp+keyname_len], rax
    jmp     short end
loc_41C60C:
    xor     r15d, r15d
    xor     ebx, ebx
    jmp     short loc_41C616
loc_41C613:
    xor     r15d, r15d
loc_41C616:
    xor     r12d, r12d
    xor     r14d, r14d
    mov     rdi, ctx_0; ctx
    call    EVP_CIPHER_CTX_free
    mov     rdi, hctx_0; ctx
    call    ssl_hmac_free
    lea     r12d, [ret-3]
    cmp     r12d, 3
    ja      loc_41C6E1
    mov     rax, [s+0B88h]
    mov     hctx_0, [rax+400h]
    test    rbx, rbx
    jz      loc_41C6E1
    mov     rcx, [rbp+keyname_len]
    mov     rdx, rcx
    cmp     rcx, 10h
    mov     ecx, 10h
    cmovb   rcx, rdx
    mov     r9, [rax+408h]
    mov     rdi, s
    mov     rsi, sess
    mov     rdx, [rbp+nctick]
    mov     r8d, r15d
    call    rbx
    lea     ecx, [retcb-3]
    cmp     ecx, 2
    jb      short loc_41C69D
    cmp     eax, 2
    jz      short loc_41C6C1
    cmp     eax, 1
    jnz     short loc_41C6DB
    mov     rdi, sess; ss_0
    call    SSL_SESSION_free
    mov     r15d, 2
    jmp     short loc_41C6D6
loc_41C69D:
    add     r15d, 0FFFFFFFBh
    cmp     r15d, 1
    mov     rdx, [rbp+var_50]
    jbe     loc_41C744
    mov     r15d, 1
    cmp     qword ptr [s+0AF8h], 0
    jnz     short loc_41C6EF
    jmp     short loc_41C710
loc_41C6C1:
    cmp     r12d, 1
    mov     eax, 4
    cmova   r15d, eax
    mov     rdi, sess; ss_0
    call    SSL_SESSION_free
loc_41C6D6:
    xor     r14d, r14d
    jmp     short loc_41C6E1
loc_41C6DB:
    mov     r15d, 1
loc_41C6E1:
    mov     rdx, [rbp+var_50]
    cmp     qword ptr [s+0AF8h], 0
    jz      short loc_41C710
loc_41C6EF:
    mov     rax, [s+8]
    mov     rcx, [rax+0C0h]
    test    byte ptr [rcx+60h], 8
    jnz     short loc_41C72C
    mov     eax, [rax]
    cmp     eax, 304h
    jl      short loc_41C72C
    cmp     eax, 10000h
    jz      short loc_41C72C
loc_41C710:
    cmp     r15d, 6
    ja      short loc_41C72C
    mov     eax, 58h ; 'X'
    bt      eax, r15d
    jnb     short loc_41C72C
    mov     dword ptr [s+0A98h], 1
loc_41C72C:
    mov     [rdx], sess
    mov     eax, r15d
    add     rsp, 0A8h
    pop     rbx
    pop     r12
    pop     s
    pop     sess
    pop     ret
    pop     rbp
    retn
loc_41C744:
    xor     ecx, ecx
    cmp     eax, 3
    setz    cl
    mov     r15d, 6
    sub     r15d, ecx
    cmp     qword ptr [s+0AF8h], 0
    jnz     short loc_41C6EF
    jmp     short loc_41C710
loc_41C761:
    mov     r14, [tctx+240h]
    test    r14, r14
    mov     r15, [rbp+nctick]
    jz      loc_41C87D
    lea     rbx, [nctick_0+10h]
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_get0_HMAC_CTX
loc_41C783:
    mov     rdi, s
    mov     rsi, nctick_0
    mov     rdx, rbx
    mov     tctx, [rbp+ctx]
    mov     rcx, r12
    mov     r8, rax
    xor     r9d, r9d
    call    r14
    xor     r14d, r14d
    test    eax, eax
    js      loc_41C863
    jz      loc_41C86B
    cmp     eax, 2
    jnz     short loc_41C7B8
    mov     r14d, 1
loc_41C7B8:
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_size
    mov     r15d, 1
    test    rax, rax
    jz      loc_41C871
    mov     rbx, rax
    mov     rdi, r12; ctx
    call    EVP_CIPHER_CTX_get_iv_length
    cdqe
    add     rax, mlen
    add     rax, 10h
    mov     rdx, [rbp+keyname_len]
    cmp     rax, rdx
    jnb     short loc_41C858
    sub     rdx, mlen; len
    mov     r12, [rbp+hctx]
    mov     rdi, r12; ctx
    mov     rsi, [rbp+nctick]; data
    mov     [rbp+keyname_len], rdx
    call    ssl_hmac_update
    test    eax, eax
    jle     loc_41C959
    mov     [rbp+var_78], renew_ticket
    xor     r14d, r14d
    lea     rsi, [rbp+tick_hmac]; md
    mov     ecx, 40h ; '@'; max_size
    mov     rdi, r12; ctx
    xor     edx, edx; len
    call    ssl_hmac_final
    test    eax, eax
    jle     loc_41C979
    mov     r14, [rbp+nctick]
    mov     rax, [rbp+keyname_len]
    lea     rsi, [r14+rax]; s2
    lea     rdi, [rbp+tick_hmac]; s1
    mov     rdx, mlen; n
    call    _bcmp
    test    eax, eax
    mov     r12, [rbp+ctx]
    jz      loc_41C986
loc_41C858:
    xor     r14d, r14d
    mov     r15d, 4
    jmp     short loc_41C874
loc_41C863:
    mov     r15d, 1
    jmp     short loc_41C871
loc_41C86B:
    mov     r15d, 4
loc_41C871:
    xor     r14d, r14d
loc_41C874:
    mov     rbx, [rbp+hctx]
    jmp     end
loc_41C87D:
    movdqu  xmm0, xmmword ptr [r15]
    movdqu  xmm1, xmmword ptr [tctx+228h]
    pcmpeqb xmm1, xmm0
    pmovmskb eax, xmm1
    cmp     eax, 0FFFFh
    jz      short loc_41C8A9
    xor     r14d, r14d
    mov     r15d, 4
    jmp     loc_41C979
loc_41C8A9:
    mov     rax, [s+9A8h]
    mov     rdi, [rax]; ctx
    mov     rdx, [rax+440h]; properties
    lea     rsi, aAes256Cbc; "AES-256-CBC"
    call    EVP_CIPHER_fetch
    mov     r14, rax
    test    rax, rax
    jz      loc_41C968
    mov     rsi, [tctx+238h]; key
    lea     rcx, md; "SHA256"
    mov     edx, 20h ; ' '; len
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_init
    test    eax, eax
    jle     short loc_41C968
    mov     rcx, [tctx+238h]
    add     rcx, 20h ; ' '; key
    lea     r8, [r15+10h]; iv
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, aes256cbc; cipher
    xor     edx, edx; impl
    call    EVP_DecryptInit_ex
    test    eax, eax
    jle     short loc_41C968
    mov     rdi, aes256cbc; cipher
    call    EVP_CIPHER_free
    mov     rax, [s+8]
    mov     rcx, [rax+0C0h]
    test    byte ptr [rcx+60h], 8
    mov     tctx, [rbp+ctx]
    mov     r14d, 0
    jnz     loc_41C7B8
    mov     eax, [rax]
    cmp     eax, 303h
    setnle  cl
    cmp     eax, 10000h
    setnz   al
    and     al, cl
    movzx   r14d, al
    jmp     loc_41C7B8
loc_41C959:
    xor     r14d, r14d
    mov     mlen, r12
    mov     r12, [rbp+ctx]
    jmp     end
loc_41C968:
    mov     rdi, aes256cbc; cipher
    call    EVP_CIPHER_free
    mov     r15d, 1
    xor     r14d, r14d
loc_41C979:
    mov     rbx, [rbp+hctx]
    mov     r12, [rbp+ctx]
    jmp     end
loc_41C986:
    mov     rdi, r12; ctx
    call    EVP_CIPHER_CTX_get_iv_length
    cdqe
    add     rax, r14
    add     rax, 10h
    mov     [rbp+p], p_0
    mov     [rbp+pp], rax
    mov     rdi, r12; ctx
    call    EVP_CIPHER_CTX_get_iv_length
    add     eax, 10h
    cdqe
    mov     mlen, [rbp+keyname_len]
    sub     rbx, rax
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, eticklen_0; num
    mov     edx, 783h; line
    call    CRYPTO_malloc
    mov     r14, rax
    test    rax, rax
    mov     [rbp+keyname_len], eticklen_0
    jz      loc_41CA61
    lea     rdx, [rbp+slen]; outl
    mov     rdi, r12; ctx
    mov     rsi, sdec; out
    mov     rcx, [rbp+p]; in
    mov     r8d, ebx; inl
    call    EVP_DecryptUpdate
    test    eax, eax
    jle     short loc_41CA61
    movsxd  rax, [rbp+slen]
    mov     rsi, sdec
    add     rsi, rax; out
    lea     rdx, [rbp+declen]; outl
    mov     rdi, r12; ctx
    call    EVP_DecryptFinal
    test    eax, eax
    jle     short loc_41CA7A
    movsxd  rax, [rbp+declen]
    movsxd  rdx, [rbp+slen]
    add     rdx, rax; length
    mov     [rbp+slen], edx
    mov     [rbp+pp], sdec
    lea     rsi, [rbp+pp]; pp
    xor     edi, edi; a
    call    d2i_SSL_SESSION
    mov     rdi, sdec; str
    mov     sdec, rax
    mov     eax, dword ptr [rbp+pp]
    mov     ecx, edi
    sub     ecx, eax
    add     [rbp+slen], ecx
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     edx, 794h; line
    call    CRYPTO_free
    test    sess, sess
    jz      short loc_41CA93
    cmp     [rbp+slen], 0
    jz      short loc_41CA9D
    mov     rdi, sess; ss_0
    call    SSL_SESSION_free
    jmp     loc_41C858
loc_41CA61:
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, sdec; str
    mov     edx, 786h; line
    call    CRYPTO_free
    jmp     loc_41C871
loc_41CA7A:
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, sdec; str
    mov     edx, 78Bh; line
    call    CRYPTO_free
    jmp     loc_41C858
loc_41CA93:
    call    ERR_clear_error
    jmp     loc_41C858
loc_41CA9D:
    mov     eticklen_0, [rbp+sesslen]
    test    rbx, rbx
    jz      short loc_41CAC6
    mov     rdi, sess
    add     rdi, 258h; dest
    mov     rsi, [rbp+sess_id]; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     [sess+250h], rbx
loc_41CAC6:
    cmp     dword ptr [rbp+var_78], 1
    mov     r15d, 6
    sbb     r15d, 0
    jmp     loc_41C874
tls_decrypt_ticket endp

