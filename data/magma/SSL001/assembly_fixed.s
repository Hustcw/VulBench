ASN1_TYPE_cmp proc
    mov     eax, 0FFFFFFFFh
    test    a, a
    jz      short locret_452427
    test    b, b
    jz      short locret_452427
    mov     ecx, [a]
    cmp     ecx, [b]
    jnz     short locret_452427
    cmp     ecx, 1
    jz      short loc_452421
    cmp     ecx, 5
    jz      short loc_452428
    cmp     ecx, 6
    jnz     short loc_45242B
    mov     a, [a+8]; a
    mov     b, [b+8]; b
    jmp     OBJ_cmp
loc_452421:
    mov     eax, [a+8]
    sub     eax, [b+8]
locret_452427:
    retn
loc_452428:
    xor     eax, eax
    retn
loc_45242B:
    mov     a, [a+8]; a
    mov     b, [b+8]; b
    jmp     ASN1_STRING_cmp
ASN1_TYPE_cmp endp



asn1_ex_i2c proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_18], cout
    mov     rax, [it+20h]
    test    pf_0, pf_0
    jz      short loc_457036
    mov     pf_0, [pf_0+30h]
    test    rax, rax
    jz      short loc_457036
    call    rax
    jmp     loc_457142; jumptable 000000000045708E case 5
loc_457036:
    mov     al, [it]
    test    al, al
    jnz     short loc_457043
    cmp     qword ptr [it+8], 1
    jz      short loc_457074
loc_457043:
    mov     rbx, [pval]
    test    strtmp, strtmp
    jz      short loc_457056
    cmp     al, 5
    jnz     short loc_457060
    mov     ebx, [strtmp+4]
    mov     [putype], ebx
    jmp     short loc_457076
loc_457056:
    mov     eax, 0FFFFFFFFh
    jmp     loc_457142; jumptable 000000000045708E case 5
loc_457060:
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     short loc_457074
    mov     pval, [pval]
    mov     ebx, [typ]
    mov     [putype], ebx
    add     typ, 8
    jmp     short loc_457076
loc_457074:
    mov     ebx, [putype]
loc_457076:
    add     ebx, 0FFFFFFFFh; switch 10 cases
    cmp     ebx, 9
    ja      short def_45708E; jumptable 000000000045708E default case, cases 4,7-9
    xor     eax, eax
    lea     putype, jpt_45708E
    movsxd  rbx, ds:(jpt_45708E - 668548h)[rdx+rbx*4]
    add     rbx, rdx
def_45708E:
    jmp     rbx; switch jump
    mov     pval, [pval]; jumptable 000000000045708E cases 2,10
    test    cout, cout
    lea     rax, [rbp+var_18]
    cmovz   rax, cout
    mov     cout, rax; pp
    call    ossl_i2c_ASN1_INTEGER
    jmp     loc_457142; jumptable 000000000045708E case 5
    mov     edx, [tbool]; jumptable 000000000045708E case 1
    mov     eax, 0FFFFFFFFh
    cmp     edx, 0FFFFFFFFh
    jz      loc_457142; jumptable 000000000045708E case 5
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     loc_457149
loc_4570C6:
    mov     [rbp+c], dl
    mov     ebx, 1
    lea     rcx, [rbp+c]
    test    cout, cout
    jnz     short loc_45712E
    jmp     short loc_457140
    mov     pval, [pval]; jumptable 000000000045708E case 3
    test    cout, cout
    lea     rax, [rbp+var_18]
    cmovz   rax, cout
    mov     cout, rax; pp
    call    ossl_i2c_ASN1_BIT_STRING
    jmp     short loc_457142; jumptable 000000000045708E case 5
    mov     rdx, [pval]; jumptable 000000000045708E default case, cases 4,7-9
    cmp     qword ptr [it+28h], 800h
    jnz     short loc_457104
    test    byte ptr [strtmp+10h], 10h
    jnz     short loc_45715B
