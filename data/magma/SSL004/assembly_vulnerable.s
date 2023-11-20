X509_NAME_oneline proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0A8h
    mov     rbx, buf_0
    mov     r13, a
    test    rsi, rsi
    jz      loc_41A1F4
    mov     r14d, edx
    xor     r12d, r12d
    test    edx, edx
    jz      loc_41A278
    test    a, a
    jz      loc_41A23A
loc_419CFA:
    mov     [rbp+b], b_0
    mov     [rbp+buf], buf_0
    mov     rdi, [a+0]; sk
    call    ossl_check_const_X509_NAME_ENTRY_sk_type
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_41A284
    mov     [rbp+len], r14d
    xor     eax, eax
    mov     [rbp+lold], rax
    mov     [rbp+prev_set], 0FFFFFFFFh
    xor     r12d, r12d
    mov     [rbp+var_70], a
    jmp     short loc_419D77
loc_419D40:
    mov     r13, [rbp+var_70]
    mov     r12d, [rbp+i]
loc_419D48:
    mov     byte ptr [p], 0
    mov     p, [rbp+ne]
    mov     eax, [rax+10h]
    mov     [rbp+prev_set], eax
    add     r12d, 1
    mov     rdi, [r13+0]; sk
    call    ossl_check_const_X509_NAME_ENTRY_sk_type
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    mov     [rbp+lold], r14
    cmp     r12d, eax
    jge     loc_41A287
loc_419D77:
    mov     rdi, [a+0]; sk
    call    ossl_check_const_X509_NAME_ENTRY_sk_type
    mov     rdi, rax; st
    mov     esi, r12d; i
    call    OPENSSL_sk_value
    mov     r14, rax
    mov     rdi, [rax]; a
    call    OBJ_obj2nid
    test    eax, eax
    jz      short loc_419DA6
    mov     edi, eax; n
    call    OBJ_nid2sn
    test    s_0, s_0
    jnz     short loc_419DC0
loc_419DA6:
    mov     rdx, [ne_0]; a
    lea     rbx, [rbp+tmp_buf]
    mov     rdi, rbx; buf
    mov     esi, 50h ; 'P'; buf_len
    call    i2t_ASN1_OBJECT
    mov     rax, rbx
loc_419DC0:
    mov     [rbp+s], s_0
    mov     rdi, rax; s
    call    _strlen
    mov     rcx, [ne_0+8]
    mov     r15d, [rcx]
    cmp     r15d, 100000h
    jg      loc_41A2BA
    mov     r8, [rcx+8]
    test    r15b, 3
    jnz     loc_41A043
    cmp     dword ptr [rcx+4], 1Bh
    jnz     loc_41A043
    pxor    xmm6, xmm6
    movdqa  xmmword ptr [rbp+var_40], xmm6
    test    r15d, r15d
    movdqa  xmm7, cs:xmmword_611180
    movdqa  xmm8, xmm7
    movdqa  xmm7, cs:xmmword_611190
    pcmpeqd xmm9, xmm9
    movdqa  xmm10, cs:xmmword_6111A0
    jle     loc_419FAF
    cmp     r15d, 8
    jb      loc_419FC1
    lea     rdx, [num-1]
    mov     ecx, 0
    cmp     rdx, 3
    ja      loc_419FC3
    mov     ecx, r15d
    and     ecx, 0FFFFFFF8h
    xor     edx, edx
    movdqa  xmm0, cs:xmmword_611170
    movdqa  xmm1, cs:xmmword_611160
    jmp     short loc_419E87
loc_419E70:
    add     rdx, 8
    paddq   xmm0, xmm10
    paddq   xmm1, xmm10
    cmp     rcx, rdx
    jz      loc_419FBA
loc_419E87:
    movd    xmm5, dword ptr [q+rdx]
    punpcklbw xmm5, xmm0
    punpcklwd xmm5, xmm0
    pand    xmm5, xmm8
    movd    xmm2, dword ptr [q+rdx+4]
    pcmpeqd xmm5, xmm6
    movdqa  xmm3, xmm0
    pand    xmm3, xmm7
    movd    esi, xmm5
    not     esi
    test    sil, 1
    jz      short loc_419EC6
    movq    rsi, xmm3
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419EC6:
    pxor    xmm5, xmm9
    pextrw  esi, xmm5, 2
    test    sil, 1
    jz      short loc_419EE8
    pshufd  xmm4, xmm3, 4Eh ; 'N'
    movq    rsi, xmm4
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419EE8:
    punpcklbw xmm2, xmm0
    movdqa  xmm4, xmm1
    pand    xmm4, xmm7
    pextrw  esi, xmm5, 4
    test    sil, 1
    jz      short loc_419F0C
    movq    rsi, xmm4
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419F0C:
    punpcklwd xmm2, xmm0
    pextrw  esi, xmm5, 6
    test    sil, 1
    jz      short loc_419F2D
    pshufd  xmm5, xmm4, 4Eh ; 'N'
    movq    rsi, xmm5
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419F2D:
    pand    xmm2, xmm8
    pcmpeqd xmm2, xmm6
    movd    esi, xmm2
    not     esi
    test    sil, 1
    jz      short loc_419F4F
    movq    rsi, xmm3
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419F4F:
    pxor    xmm2, xmm9
    pextrw  esi, xmm2, 2
    test    sil, 1
    jz      short loc_419F71
    pshufd  xmm3, xmm3, 4Eh ; 'N'
    movq    rsi, xmm3
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419F71:
    pextrw  esi, xmm2, 4
    test    sil, 1
    jz      short loc_419F89
    movq    rsi, xmm4
    mov     dword ptr [rbp+rsi*4+var_40], 1
