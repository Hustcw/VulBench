get_crl_sk proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 68h
    mov     [rbp+preasons], preasons_0
    mov     rbx, pscore_0
    mov     r13, pissuer_0
    mov     r14, pdcrl_0
    mov     [rbp+pcrl], pcrl_0
    mov     rax, ctx_0
    mov     rdi, [rbp+crls]; sk
    mov     r15d, [r8]
    mov     [rbp+ctx], ctx_0
    mov     rax, [rax+0B8h]
    mov     [rbp+x], rax
    mov     [rbp+crl_issuer_0], 0
    call    ossl_check_const_X509_CRL_sk_type
    mov     r12, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_41F183
    mov     [rbp+pissuer], pissuer_0
    mov     [rbp+pdcrl], pdcrl_0
    mov     [rbp+pscore], pscore_0
    xor     eax, eax
    mov     [rbp+best_crl_issuer], rax
    xor     eax, eax
    mov     [rbp+best_crl], rax
    xor     r14d, r14d
    mov     [rbp+reasons], 0
    jmp     short loc_41F08A
loc_41F060:
    mov     rax, [rbp+crl_issuer_0]
    mov     [rbp+best_crl_issuer], rax
    mov     eax, [rbp+var_34]
    mov     [rbp+reasons], eax
    mov     r15d, ebx
    mov     [rbp+best_crl], crl
loc_41F075:
    add     r14d, 1
    mov     rdi, r12; st
    call    OPENSSL_sk_num
    cmp     r14d, eax
    jge     loc_41F11A
loc_41F08A:
    mov     rdi, r12; st
    mov     esi, r14d; i
    call    OPENSSL_sk_value
    mov     r13, rax
    mov     rax, [rbp+preasons]
    mov     eax, [rax]
    mov     [rbp+var_34], eax
    mov     rdi, [rbp+ctx]; ctx
    lea     rsi, [rbp+crl_issuer_0]; pissuer
    lea     rdx, [rbp+var_34]; preasons
    mov     rcx, crl; crl
    mov     r8, [rbp+x]; x
    call    get_crl_score
    cmp     eax, r15d
    jl      short loc_41F075
    mov     ebx, eax
    jnz     short loc_41F060
    mov     [rbp+var_30], r15d
    mov     rdi, [rbp+best_crl]; crl
    call    X509_CRL_get0_lastUpdate
    mov     r15, rax
    mov     rdi, crl; crl
    call    X509_CRL_get0_lastUpdate
    lea     rdi, [rbp+day]; pday
    lea     rsi, [rbp+sec]; psec
    mov     rdx, r15; from
    mov     rcx, rax; to
    call    ASN1_TIME_diff
    test    eax, eax
    jz      short loc_41F111
    cmp     [rbp+day], 0
    mov     r15d, [rbp+var_30]
    jg      loc_41F060
    cmp     [rbp+sec], 0
    jle     loc_41F075
    jmp     loc_41F060
loc_41F111:
    mov     r15d, [rbp+var_30]
    jmp     loc_41F075
loc_41F11A:
    mov     rbx, [rbp+best_crl]
    test    rbx, rbx
    jz      short loc_41F183
    mov     i, [rbp+pcrl]
    mov     rdi, [r14]; a
    call    X509_CRL_free
    mov     [r14], rbx
    mov     rax, [rbp+pissuer]
    mov     rcx, [rbp+best_crl_issuer]
    mov     [rax], rcx
    mov     r14, [rbp+pscore]
    mov     [r14], r15d
    mov     rax, [rbp+preasons]
    mov     ecx, [rbp+reasons]
    mov     [rax], ecx
    mov     rdi, rbx; crl
    call    X509_CRL_up_ref
    mov     r12, [rbp+pdcrl]
    mov     rdi, [r12]; a
    call    X509_CRL_free
    mov     qword ptr [r12], 0
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, r12; dcrl
    mov     rdx, r14; pscore
    mov     rcx, rbx; base
    mov     r8, [rbp+crls]; crls
    call    get_delta_sk
loc_41F183:
    xor     eax, eax
    cmp     r15d, 1BFh
    setnle  al
    add     rsp, 68h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     best_score
    pop     rbp
    retn
get_crl_sk endp



X509_CRL_get0_lastUpdate proc
    mov     rax, [crl+20h]
    retn
X509_CRL_get0_lastUpdate endp