loc_457104:
    mov     it, [strtmp+8]
    mov     ebx, [strtmp]
    test    cout, cout
    jnz     short loc_45712E
    jmp     short loc_457140
    mov     rdx, [pval]; jumptable 000000000045708E case 6
    mov     it, [otmp+18h]
    mov     eax, 0FFFFFFFFh
    test    cont, cont
    jz      short loc_457142; jumptable 000000000045708E case 5
    mov     ebx, [otmp+14h]
    test    ebx, ebx
    jz      short loc_457142; jumptable 000000000045708E case 5
    test    cout, cout
    jz      short loc_457140
loc_45712E:
    test    ebx, ebx
    jz      short loc_457140
    movsxd  rdx, ebx; n
    mov     pval, cout; dest
    mov     cout, cont; src
    call    _memcpy
loc_457140:
    mov     eax, ebx
loc_457142:
    add     rsp, 18h; jumptable 000000000045708E case 5
    pop     rbx
    pop     rbp
    retn
loc_457149:
    mov     it, [it+28h]
    test    edx, edx
    jz      short loc_457171
    test    rcx, rcx
    jg      short loc_457142; jumptable 000000000045708E case 5
    jmp     loc_4570C6
loc_45715B:
    mov     eax, 0FFFFFFFEh
    test    cout, cout
    jz      short loc_457142; jumptable 000000000045708E case 5
    mov     [strtmp+8], cout
    mov     dword ptr [strtmp], 0
    jmp     short loc_457142; jumptable 000000000045708E case 5
loc_457171:
    test    rcx, rcx
    jnz     loc_4570C6
    jmp     short loc_457142; jumptable 000000000045708E case 5
asn1_ex_i2c endp



asn1_ex_c2i proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r14d, ecx
    mov     r15d, edx
    mov     rbx, cont_0
    mov     r12, pval
    mov     [rbp+cont], rsi
    mov     rax, [it+20h]
    test    pf_0, pf_0
    jz      short loc_455FBF
    mov     pf_0, [pf_0+28h]
    test    rax, rax
    jz      short loc_455FBF
    mov     rdi, pval
    mov     rsi, cont_0
    mov     edx, r15d
    mov     ecx, r14d
    add     rsp, 18h
    pop     cont_0
    pop     pval
    pop     r13
    pop     utype
    pop     len
    pop     rbp
    jmp     rax
loc_455FBF:
    xor     eax, eax
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     short loc_455FFE
    mov     rax, [pval]
    test    rax, rax
    jz      loc_456055
    cmp     [typ_0], r14d
    jz      short loc_455FF5
loc_455FDA:
    mov     r13, typ_0
    mov     rdi, typ_0; a
    mov     esi, r14d; type
    xor     edx, edx; value
    mov     [rbp+var_38], r8
    call    ASN1_TYPE_set
    mov     r8, [rbp+var_38]
    mov     rax, r13
loc_455FF5:
    mov     r13, opval
    lea     r12, [rax+8]
    jmp     short loc_456001
loc_455FFE:
    xor     r13d, r13d
loc_456001:
    lea     edx, [utype-1]; switch 30 cases
    cmp     edx, 1Dh
    ja      def_45601C; jumptable 000000000045601C default case, cases 4,7-9,11-27,29
    lea     rcx, jpt_45601C
    movsxd  rdx, ds:(jpt_45601C - 6682CCh)[rcx+rdx*4]
    add     rdx, rcx
def_45601C:
    jmp     rdx; switch jump
    mov     [rbp+typ], typ_0; jumptable 000000000045601C cases 2,10
    movsxd  rdx, r15d; len
    lea     rsi, [rbp+cont]; pp
    mov     rdi, tint; a
    call    ossl_c2i_ASN1_INTEGER
    test    rax, rax
    jz      err
    mov     rax, [tint]
    mov     ecx, 100h
    and     ecx, [rax+4]
    or      ecx, r14d
    mov     [rax+4], ecx
    mov     rax, [rbp+typ]
    jmp     loc_456294
