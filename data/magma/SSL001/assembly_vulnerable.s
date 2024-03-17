

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

