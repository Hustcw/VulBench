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
    jmp     loc_41C77F
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
    jz      short loc_41C7EF
    lea     rbx, [nctick_0+10h]
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_get0_HMAC_CTX
loc_41C77F:
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
    js      short loc_41C7D5
    jz      short loc_41C7DD
    cmp     eax, 2
    jnz     short loc_41C7AC
    mov     r14d, 1
loc_41C7AC:
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_size
    mov     r15d, 1
    test    rax, rax
    jz      short loc_41C7E3
    mov     rdx, [rbp+keyname_len]
    cmp     rdx, 30h ; '0'
    jnb     short loc_41C81F
loc_41C7CA:
    xor     r14d, r14d
    mov     r15d, 4
    jmp     short loc_41C7E6
loc_41C7D5:
    mov     r15d, 1
    jmp     short loc_41C7E3
loc_41C7DD:
    mov     r15d, 4
loc_41C7E3:
    xor     r14d, r14d
loc_41C7E6:
    mov     rbx, [rbp+hctx]
    jmp     end
loc_41C7EF:
    movdqu  xmm0, xmmword ptr [r15]
    movdqu  xmm1, xmmword ptr [tctx+228h]
    pcmpeqb xmm1, xmm0
    pmovmskb eax, xmm1
    cmp     eax, 0FFFFh
    jz      loc_41C97C
    xor     r14d, r14d
    mov     r15d, 4
    jmp     loc_41CA4C
loc_41C81F:
    mov     rbx, rax
    sub     rdx, rax; len
    mov     r12, [rbp+hctx]
    mov     rdi, r12; ctx
    mov     rsi, [rbp+nctick]; data
    mov     [rbp+keyname_len], rdx
    call    ssl_hmac_update
    test    eax, eax
    jle     loc_41CA2C
    mov     [rbp+p], mlen_0
    mov     [rbp+var_78], renew_ticket
    xor     r14d, r14d
    lea     rsi, [rbp+tick_hmac]; md
    mov     ecx, 40h ; '@'; max_size
    mov     rdi, r12; ctx
    xor     edx, edx; len
    call    ssl_hmac_final
    test    eax, eax
    jle     loc_41CA4C
    mov     rbx, [rbp+keyname_len]
    mov     r14, [rbp+nctick]
    lea     rsi, [r14+rbx]; s2
    lea     rdi, [rbp+tick_hmac]; s1
    mov     rdx, [rbp+p]; n
    call    _bcmp
    test    eax, eax
    mov     r12, [rbp+ctx]
    jnz     loc_41C7CA
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
    sub     rbx, rax
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     r14, eticklen_0
    mov     rdi, rbx; num
    mov     edx, 783h; line
    call    CRYPTO_malloc
    mov     rbx, rax
    test    rax, rax
    mov     [rbp+keyname_len], eticklen_0
    jz      loc_41CA59
    lea     rdx, [rbp+slen]; outl
    mov     rdi, r12; ctx
    mov     rsi, sdec; out
    mov     rcx, [rbp+p]; in
    mov     r8d, r14d; inl
    call    EVP_DecryptUpdate
    test    eax, eax
    jle     loc_41CA59
    movsxd  rax, [rbp+slen]
    mov     rsi, sdec
    add     rsi, rax; out
    lea     rdx, [rbp+declen]; outl
    mov     rdi, r12; ctx
    call    EVP_DecryptFinal
    test    eax, eax
    jle     loc_41CA72
    movsxd  rax, [rbp+declen]
    movsxd  rdx, [rbp+slen]
    add     rdx, rax; length
    mov     [rbp+slen], edx
    mov     [rbp+pp], sdec
    lea     rsi, [rbp+pp]; pp
    xor     edi, edi; a
    call    d2i_SSL_SESSION
    mov     eticklen_0, rax
    mov     eax, dword ptr [rbp+pp]
    mov     ecx, ebx
    sub     ecx, eax
    add     [rbp+slen], ecx
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, sdec; str
    mov     edx, 794h; line
    call    CRYPTO_free
    test    sess, sess
    jz      loc_41CA8B
    cmp     [rbp+slen], 0
    jz      loc_41CA95
    mov     rdi, sess; ss_0
    call    SSL_SESSION_free
    jmp     loc_41C7CA
loc_41C97C:
    mov     rax, [s+9A8h]
    mov     rdi, [rax]; ctx
    mov     rdx, [rax+440h]; properties
    lea     rsi, aAes256Cbc; "AES-256-CBC"
    call    EVP_CIPHER_fetch
    mov     r14, rax
    test    rax, rax
    jz      loc_41CA3B
    mov     rsi, [tctx+238h]; key
    lea     rcx, md; "SHA256"
    mov     edx, 20h ; ' '; len
    mov     rdi, [rbp+hctx]; ctx
    call    ssl_hmac_init
    test    eax, eax
    jle     short loc_41CA3B
    mov     rcx, [tctx+238h]
    add     rcx, 20h ; ' '; key
    lea     r8, [r15+10h]; iv
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, aes256cbc; cipher
    xor     edx, edx; impl
    call    EVP_DecryptInit_ex
    test    eax, eax
    jle     short loc_41CA3B
    mov     rdi, aes256cbc; cipher
    call    EVP_CIPHER_free
    mov     rax, [s+8]
    mov     rcx, [rax+0C0h]
    test    byte ptr [rcx+60h], 8
    mov     tctx, [rbp+ctx]
    mov     r14d, 0
    jnz     loc_41C7AC
    mov     eax, [rax]
    cmp     eax, 303h
    setnle  cl
    cmp     eax, 10000h
    setnz   al
    and     al, cl
    movzx   r14d, al
    jmp     loc_41C7AC
loc_41CA2C:
    xor     r14d, r14d
    mov     mlen_0, r12
    mov     r12, [rbp+ctx]
    jmp     end
loc_41CA3B:
    mov     rdi, aes256cbc; cipher
    call    EVP_CIPHER_free
    mov     r15d, 1
    xor     r14d, r14d
loc_41CA4C:
    mov     rbx, [rbp+hctx]
    mov     r12, [rbp+ctx]
    jmp     end
loc_41CA59:
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, sdec; str
    mov     edx, 786h; line
    call    CRYPTO_free
    jmp     loc_41C7E3
loc_41CA72:
    lea     rsi, aSslT1LibC; "ssl/t1_lib.c"
    mov     rdi, sdec; str
    mov     edx, 78Bh; line
    call    CRYPTO_free
    jmp     loc_41C7CA
loc_41CA8B:
    call    ERR_clear_error
    jmp     loc_41C7CA
loc_41CA95:
    mov     sdec, [rbp+sesslen]
    test    rbx, rbx
    jz      short loc_41CABE
    mov     rdi, sess
    add     rdi, 258h; dest
    mov     rsi, [rbp+sess_id]; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     [sess+250h], rbx
loc_41CABE:
    cmp     dword ptr [rbp+var_78], 1
    mov     r15d, 6
    sbb     r15d, 0
    jmp     loc_41C7E6
tls_decrypt_ticket endp