loc_456055:
    mov     r13, free_cont
    call    ASN1_TYPE_new
    test    typ_0, typ_0
    jz      loc_45618F
    mov     [pval], typ_0
    mov     r8, free_cont
    cmp     [typ_0], r14d
    jnz     loc_455FDA
    jmp     loc_455FF5
    cmp     r15d, 1; jumptable 000000000045601C case 1
    jnz     loc_456232
    movzx   eax, byte ptr [cont_0]
    mov     [tbool], eax
    mov     ebx, 1
    jmp     loc_4562F6
    mov     [rbp+typ], typ_0; jumptable 000000000045601C case 3
    movsxd  rdx, r15d; len
    lea     rsi, [rbp+cont]; pp
    mov     rdi, pval; a
    call    ossl_c2i_ASN1_BIT_STRING
    jmp     short loc_4560F7
    test    r15d, r15d; jumptable 000000000045601C case 5
    jz      loc_45628C
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 363h; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 90h
    jmp     loc_4562D5
    mov     [rbp+typ], typ_0; jumptable 000000000045601C case 6
    movsxd  rdx, r15d; len
    lea     rsi, [rbp+cont]; pp
    mov     rdi, pval; a
    call    ossl_c2i_ASN1_OBJECT
loc_4560F7:
    mov     ebx, 1
    test    rax, rax
    jnz     loc_4562F6
    jmp     err
    test    r15b, 3; jumptable 000000000045601C case 28
    jz      short def_45601C; jumptable 000000000045601C default case, cases 4,7-9,11-27,29
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 39Dh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0D7h
    jmp     loc_4562D5
    test    r15b, 1; jumptable 000000000045601C case 30
    jnz     loc_45625F
    mov     rcx, [pval]; jumptable 000000000045601C default case, cases 4,7-9,11-27,29
    test    rcx, rcx
    jz      short loc_45619D
    mov     [stmp+4], r14d
    cmp     byte ptr [r8], 0
    jz      short loc_4561CB
loc_45615D:
    mov     pval, stmp
    mov     rdi, [stmp+8]; str
    lea     rsi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    mov     edx, 3AEh; line
    mov     utype, r8
    call    CRYPTO_free
    mov     [r12+8], cont_0
    mov     [r12], r15d
    mov     byte ptr [r14], 0
    mov     ebx, 1
    jmp     loc_4562F6
loc_45618F:
    xor     ebx, ebx
    xor     edi, edi; a
    call    ASN1_TYPE_free
    jmp     loc_4562F6
loc_45619D:
    mov     [rbp+var_38], r8
    mov     [rbp+typ], typ_0
    mov     edi, r14d; type
    call    ASN1_STRING_type_new
    test    rax, rax
    jz      loc_4562AE
    mov     rcx, rax
    mov     [pval], rax
    mov     rax, [rbp+typ]
    mov     r8, [rbp+var_38]
    cmp     byte ptr [r8], 0
    jnz     short loc_45615D
loc_4561CB:
    mov     [rbp+typ], rax
    mov     utype, stmp
    mov     rdi, stmp; str
    mov     rsi, cont_0; _data
    mov     edx, r15d; len_in
    call    ASN1_STRING_set
    mov     ebx, 1
    test    eax, eax
    jnz     loc_4562F6
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 3B4h; line
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 0C0100h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rdi, r14; a
    call    ASN1_STRING_free
    mov     qword ptr [pval], 0
    jmp     err
loc_456232:
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 36Bh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 6Ah ; 'j'
    jmp     short loc_4562D5
loc_45625F:
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 399h; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0D6h
    jmp     short loc_4562D5
loc_45628C:
    mov     qword ptr [pval], 1
loc_456294:
    mov     ebx, 1
    cmp     r14d, 5
    jnz     short loc_4562F6
    test    rax, rax
    jz      short loc_4562F6
    mov     qword ptr [rax+8], 0
    jmp     short loc_4562F6
loc_4562AE:
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 3A4h; line
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 0C0100h; reason
loc_4562D5:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rdi, [rbp+typ]; a
    call    ASN1_TYPE_free
    xor     ebx, ebx
    test    opval, opval
    jz      short loc_4562F6
    mov     qword ptr [opval+0], 0
loc_4562F6:
    mov     eax, ebx
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     len
    pop     rbp
    retn
asn1_ex_c2i endp