loc_419F89:
    pextrw  esi, xmm2, 6
    test    sil, 1
    jz      loc_419E70
    pshufd  xmm2, xmm4, 4Eh ; 'N'
    movq    rsi, xmm2
    mov     dword ptr [rbp+rsi*4+var_40], 1
    jmp     loc_419E70
loc_419FAF:
    xor     ecx, ecx
    xor     edx, edx
    xor     esi, esi
    jmp     loc_41A039
loc_419FBA:
    cmp     rcx, num
    jnz     short loc_419FC3
    jmp     short loc_41A030
loc_419FC1:
    xor     ecx, ecx
loc_419FC3:
    mov     rdx, j
    not     rdx
    test    r15b, 1
    jz      short loc_419FE1
    cmp     byte ptr [q+j], 0
    jz      short loc_419FDD
    mov     dword ptr [rbp+var_40], 1
loc_419FDD:
    or      j, 1
loc_419FE1:
    add     rdx, num
    jnz     short loc_419FF9
    jmp     short loc_41A030
loc_419FF0:
    add     rcx, 2
    cmp     num, rcx
    jz      short loc_41A030
loc_419FF9:
    cmp     byte ptr [q+j], 0
    jz      short loc_41A00D
    mov     edx, ecx
    and     edx, 3
    mov     dword ptr [rbp+rdx*4+var_40], 1
loc_41A00D:
    cmp     byte ptr [q+rcx+1], 0
    jz      short loc_419FF0
    lea     rdx, [rcx+1]
    and     edx, 3
    mov     dword ptr [rbp+rdx*4+var_40], 1
    jmp     short loc_419FF0
loc_41A030:
    mov     esi, dword ptr [rbp+var_40]
    mov     edx, dword ptr [rbp+var_40+4]
    mov     ecx, dword ptr [rbp+var_40+8]
loc_41A039:
    or      edx, esi
    or      edx, ecx
    jz      loc_41A1E7
loc_41A043:
    movdqa  xmm0, cs:xmmword_611150
loc_41A04B:
    movdqa  xmmword ptr [rbp+var_40], xmm0
    test    r15d, r15d
    jle     short loc_41A0A0
    xor     edx, edx
    xor     edi, edi
    jmp     short loc_41A07E
loc_41A060:
    add     cl, 0E0h
    xor     esi, esi
    cmp     cl, 5Eh ; '^'
    setnbe  sil
    lea     ecx, [rsi+rsi*2]
    lea     edi, [l2+rcx]
    add     edi, 1
loc_41A075:
    add     j, 1
    cmp     num, rdx
    jz      short loc_41A0A2
loc_41A07E:
    mov     esi, edx
    and     esi, 3
    cmp     dword ptr [rbp+rsi*4+var_40], 0
    jz      short loc_41A075
    movzx   ecx, byte ptr [q+j]
    mov     ebx, ecx
    or      bl, 4
    cmp     bl, 2Fh ; '/'
    jnz     short loc_41A060
    add     edi, 2
    jmp     short loc_41A075
loc_41A0A0:
    xor     edi, edi
loc_41A0A2:
    mov     [rbp+ne], ne_0
    add     edi, dword ptr [rbp+lold]
    lea     r14d, [l1+rdi]
    add     r14d, 2
    cmp     r14d, 100000h
    jg      loc_41A2CC
    mov     ebx, r12d
    mov     r12, [rbp+b]
    test    r12, r12
    jz      short loc_41A100
    mov     a, l1
    lea     eax, [l_0+1]
    movsxd  rsi, eax; len
    mov     rdi, r12; str
    call    BUF_MEM_grow
    test    rax, rax
    jz      loc_41A2DE
    mov     rsi, [r12+8]
    mov     r12d, ebx
    mov     rax, r13
    jmp     short loc_41A111
loc_41A100:
    mov     rsi, [rbp+buf]
    cmp     r14d, [rbp+len]
    mov     r12d, ebx
    jge     loc_41A2AC
