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
    mov     r14, pscore_0
    mov     r13, pissuer_0
    mov     r15, pdcrl_0
    mov     [rbp+pcrl], pcrl_0
    mov     rax, ctx_0
    mov     rdi, [rbp+crls]; sk
    mov     ebx, [r8]
    mov     [rbp+ctx], ctx_0
    mov     rax, [rax+0B8h]
    mov     [rbp+x], rax
    mov     [rbp+crl_issuer_0], 0
    call    ossl_check_const_X509_CRL_sk_type
    mov     r12, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_502DAC
    mov     [rbp+pissuer], pissuer_0
    mov     [rbp+pdcrl], pdcrl_0
    mov     [rbp+pscore], pscore_0
    xor     eax, eax
    mov     [rbp+best_crl_issuer], rax
    xor     eax, eax
    mov     [rbp+best_crl], rax
    xor     r13d, r13d
    mov     [rbp+reasons], 0
    jmp     short loc_502CAA
loc_502C80:
    mov     rax, [rbp+crl_issuer_0]
    mov     [rbp+best_crl_issuer], rax
    mov     eax, [rbp+var_34]
    mov     [rbp+reasons], eax
    mov     ebx, r15d
    mov     [rbp+best_crl], crl
loc_502C95:
    add     r13d, 1
    mov     rdi, r12; st
    call    OPENSSL_sk_num
    cmp     r13d, eax
    jge     loc_502D45
loc_502CAA:
    mov     rdi, r12; st
    mov     esi, r13d; i
    call    OPENSSL_sk_value
    mov     r14, rax
    mov     rax, [rbp+preasons]
    mov     eax, [rax]
    mov     [rbp+var_34], eax
    mov     rdi, [rbp+ctx]; ctx
    lea     rsi, [rbp+crl_issuer_0]; pissuer
    lea     rdx, [rbp+var_34]; preasons
    mov     rcx, crl; crl
    mov     r8, [rbp+x]; x
    call    get_crl_score
    cmp     eax, ebx
    jl      short loc_502C95
    mov     r15d, eax
    test    eax, eax
    jz      short loc_502C95
    cmp     [rbp+best_crl], 0
    jz      short loc_502C80
    cmp     r15d, ebx
    jnz     short loc_502C80
    mov     [rbp+var_30], ebx
    mov     rdi, [rbp+best_crl]; crl
    call    X509_CRL_get0_lastUpdate
    mov     rbx, rax
    mov     rdi, crl; crl
    call    X509_CRL_get0_lastUpdate
    lea     rdi, [rbp+day]; pday
    lea     rsi, [rbp+sec]; psec
    mov     rdx, rbx; from
    mov     rcx, rax; to
    call    ASN1_TIME_diff
    test    eax, eax
    jz      short loc_502D3D
    cmp     [rbp+day], 0
    mov     ebx, [rbp+var_30]
    jg      loc_502C80
    cmp     [rbp+sec], 0
    jle     loc_502C95
    jmp     loc_502C80
loc_502D3D:
    mov     ebx, [rbp+var_30]
    jmp     loc_502C95
loc_502D45:
    mov     r12, [rbp+best_crl]
    test    r12, r12
    jz      short loc_502DAC
    mov     r14, [rbp+pcrl]
    mov     rdi, [r14]; a
    call    X509_CRL_free
    mov     [r14], r12
    mov     rax, [rbp+pissuer]
    mov     rcx, [rbp+best_crl_issuer]
    mov     [rax], rcx
    mov     r14, [rbp+pscore]
    mov     [r14], ebx
    mov     rax, [rbp+preasons]
    mov     ecx, [rbp+reasons]
    mov     [rax], ecx
    mov     rdi, r12; crl
    call    X509_CRL_up_ref
    mov     r15, [rbp+pdcrl]
    mov     rdi, [r15]; a
    call    X509_CRL_free
    mov     qword ptr [r15], 0
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, r15; dcrl
    mov     rdx, r14; pscore
    mov     rcx, r12; base
    mov     r8, [rbp+crls]; crls
    call    get_delta_sk
loc_502DAC:
    xor     eax, eax
    cmp     ebx, 1BFh
    setnle  al
    add     rsp, 68h
    pop     best_score
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
get_crl_sk endp



X509_CRL_get0_lastUpdate proc
    mov     rax, [crl+20h]
    retn
X509_CRL_get0_lastUpdate endp

