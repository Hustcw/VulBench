ASN1_TYPE_cmp proc
    mov     eax, 0FFFFFFFFh
    test    a, a
    jz      short locret_56CA4E
    test    b, b
    jz      short locret_56CA4E
    mov     ecx, [a]
    cmp     ecx, [b]
    jnz     short locret_56CA4E
    cmp     ecx, 5
    jz      short loc_56CA4C
    cmp     ecx, 6
    jnz     short loc_56CA4F
    mov     a, [a+8]
    mov     b, [b+8]
    jmp     OBJ_cmp
loc_56CA4C:
    xor     eax, eax
locret_56CA4E:
    retn
loc_56CA4F:
    mov     a, [a+8]
    mov     b, [b+8]
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
    jz      short loc_43B706
    mov     pf_0, [pf_0+30h]
    test    rax, rax
    jz      short loc_43B706
    call    rax
    jmp     loc_43B824; jumptable 000000000043B75E case 5
loc_43B706:
    mov     al, [it]
    test    al, al
    jnz     short loc_43B713
    cmp     qword ptr [it+8], 1
    jz      short loc_43B744
loc_43B713:
    mov     rbx, [pval]
    test    strtmp, strtmp
    jz      short loc_43B726
    cmp     al, 5
    jnz     short loc_43B730
    mov     eax, [strtmp+4]
    mov     [putype], eax
    jmp     short loc_43B746
loc_43B726:
    mov     eax, 0FFFFFFFFh
    jmp     loc_43B824; jumptable 000000000043B75E case 5
loc_43B730:
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     short loc_43B744
    mov     pval, [pval]
    mov     eax, [typ]
    mov     [putype], eax
    add     typ, 8
    jmp     short loc_43B746
loc_43B744:
    mov     eax, [putype]
loc_43B746:
    lea     edx, [utype-1]; switch 10 cases
    cmp     edx, 9
    ja      short def_43B75E; jumptable 000000000043B75E default case
    xor     eax, eax
    lea     rbx, jpt_43B75E
    movsxd  rdx, ds:(jpt_43B75E - 613DF8h)[rbx+rdx*4]
    add     rdx, rbx
def_43B75E:
    jmp     rdx; switch jump
    mov     edx, [tbool]; jumptable 000000000043B75E case 1
    mov     eax, 0FFFFFFFFh
    cmp     edx, 0FFFFFFFFh
    jz      loc_43B824; jumptable 000000000043B75E case 5
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     loc_43B82B
loc_43B77B:
    mov     [rbp+c], dl
    mov     ebx, 1
    lea     rcx, [rbp+c]
    test    cout, cout
    jnz     loc_43B810
    jmp     loc_43B822
    cmp     eax, 102h; jumptable 000000000043B75E default case
    jz      short loc_43B7A3; jumptable 000000000043B75E cases 2,10
    cmp     eax, 10Ah
    jnz     short loc_43B7BB; jumptable 000000000043B75E cases 4,7-9
loc_43B7A3:
    mov     pval, [pval]; jumptable 000000000043B75E cases 2,10
    test    cout, cout
    lea     rax, [rbp+var_18]
    cmovz   rax, cout
    mov     cout, rax; pp
    call    ossl_i2c_ASN1_INTEGER
    jmp     short loc_43B824; jumptable 000000000043B75E case 5
loc_43B7BB:
    mov     rdx, [pval]; jumptable 000000000043B75E cases 4,7-9
    cmp     qword ptr [it+28h], 800h
    jnz     short loc_43B7CE
    test    byte ptr [strtmp+10h], 10h
    jnz     short loc_43B83D
loc_43B7CE:
    mov     it, [strtmp+8]
    mov     ebx, [strtmp]
    test    cout, cout
    jnz     short loc_43B810
    jmp     short loc_43B822
    mov     pval, [pval]; jumptable 000000000043B75E case 3
    test    cout, cout
    lea     rax, [rbp+var_18]
    cmovz   rax, cout
    mov     cout, rax; pp
    call    ossl_i2c_ASN1_BIT_STRING
    jmp     short loc_43B824; jumptable 000000000043B75E case 5
    mov     rdx, [pval]; jumptable 000000000043B75E case 6
    mov     it, [otmp+18h]
    mov     eax, 0FFFFFFFFh
    test    cont, cont
    jz      short loc_43B824; jumptable 000000000043B75E case 5
    mov     ebx, [otmp+14h]
    test    ebx, ebx
    jz      short loc_43B824; jumptable 000000000043B75E case 5
    test    cout, cout
    jz      short loc_43B822
