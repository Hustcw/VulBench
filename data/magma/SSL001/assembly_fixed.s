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