i2c_ibuf proc
    push    rbp
    mov     rbp, rsp
    push    r14
    push    rbx
    mov     r14, pp
    mov     ecx, edx
    mov     r8, b
    xor     edi, edi
    mov     ebx, 1
    mov     eax, 0
    mov     edx, 0
    test    b, b
    jz      loc_572E04
    test    blen, blen
    jz      loc_572E04
    mov     dl, [b]
    test    ecx, ecx
    setz    bl
    test    dl, dl
    sets    al
    test    ecx, ecx
    jz      loc_572D77
    mov     al, 0FFh
    mov     edi, 1
    cmp     dl, 80h
    ja      loc_572DFC
    xor     edi, edi
    cmp     dl, 80h
    jnz     loc_572DFC
    xor     eax, eax
    cmp     ret, 2
    jb      loc_572DF4
    lea     rdx, [ret-1]
    mov     ecx, 1
    cmp     rdx, 8
    jb      loc_572DE0
    mov     rcx, rdx
    and     rcx, 0FFFFFFFFFFFFFFF8h
    lea     rdi, [rcx-8]
    mov     rax, rdi
    shr     rax, 3
    add     rax, 1
    mov     ebx, eax
    and     ebx, 1
    test    rdi, rdi
    jz      short loc_572D80
    mov     rdi, rbx
    sub     rdi, rax
    pxor    xmm2, xmm2
    mov     eax, 1
    pxor    xmm0, xmm0
    pxor    xmm1, xmm1
    nop     dword ptr [rax+rax+00000000h]
loc_572D20:
    movd    xmm3, dword ptr [b+rax]
    movd    xmm4, dword ptr [b+rax+4]
    punpcklbw xmm3, xmm2
    punpcklwd xmm3, xmm2
    por     xmm3, xmm0
    punpcklbw xmm4, xmm2
    punpcklwd xmm4, xmm2
    por     xmm4, xmm1
    movd    xmm0, dword ptr [b+rax+8]
    movd    xmm1, dword ptr [b+rax+0Ch]
    punpcklbw xmm0, xmm2
    punpcklwd xmm0, xmm2
    por     xmm0, xmm3
    punpcklbw xmm1, xmm2
    punpcklwd xmm1, xmm2
    por     xmm1, xmm4
    add     rax, 10h
    add     rdi, 2
    jnz     short loc_572D20
    jmp     short loc_572D8D
loc_572D77:
    and     bl, al
    xor     eax, eax
    movzx   edi, bl
    jmp     short loc_572DFC
loc_572D80:
    pxor    xmm0, xmm0
    mov     eax, 1
    pxor    xmm1, xmm1
loc_572D8D:
    test    rbx, rbx
    jz      short loc_572DBB
    movd    xmm2, dword ptr [b+rax+4]
    pxor    xmm3, xmm3
    punpcklbw xmm2, xmm3
    punpcklwd xmm2, xmm3
    por     xmm1, xmm2
    movd    xmm2, dword ptr [b+rax]
    punpcklbw xmm2, xmm3
    punpcklwd xmm2, xmm3
    por     xmm0, xmm2
loc_572DBB:
    por     xmm0, xmm1
    pshufd  xmm1, xmm0, 4Eh ; 'N'
    por     xmm1, xmm0
    pshufd  xmm0, xmm1, 0E5h
    por     xmm0, xmm1
    movd    eax, xmm0
    cmp     rdx, rcx
    jz      short loc_572DF0
    or      rcx, 1
    xchg    ax, ax
loc_572DE0:
    movzx   edx, byte ptr [b+i]
    or      eax, edx
    add     i, 1
    cmp     ret, i
    jnz     short loc_572DE0
loc_572DF0:
    neg     eax
    sbb     al, al
loc_572DF4:
    mov     ecx, eax
    and     cl, 1
    movzx   edi, cl
loc_572DFC:
    mov     ebx, edi
    add     rbx, ret
    mov     rdx, blen; len
loc_572E04:
    test    pp, pp
    jz      short loc_572E26
    mov     rcx, [pp]
    test    p, p
    jz      short loc_572E26
    mov     [p], al
    mov     edi, edi
    add     rdi, p; dst
    movzx   ecx, al; pad
    mov     rsi, b; src
    call    twos_complement
    add     [pp], ret
loc_572E26:
    mov     rax, ret
    pop     ret
    pop     pp
    pop     rbp
    retn
i2c_ibuf endp