loc_43B810:
    test    ebx, ebx
    jz      short loc_43B822
    movsxd  rdx, ebx; n
    mov     pval, cout; dest
    mov     cout, cont; src
    call    _memcpy
loc_43B822:
    mov     eax, ebx
loc_43B824:
    add     rsp, 18h; jumptable 000000000043B75E case 5
    pop     rbx
    pop     rbp
    retn
loc_43B82B:
    mov     it, [it+28h]
    test    edx, edx
    jz      short loc_43B853
    test    rcx, rcx
    jg      short loc_43B824; jumptable 000000000043B75E case 5
    jmp     loc_43B77B
loc_43B83D:
    mov     eax, 0FFFFFFFEh
    test    cout, cout
    jz      short loc_43B824; jumptable 000000000043B75E case 5
    mov     [strtmp+8], cout
    mov     dword ptr [strtmp], 0
    jmp     short loc_43B824; jumptable 000000000043B75E case 5
loc_43B853:
    test    rcx, rcx
    jnz     loc_43B77B
    jmp     short loc_43B824; jumptable 000000000043B75E case 5
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
    jz      short loc_43A66F
    mov     pf_0, [pf_0+28h]
    test    rax, rax
    jz      short loc_43A66F
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
loc_43A66F:
    xor     eax, eax
    cmp     qword ptr [it+8], 0FFFFFFFFFFFFFFFCh
    jnz     short loc_43A6AE
    mov     rax, [pval]
    test    rax, rax
    jz      loc_43A752
    cmp     [typ_0], r14d
    jz      short loc_43A6A5
loc_43A68A:
    mov     r13, typ_0
    mov     rdi, typ_0; a
    mov     esi, r14d; type
    xor     edx, edx; value
    mov     [rbp+var_38], r8
    call    ASN1_TYPE_set
    mov     r8, [rbp+var_38]
    mov     rax, r13
loc_43A6A5:
    mov     r13, opval
    lea     r12, [rax+8]
    jmp     short loc_43A6B1
loc_43A6AE:
    xor     r13d, r13d
loc_43A6B1:
    lea     edx, [utype-1]; switch 30 cases
    cmp     edx, 1Dh
    ja      short def_43A6C8; jumptable 000000000043A6C8 default case
    lea     rcx, jpt_43A6C8
    movsxd  rdx, ds:(jpt_43A6C8 - 613B7Ch)[rcx+rdx*4]
    add     rdx, rcx
def_43A6C8:
    jmp     rdx; switch jump
    cmp     r15d, 1; jumptable 000000000043A6C8 case 1
    jnz     loc_43A914
    movzx   eax, byte ptr [cont_0]
    mov     [tbool], eax
    mov     ebx, 1
    jmp     loc_43A9C3
    cmp     r14d, 102h; jumptable 000000000043A6C8 default case
    jz      short loc_43A6FB; jumptable 000000000043A6C8 cases 2,10
    cmp     r14d, 10Ah
    jnz     loc_43A82C; jumptable 000000000043A6C8 cases 4,7-9,11-27,29
loc_43A6FB:
    mov     [rbp+typ], typ_0; jumptable 000000000043A6C8 cases 2,10
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
loc_43A72D:
    mov     ebx, 1
    cmp     r14d, 5
    jnz     loc_43A9C3
    test    rax, rax
    jz      loc_43A9C3
    mov     qword ptr [rax+8], 0
    jmp     loc_43A9C3