loc_41A111:
    mov     [rbp+i], r12d
    movsxd  rcx, dword ptr [rbp+lold]
    lea     rbx, [rsi+rcx]
    mov     r13, [rbp+ne]
    mov     edx, [rbp+prev_set]
    cmp     edx, [r13+10h]
    setnz   dl
    shl     dl, 2
    or      dl, 2Bh
    lea     rdi, [rsi+rcx]
    add     rdi, 1; dest
    mov     [rsi+rcx], dl
    mov     edx, eax; n
    mov     rsi, [rbp+s]; src
    mov     r12, rax
    call    _memcpy
    movsxd  rcx, r12d
    lea     rax, [rcx+rbx]
    add     rax, 2
    mov     byte ptr [rcx+rbx+1], 3Dh ; '='
    test    r15d, r15d
    jle     loc_419D40
    mov     rcx, [r13+8]
    mov     rcx, [rcx+8]
    xor     edx, edx
    mov     r13, [rbp+var_70]
    lea     r8, Hex_0; "0123456789ABCDEF"
    mov     r12d, [rbp+i]
    jmp     short loc_41A1B4
loc_41A180:
    movzx   esi, sil
    mov     word ptr [rax], 785Ch
    mov     rdi, rsi
    shr     rdi, 4
    movzx   ebx, byte ptr [rdi+r8]
    mov     [rax+2], bl
    and     esi, 0Fh
    movzx   ebx, byte ptr [rsi+r8]
    mov     [rax+3], bl
    add     rax, 4
loc_41A1A7:
    add     j, 1
    cmp     num, rdx
    jz      loc_419D48
loc_41A1B4:
    mov     esi, edx
    and     esi, 3
    cmp     dword ptr [rbp+rsi*4+var_40], 0
    jz      short loc_41A1A7
    movzx   esi, byte ptr [q+j]
    lea     edi, [rsi-20h]
    cmp     dil, 5Fh ; '_'
    jnb     short loc_41A180
    mov     ebx, esi
    or      bl, 4
    cmp     bl, 2Fh ; '/'
    jnz     short loc_41A1DE
    mov     byte ptr [p], 5Ch ; '\'
    add     p, 1
loc_41A1DE:
    mov     [p], sil
    add     p, 1
    jmp     short loc_41A1A7
loc_41A1E7:
    movdqa  xmm0, cs:xmmword_6111B0
    jmp     loc_41A04B
loc_41A1F4:
    call    BUF_MEM_new
    mov     r14d, 0C4h
    mov     r15d, 0C0100h
    test    b_0, b_0
    jz      short loc_41A27F
    mov     esi, 0C8h; len
    mov     r12, b_0
    mov     rdi, b_0; str
    call    BUF_MEM_grow
    test    rax, rax
    jz      loc_41A2EA
    mov     rax, [r12+8]
    mov     byte ptr [rax], 0
    mov     r14d, 0C8h
    test    a, a
    jnz     loc_419CFA
loc_41A23A:
    test    b_0, b_0
    jz      short loc_41A258
    mov     buf_0, [b_0+8]
    lea     rsi, aCryptoX509X509_1; "crypto/x509/x509_obj.c"
    mov     rdi, b_0; str
    mov     edx, 37h ; '7'; line
    call    CRYPTO_free
loc_41A258:
    movsxd  len_0, r14d
    lea     rsi, aNoX509Name; "NO X509_NAME"
    mov     rdi, buf_0; dest
    mov     rdx, r14; n
    call    _strncpy
    mov     byte ptr [r14+buf_0-1], 0
    jmp     loc_41A320
loc_41A278:
    xor     ebx, ebx
    jmp     loc_41A320
loc_41A27F:
    xor     r12d, r12d
    jmp     short loc_41A2EA
loc_41A284:
    xor     r12d, r12d
loc_41A287:
    mov     rdi, [rbp+b]; str
    test    rdi, rdi
    jz      short loc_41A2AC
    mov     rbx, [rdi+8]
    lea     rsi, aCryptoX509X509_1; "crypto/x509/x509_obj.c"
    mov     edx, 0BDh; line
    call    CRYPTO_free
    test    r12d, r12d
    jnz     short loc_41A320
    jmp     short loc_41A2B5
loc_41A2AC:
    mov     rbx, [rbp+buf]
    test    r12d, r12d
    jnz     short loc_41A320
loc_41A2B5:
    mov     byte ptr [p], 0
    jmp     short loc_41A320
loc_41A2BA:
    mov     r15d, 86h
    mov     r14d, 4Ch ; 'L'
    mov     i_0, [rbp+b]
    jmp     short loc_41A2EA
loc_41A2CC:
    mov     r15d, 86h
    mov     r14d, 87h
    mov     i_0, [rbp+b]
    jmp     short loc_41A2EA
loc_41A2DE:
    mov     r15d, 0C0100h
    mov     r14d, 0C4h
loc_41A2EA:
    call    ERR_new
    lea     rdi, aCryptoX509X509_1; "crypto/x509/x509_obj.c"
    lea     rdx, aX509NameOnelin; "X509_NAME_oneline"
    mov     esi, r14d; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 0Bh; lib
    mov     esi, r15d; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rdi, b_0; a
    call    BUF_MEM_free
loc_41A320:
    mov     rax, rbx
    add     rsp, 0A8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
X509_NAME_oneline endp

