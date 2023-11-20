ossl_rsa_pss_to_ctx proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r12, pkey
    mov     rbx, sigalg
    mov     r13, pkctx_0
    mov     r15, ctx
    mov     [rbp+pkctx], rsi
    mov     [rbp+mgf1md], 0
    mov     [rbp+md], 0
    mov     rdi, [rdx]; a
    call    OBJ_obj2nid
    cmp     eax, 390h
    jnz     short loc_4CF41B
    mov     rdi, sigalg; alg
    call    ossl_rsa_pss_decode
    mov     r14, rax
    lea     rsi, [rbp+md]; pmd
    lea     rdx, [rbp+mgf1md]; pmgf1md
    lea     rcx, [rbp+saltlen]; psaltlen
    mov     rdi, rax; pss
    call    ossl_rsa_pss_get_param
    test    eax, eax
    jz      short loc_4CF452
    test    pkey, pkey
    jz      loc_4CF4A0
    mov     rdx, [rbp+md]; type
    lea     rsi, [rbp+pkctx]; pctx
    mov     rdi, ctx; ctx
    xor     ecx, ecx; e
    mov     r8, pkey; pkey
    call    EVP_DigestVerifyInit
    test    eax, eax
    jnz     loc_4CF4C8
    jmp     short loc_4CF482
loc_4CF41B:
    call    ERR_new
    lea     rdi, aCryptoRsaRsaAm; "crypto/rsa/rsa_ameth.c"
    lea     rdx, aOsslRsaPssToCt; "ossl_rsa_pss_to_ctx"
    mov     esi, 211h; line
    call    ERR_set_debug
    mov     edi, 4; lib
    mov     esi, 9Bh; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     ebx, 0FFFFFFFFh
    jmp     short loc_4CF48F
loc_4CF452:
    call    ERR_new
    lea     rdi, aCryptoRsaRsaAm; "crypto/rsa/rsa_ameth.c"
    lea     rdx, aOsslRsaPssToCt; "ossl_rsa_pss_to_ctx"
    mov     esi, 218h; line
    call    ERR_set_debug
    mov     edi, 4; lib
    mov     esi, 95h; reason
loc_4CF479:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
loc_4CF482:
    mov     ebx, 0FFFFFFFFh
    mov     rdi, pss; a
    call    RSA_PSS_PARAMS_free
loc_4CF48F:
    mov     eax, ebx
    add     rsp, 28h
    pop     rbx
    pop     pkey
    pop     r13
    pop     r14
    pop     ctx
    pop     rbp
    retn
loc_4CF4A0:
    lea     rsi, [rbp+checkmd]; md
    mov     rdi, pkctx_0; ctx
    call    EVP_PKEY_CTX_get_signature_md
    test    eax, eax
    jle     short loc_4CF482
    mov     rdi, [rbp+md]; md
    call    EVP_MD_get_type
    mov     ebx, eax
    mov     rdi, [rbp+checkmd]; md
    call    EVP_MD_get_type
    cmp     ebx, eax
    jnz     short loc_4CF50E
loc_4CF4C8:
    mov     rdi, [rbp+pkctx]; ctx
    mov     esi, 6; pad_mode
    call    EVP_PKEY_CTX_set_rsa_padding
    mov     ebx, 0FFFFFFFFh
    test    eax, eax
    jle     short err
    mov     rdi, [rbp+pkctx]; ctx
    mov     esi, [rbp+saltlen]; saltlen
    call    EVP_PKEY_CTX_set_rsa_pss_saltlen
    test    eax, eax
    jle     short err
    mov     rdi, [rbp+pkctx]; ctx
    mov     rsi, [rbp+mgf1md]; md
    call    EVP_PKEY_CTX_set_rsa_mgf1_md
    xor     ecx, ecx
    test    eax, eax
    setnle  cl
    lea     ebx, [rcx+rcx]
    add     ebx, 0FFFFFFFFh
    jmp     err
loc_4CF50E:
    call    ERR_new
    lea     rdi, aCryptoRsaRsaAm; "crypto/rsa/rsa_ameth.c"
    lea     rdx, aOsslRsaPssToCt; "ossl_rsa_pss_to_ctx"
    mov     esi, 225h; line
    call    ERR_set_debug
    mov     edi, 4
    mov     esi, 9Eh
    jmp     loc_4CF479
ossl_rsa_pss_to_ctx endp



rsa_item_verify proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     r14, pkey
    mov     rbx, sigalg
    mov     r15, ctx
    mov     rdi, [rcx]; a
    call    OBJ_obj2nid
    cmp     eax, 390h
    jnz     short loc_4CFB81
    mov     rdi, ctx; ctx
    xor     esi, esi; pkctx
    mov     rdx, sigalg; sigalg
    mov     rcx, pkey; pkey
    call    ossl_rsa_pss_to_ctx
    xor     ecx, ecx
    test    eax, eax
    setnz   cl
    lea     eax, [rcx+rcx*2]
    add     eax, 0FFFFFFFFh
    jmp     short loc_4CFBB6
loc_4CFB81:
    call    ERR_new
    lea     rdi, aCryptoRsaRsaAm; "crypto/rsa/rsa_ameth.c"
    lea     rdx, aRsaItemVerify; "rsa_item_verify"
    mov     esi, 269h; line
    call    ERR_set_debug
    mov     edi, 4; lib
    mov     esi, 9Bh; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     eax, 0FFFFFFFFh
loc_4CFBB6:
    add     rsp, 8
    pop     sigalg
    pop     pkey
    pop     ctx
    pop     rbp
    retn
rsa_item_verify endp