loc_43A752:
    mov     r13, free_cont
    call    ASN1_TYPE_new
    test    typ_0, typ_0
    jz      loc_43A871
    mov     [pval], typ_0
    mov     r8, free_cont
    cmp     [typ_0], r14d
    jnz     loc_43A68A
    jmp     loc_43A6A5
    mov     [rbp+typ], typ_0; jumptable 000000000043A6C8 case 3
    movsxd  rdx, r15d; len
    lea     rsi, [rbp+cont]; pp
    mov     rdi, pval; a
    call    ossl_c2i_ASN1_BIT_STRING
    jmp     short loc_43A7D9
    test    r15d, r15d; jumptable 000000000043A6C8 case 5
    jz      loc_43A96E
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 363h; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 90h
    jmp     loc_43A9A2
    mov     [rbp+typ], typ_0; jumptable 000000000043A6C8 case 6
    movsxd  rdx, r15d; len
    lea     rsi, [rbp+cont]; pp
    mov     rdi, pval; a
    call    ossl_c2i_ASN1_OBJECT
loc_43A7D9:
    mov     ebx, 1
    test    rax, rax
    jnz     loc_43A9C3
    jmp     err
    test    r15b, 3; jumptable 000000000043A6C8 case 28
    jz      short loc_43A82C; jumptable 000000000043A6C8 cases 4,7-9,11-27,29
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 39Dh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0D7h
    jmp     loc_43A9A2
    test    r15b, 1; jumptable 000000000043A6C8 case 30
    jnz     loc_43A941
loc_43A82C:
    mov     rcx, [pval]; jumptable 000000000043A6C8 cases 4,7-9,11-27,29
    test    rcx, rcx
    jz      short loc_43A87F
    mov     [stmp+4], r14d
    cmp     byte ptr [r8], 0
    jz      short loc_43A8AD
loc_43A83F:
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
    jmp     loc_43A9C3
loc_43A871:
    xor     ebx, ebx
    xor     edi, edi; a
    call    ASN1_TYPE_free
    jmp     loc_43A9C3
loc_43A87F:
    mov     [rbp+var_38], r8
    mov     [rbp+typ], typ_0
    mov     edi, r14d; type
    call    ASN1_STRING_type_new
    test    rax, rax
    jz      loc_43A97B
    mov     rcx, rax
    mov     [pval], rax
    mov     rax, [rbp+typ]
    mov     r8, [rbp+var_38]
    cmp     byte ptr [r8], 0
    jnz     short loc_43A83F
loc_43A8AD:
    mov     [rbp+typ], rax
    mov     utype, stmp
    mov     rdi, stmp; str
    mov     rsi, cont_0; _data
    mov     edx, r15d; len_in
    call    ASN1_STRING_set
    mov     ebx, 1
    test    eax, eax
    jnz     loc_43A9C3
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
loc_43A914:
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 36Bh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 6Ah ; 'j'
    jmp     short loc_43A9A2
loc_43A941:
    mov     [rbp+typ], typ_0
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 399h; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0D6h
    jmp     short loc_43A9A2
loc_43A96E:
    mov     qword ptr [pval], 1
    jmp     loc_43A72D
loc_43A97B:
    call    ERR_new
    lea     rdi, aCryptoAsn1Tasn; "crypto/asn1/tasn_dec.c"
    lea     rdx, aAsn1ExC2i; "asn1_ex_c2i"
    mov     esi, 3A4h; line
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 0C0100h; reason
loc_43A9A2:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rdi, [rbp+typ]; a
    call    ASN1_TYPE_free
    xor     ebx, ebx
    test    opval, opval
    jz      short loc_43A9C3
    mov     qword ptr [opval+0], 0
loc_43A9C3:
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
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     r14, pp
    mov     r10, b
    xor     ecx, ecx
    mov     r15d, 1
    mov     edi, 0
    mov     ebx, 0
    test    b, b
    jz      loc_42FE65
    test    blen, blen
    jz      loc_42FE65
    mov     bl, [b]
    test    edx, edx
    setz    cl
    test    bl, bl
    sets    al
    test    edx, edx
    jz      loc_42FDD8
    mov     dil, 0FFh
    mov     ecx, 1
    cmp     bl, 80h
    ja      loc_42FE5C
    xor     ecx, ecx
    cmp     bl, 80h
    jnz     loc_42FE5C
    xor     edi, edi
    cmp     ret, 2
    jb      loc_42FE55
    lea     r8, [ret-1]
    mov     ecx, 1
    cmp     r8, 8
    jb      loc_42FE40
    mov     rcx, r8
    and     rcx, 0FFFFFFFFFFFFFFF8h
    lea     rax, [rcx-8]
    mov     rdi, rax
    shr     rdi, 3
    add     rdi, 1
    mov     r9d, edi
    and     r9d, 1
    test    rax, rax
    jz      short loc_42FDE1
    mov     rbx, r9
    sub     rbx, rdi
    pxor    xmm2, xmm2
    xor     edi, edi
    pxor    xmm0, xmm0
    pxor    xmm1, xmm1
    nop     word ptr [rax+rax+00h]
loc_42FD80:
    movd    xmm3, dword ptr [b+rdi+1]
    movd    xmm4, dword ptr [b+rdi+5]
    punpcklbw xmm3, xmm2
    punpcklwd xmm3, xmm2
    por     xmm3, xmm0
    punpcklbw xmm4, xmm2
    punpcklwd xmm4, xmm2
    por     xmm4, xmm1
    movd    xmm0, dword ptr [b+rdi+9]
    movd    xmm1, dword ptr [b+rdi+0Dh]
    punpcklbw xmm0, xmm2
    punpcklwd xmm0, xmm2
    por     xmm0, xmm3
    punpcklbw xmm1, xmm2
    punpcklwd xmm1, xmm2
    por     xmm1, xmm4
    add     rdi, 10h
    add     rbx, 2
    jnz     short loc_42FD80
    jmp     short loc_42FDEB
loc_42FDD8:
    and     cl, al
    xor     edi, edi
    movzx   ecx, cl
    jmp     short loc_42FE5C
loc_42FDE1:
    pxor    xmm0, xmm0
    xor     edi, edi
    pxor    xmm1, xmm1
loc_42FDEB:
    test    r9, r9
    jz      short loc_42FE1D
    or      rdi, 1
    movd    xmm2, dword ptr [b+rdi+4]
    pxor    xmm3, xmm3
    punpcklbw xmm2, xmm3
    punpcklwd xmm2, xmm3
    por     xmm1, xmm2
    movd    xmm2, dword ptr [b+rdi]
    punpcklbw xmm2, xmm3
    punpcklwd xmm2, xmm3
    por     xmm0, xmm2
loc_42FE1D:
    por     xmm0, xmm1
    pshufd  xmm1, xmm0, 4Eh ; 'N'
    por     xmm1, xmm0
    pshufd  xmm0, xmm1, 0E5h
    por     xmm0, xmm1
    movd    edi, xmm0
    cmp     r8, rcx
    jz      short loc_42FE50
    or      rcx, 1
loc_42FE40:
    movzx   eax, byte ptr [b+i]
    or      edi, eax
    add     i, 1
    cmp     ret, i
    jnz     short loc_42FE40
loc_42FE50:
    neg     edi
    sbb     dil, dil
loc_42FE55:
    mov     eax, edi
    and     al, 1
    movzx   ecx, al
loc_42FE5C:
    mov     r15d, ecx
    add     r15, ret
    mov     rbx, blen
loc_42FE65:
    test    pp, pp
    jz      loc_430077
    mov     rsi, [pp]
    test    p, p
    jz      loc_430077
    mov     [p], dil
    mov     edi, ecx
    add     rdi, p; dest
    test    i, i
    jz      loc_42FF9C
    test    edx, edx
    jz      loc_42FFA4
    lea     pad, [i-1]
    mov     dl, [b+i-1]
    test    dl, dl
    jz      short loc_42FEB0
    add     b, i
    add     rdi, i
    add     rdi, 0FFFFFFFFFFFFFFFFh
    jmp     short loc_42FECC
loc_42FEB0:
    mov     byte ptr [rdi+rcx], 0
    movzx   edx, byte ptr [b+rcx-1]
    add     rcx, 0FFFFFFFFFFFFFFFFh
    test    dl, dl
    jz      short loc_42FEB0
    add     b, rcx
    add     r10, 1
    add     rdi, rcx
loc_42FECC:
    neg     dl
    mov     [rdi], dl
    test    i, i
    jz      loc_430074
    lea     rdx, [r10-2]
    cmp     i, 10h
    jb      loc_42FFFA
    mov     rax, rdi
    sub     rax, i
    lea     rsi, [r10-1]
    cmp     rax, rsi
    jnb     short loc_42FF08
    mov     rax, i
    not     rax
    add     rax, r10
    cmp     rax, rdi
    jb      loc_42FFFA
loc_42FF08:
    mov     r8, i
    and     r8, 0FFFFFFFFFFFFFFF0h
    lea     rax, [r8-10h]
    mov     blen, rax
    shr     rbx, 4
    add     rbx, 1
    mov     r9d, ebx
    and     r9d, 1
    test    rax, rax
    jz      loc_42FFB3
    sub     rbx, r9
    xor     esi, esi
    movdqa  xmm0, cs:xmmword_612D50
    nop     dword ptr [rax+rax+00h]
loc_42FF40:
    movq    xmm1, qword ptr [r10+rsi-9]
    punpcklbw xmm1, xmm0
    movq    xmm2, qword ptr [r10+rsi-11h]
    punpcklbw xmm2, xmm0
    pandn   xmm1, xmm0
    pandn   xmm2, xmm0
    packuswb xmm2, xmm1
    movdqu  xmmword ptr [rdi+rsi-10h], xmm2
    movq    xmm1, qword ptr [r10+rsi-19h]
    punpcklbw xmm1, xmm0
    movq    xmm2, qword ptr [r10+rsi-21h]
    punpcklbw xmm2, xmm0
    pandn   xmm1, xmm0
    pandn   xmm2, xmm0
    packuswb xmm2, xmm1
    movdqu  xmmword ptr [rdi+rsi-20h], xmm2
    add     rsi, 0FFFFFFFFFFFFFFE0h
    add     rbx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_42FF40
    jmp     short loc_42FFB5
loc_42FF9C:
    mov     byte ptr [rdi], 0
    jmp     loc_430074
loc_42FFA4:
    mov     edx, ebx; n
    mov     rsi, b; src
    call    _memcpy
    jmp     loc_430074
loc_42FFB3:
    xor     esi, esi
loc_42FFB5:
    test    r9, r9
    jz      short loc_42FFE8
    movq    xmm0, qword ptr [n+rsi-7]
    punpcklbw xmm0, xmm0
    movq    xmm1, qword ptr [n+rsi-0Fh]
    punpcklbw xmm1, xmm0
    movdqa  xmm2, cs:xmmword_612D50
    pandn   xmm0, xmm2
    pandn   xmm1, xmm2
    packuswb xmm1, xmm0
    movdqu  xmmword ptr [rdi+rsi-10h], xmm1
loc_42FFE8:
    cmp     i, r8
    jz      loc_430074
    sub     i, r8
    sub     n, r8
    sub     rdi, r8
loc_42FFFA:
    lea     rax, [rcx-1]
    mov     rsi, rcx
    and     rsi, 3
    jz      short loc_43002A
    nop     word ptr [rax+rax+00000000h]
loc_430010:
    movzx   ebx, byte ptr [rdx]
    not     bl
    mov     [rdi-1], bl
    add     rdi, 0FFFFFFFFFFFFFFFFh
    add     rdx, 0FFFFFFFFFFFFFFFFh
    add     rcx, 0FFFFFFFFFFFFFFFFh
    add     rsi, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_430010
loc_43002A:
    cmp     rax, 3
    jb      short loc_430074
    neg     rcx
    xor     eax, eax
    nop     word ptr [rax+rax+00000000h]
    nop
loc_430040:
    movzx   ebx, byte ptr [rdx+rax]
    not     bl
    mov     [rdi+rax-1], bl
    movzx   ebx, byte ptr [rdx+rax-1]
    not     bl
    mov     [rdi+rax-2], bl
    movzx   ebx, byte ptr [rdx+rax-2]
    not     bl
    mov     [rdi+rax-3], bl
    movzx   ebx, byte ptr [rdx+rax-3]
    not     bl
    mov     [rdi+rax-4], bl
    add     rax, 0FFFFFFFFFFFFFFFCh
    cmp     rcx, rax
    jnz     short loc_430040
loc_430074:
    add     [pp], ret
loc_430077:
    mov     rax, ret
    add     rsp, 8
    pop     rbx
    pop     pp
    pop     ret
    pop     rbp
    retn
i2c_ibuf endp

