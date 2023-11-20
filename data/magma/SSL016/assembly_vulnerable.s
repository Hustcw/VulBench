BN_GF2m_mod_inv_vartime proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 98h
    mov     r14, ctx_0
    mov     r13, p_0
    mov     r15, a
    mov     [rbp+r], r_0
    mov     rdi, rcx; ctx
    call    BN_CTX_start
    mov     rdi, ctx_0; ctx
    call    BN_CTX_get
    mov     r12, rax
    mov     rdi, ctx_0; ctx
    call    BN_CTX_get
    mov     [rbp+c], rax
    mov     rdi, ctx_0; ctx
    call    BN_CTX_get
    mov     rbx, rax
    mov     rdi, ctx_0; ctx
    call    BN_CTX_get
    test    v_0, v_0
    jz      loc_5F9204
    mov     dword ptr [rbp+ret], 0
    mov     [rbp+v], v_0
    mov     rdi, u_0; r
    mov     rsi, a; a
    mov     [rbp+p], p_0
    mov     rdx, r13; p
    call    BN_GF2m_mod
    test    eax, eax
    jz      err
    mov     rdi, u_0; a
    call    BN_is_zero
    test    eax, eax
    jnz     err
    mov     r13, [rbp+v]
    mov     rdi, r13; a
    mov     a, [rbp+p]
    mov     rsi, r15; b
    call    BN_copy
    test    rax, rax
    jz      err
    mov     rdi, u_0; a
    call    BN_num_bits
    mov     [rbp+ubits], rax
    mov     rdi, r13; a
    call    BN_num_bits
    mov     [rbp+vbits], eax
    mov     r15d, [r15+8]
    mov     rdi, u_0; a
    mov     esi, r15d; words
    call    bn_wexpand
    test    rax, rax
    jz      err
    mov     [rbp+b], b_0
    mov     r12, [u_0]
    movsxd  rax, dword ptr [u_0+8]
    cmp     eax, r15d
    mov     [rbp+var_38], top
    jge     short loc_5F911F
    lea     rdi, [udp+i*8]; s
    not     eax
    add     eax, r15d
    lea     rdx, ds:8[rax*8]; n
    xor     esi, esi; c
    call    _memset
    mov     top, [rbp+var_38]
loc_5F911F:
    mov     [rbp+tmp], u_0
    mov     [rbx+8], r15d
    mov     rbx, [rbp+b]
    mov     rdi, rbx; a
    mov     esi, r15d; words
    call    bn_wexpand
    test    rax, rax
    jz      err
    mov     r13, [rbx]
    mov     qword ptr [bdp+0], 1
    cmp     r15d, 2
    jl      short loc_5F916A
    lea     rdi, [bdp+8]; s
    lea     edx, [r15-1]
    shl     rdx, 3; n
    xor     esi, esi; c
    call    _memset
    mov     r15, [rbp+var_38]
loc_5F916A:
    mov     rax, [rbp+b]
    mov     [rax+8], r15d
    mov     rbx, [rbp+c]
    mov     rdi, rbx; a
    mov     esi, r15d; words
    call    bn_wexpand
    test    rax, rax
    jz      err
    mov     [rbp+ctx], ctx_0
    mov     r14, [rbx]
    test    r15d, r15d
    mov     rcx, r15
    jle     short loc_5F91B2
    lea     rdx, ds:0[rcx*8]; n
    mov     rdi, cdp_0; s
    xor     esi, esi; c
    call    _memset
    mov     rcx, [rbp+var_38]
loc_5F91B2:
    mov     [rbp+cdp], cdp_0
    mov     [rbx+8], ecx
    mov     rax, [rbp+v]
    mov     rax, [rax]
    lea     r15d, [rcx-1]
    lea     rdx, [r15+1]
    mov     [rbp+ret], rdx
    mov     edx, r15d
    and     edx, 0FFFFFFFEh
    mov     [rbp+var_B8], rdx
    mov     edx, ecx
    and     edx, 0FFFFFFFCh
    mov     [rbp+var_A0], rdx
    neg     rcx
    mov     [rbp+var_A8], rcx
    mov     [rbp+vdp], vdp_0
    mov     [rbp+var_50], rax
    mov     r8, [rbp+p]
    mov     r14, [rbp+ubits]
    jmp     short loc_5F923F
loc_5F9204:
    mov     dword ptr [rbp+ret], 0
    mov     rdi, r14; ctx
    call    BN_CTX_end
    mov     eax, dword ptr [rbp+ret]
    add     rsp, 98h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_5F9230:
    call    BN_num_bits_word
    sub     eax, r14d
    mov     r14, rax
    mov     r8, [rbp+p]
loc_5F923F:
    mov     r10, [udp]
    test    r14d, r14d
    jz      loc_5F9430
    mov     rax, [rbp+ret]
    lea     rcx, [udp+rax*8]
    lea     rax, ds:0[rax*8]
    add     rax, bdp
    mov     [rbp+var_80], rax
    cmp     udp, rax
    setb    al
    mov     [rbp+ubits], rcx
    cmp     bdp, rcx
    setb    cl
    and     cl, al
    mov     [rbp+var_2D], cl
    mov     r11d, r14d
    test    r10b, 1
    jz      short loc_5F92BB
    jmp     loc_5F94D0
loc_5F9290:
    xor     eax, eax
loc_5F9292:
    shr     u0, 1
    mov     eax, eax
    mov     [udp+rax*8], r10
    shr     b0, 1
    mov     [bdp+rax*8+0], rcx
    mov     r10, [udp]
    add     r11d, 0FFFFFFFFh
    jz      loc_5F9430
    test    r10b, 1
    jnz     loc_5F94D0
loc_5F92BB:
    mov     rax, [bdp+0]
    mov     esi, eax
    and     esi, 1
    neg     rsi
    mov     rdx, [r8]
    mov     rcx, [rdx]
    and     rcx, mask
    xor     rcx, b0
    test    r15d, r15d
    jle     short loc_5F9290
    cmp     r15d, 1
    jnz     short loc_5F92F0
    xor     eax, eax
    jmp     loc_5F93F0
loc_5F92F0:
    lea     r14, [rdx+8]
    mov     rax, [rbp+ret]
    lea     rax, [rdx+rax*8]
    cmp     udp, rax
    setb    r8b
    cmp     r14, [rbp+ubits]
    setb    r9b
    and     r9b, r8b
    or      r9b, [rbp+var_2D]
    cmp     bdp, rax
    setb    r8b
    cmp     r14, [rbp+var_80]
    setb    r14b
    test    r9b, r9b
    jnz     loc_5F93E2
    and     r8b, r14b
    jnz     loc_5F93E2
    movq    xmm0, mask
    pshufd  xmm0, xmm0, 44h ; 'D'
    movq    xmm1, b0
    pshufd  xmm2, xmm1, 44h ; 'D'
    movq    xmm1, u0
    pshufd  xmm1, xmm1, 44h ; 'D'
    xor     eax, eax
    mov     r8, [rbp+p]
    mov     b0, [rbp+var_B8]
    xchg    ax, ax
loc_5F9360:
    movdqa  xmm3, xmm1
    movdqa  xmm4, xmm2
    movups  xmm1, xmmword ptr [udp+rax*8+8]
    shufps  xmm3, xmm1, 4Eh ; 'N'
    psrlq   xmm3, 1
    movaps  xmm2, xmm1
    psllq   xmm2, 3Fh ; '?'
    por     xmm2, xmm3
    movdqu  xmmword ptr [udp+rax*8], xmm2
    movdqu  xmm3, xmmword ptr [bdp+rax*8+8]
    movdqu  xmm2, xmmword ptr [rdx+rax*8+8]
    pand    xmm2, xmm0
    pxor    xmm2, xmm3
    shufps  xmm4, xmm2, 4Eh ; 'N'
    psrlq   xmm4, 1
    movdqa  xmm3, xmm2
    psllq   xmm3, 3Fh ; '?'
    por     xmm3, xmm4
    movdqu  xmmword ptr [bdp+rax*8+0], xmm3
    add     rax, 2
    cmp     rcx, rax
    jnz     short loc_5F9360
    pshufd  xmm0, xmm2, 4Eh ; 'N'
    mov     rax, rcx
    movq    rcx, xmm0
    pshufd  xmm0, xmm1, 4Eh ; 'N'
    movq    u0, xmm0
    cmp     rax, r15
    jnz     short loc_5F93F0
    jmp     short loc_5F9424
loc_5F93E2:
    xor     eax, eax
    mov     r8, [rbp+p]
    nop     dword ptr [rax+rax+00000000h]
loc_5F93F0:
    mov     rdi, r10
    mov     r10, [udp+rax*8+8]
    shrd    rdi, u1, 1
    mov     rbx, rcx
    mov     [udp+i*8], u0
    mov     rcx, [rdx+i*8+8]
    and     rcx, mask
    xor     rcx, [bdp+i*8+8]
    shrd    rbx, b1, 1
    mov     [bdp+i*8+0], rbx
    add     i, 1
    cmp     r15, rax
    jnz     short loc_5F93F0
loc_5F9424:
    mov     eax, r15d
    jmp     loc_5F9292
loc_5F9430:
    xor     r11d, r11d
loc_5F9433:
    cmp     r10, 1
    mov     rbx, [rbp+var_38]
    mov     rdi, [rbp+cdp]
    mov     rsi, [rbp+var_50]
    jz      loc_5F9706
loc_5F9449:
    mov     r9d, [rbp+vbits]
    cmp     r11d, r9d
    jge     short loc_5F94A0
    mov     rcx, [rbp+tmp]
    mov     rax, [rcx]
    mov     bdp, rdi
    mov     rdx, [rbp+b]
    mov     rdi, [rdx]
    mov     r14d, r9d
    mov     r9d, r11d
    mov     udp, rsi
    mov     [rbp+vdp], vdp_0
    mov     rsi, rax
    mov     rax, [rbp+v]
    mov     [rbp+tmp], rax
    mov     rax, rdx
    mov     rdx, [rbp+c]
    mov     [rbp+b], rdx
    mov     [rbp+c], rax
    mov     [rbp+v], rcx
    jmp     short loc_5F94A3
loc_5F94A0:
    mov     r14d, r11d
loc_5F94A3:
    test    ebx, ebx
    mov     [rbp+cdp], cdp_0
    mov     [rbp+var_50], vdp_0
    mov     [rbp+vbits], r9d
    jle     loc_5F968E
    cmp     ebx, 4
    jnb     short loc_5F94F0
    xor     eax, eax
    jmp     loc_5F9630
loc_5F94D0:
    cmp     r11d, 40h ; '@'
    jle     loc_5F9433
    mov     rbx, [rbp+var_38]
    mov     rdi, [rbp+cdp]
    mov     rsi, [rbp+var_50]
    jmp     loc_5F9449
loc_5F94F0:
    mov     [rbp+ubits], ubits_0
    lea     rcx, [udp+rbx*8]
    lea     r10, ds:0[rbx*8]
    add     r10, bdp
    lea     rsi, [rsi+rbx*8]
    lea     rbx, [rdi+rbx*8]
    cmp     udp, r10
    setb    byte ptr [rbp+var_80]
    cmp     bdp, rcx
    setb    r14b
    cmp     udp, rsi
    setb    al
    mov     vbits_0, [rbp+vdp]
    cmp     r9, rcx
    setb    r8b
    cmp     udp, rbx
    setb    dl
    cmp     rdi, rcx
    setb    r11b
    cmp     bdp, rsi
    setb    cl
    cmp     r9, r10
    setb    r9b
    cmp     bdp, rbx
    setb    bl
    cmp     rdi, r10
    setb    dil
    test    byte ptr [rbp+var_80], r14b
    jnz     loc_5F96DC
    and     al, r8b
    mov     rsi, [rbp+var_50]
    mov     r14, [rbp+ubits]
    jnz     loc_5F96FB
    and     dl, r11b
    mov     r8, [rbp+p]
    jnz     loc_5F9617
    and     cl, r9b
    jnz     loc_5F9617
    mov     eax, 0
    and     bl, dil
    mov     r9d, [rbp+vbits]
    mov     rbx, [rbp+var_38]
    mov     rdi, [rbp+cdp]
    jnz     loc_5F9630
    xor     eax, eax
    mov     rcx, [rbp+var_A0]
    nop     dword ptr [rax+rax+00000000h]
loc_5F95B0:
    movups  xmm0, xmmword ptr [rsi+rax*8]
    movups  xmm1, xmmword ptr [rsi+rax*8+10h]
    movups  xmm2, xmmword ptr [udp+rax*8]
    xorps   xmm2, xmm0
    movups  xmm0, xmmword ptr [udp+rax*8+10h]
    xorps   xmm0, xmm1
    movups  xmmword ptr [udp+rax*8], xmm2
    movups  xmmword ptr [udp+rax*8+10h], xmm0
    movdqu  xmm0, xmmword ptr [rdi+rax*8]
    movdqu  xmm1, xmmword ptr [rdi+rax*8+10h]
    movdqu  xmm2, xmmword ptr [bdp+rax*8+0]
    pxor    xmm2, xmm0
    movdqu  xmm0, xmmword ptr [bdp+rax*8+10h]
    pxor    xmm0, xmm1
    movdqu  xmmword ptr [bdp+rax*8+0], xmm2
    movdqu  xmmword ptr [bdp+rax*8+10h], xmm0
    add     rax, 4
    cmp     rcx, rax
    jnz     short loc_5F95B0
    mov     rax, rcx
    cmp     rcx, rbx
    jnz     short loc_5F9630
    jmp     short loc_5F968E
loc_5F9617:
    xor     eax, eax
loc_5F9619:
    mov     r9d, [rbp+vbits]
    mov     rbx, [rbp+var_38]
    mov     rdi, [rbp+cdp]
    nop     word ptr [i+i+00000000h]
    nop
loc_5F9630:
    mov     rcx, i
    not     rcx
    test    bl, 1
    jz      short loc_5F9650
    mov     rdx, [rsi+i*8]
    xor     [udp+i*8], rdx
    mov     rdx, [rdi+i*8]
    xor     [bdp+i*8+0], rdx
    or      i, 1
loc_5F9650:
    cmp     rcx, [rbp+var_A8]
    jz      short loc_5F968E
    nop     dword ptr [i+00000000h]
loc_5F9660:
    mov     rcx, [rsi+i*8]
    xor     [udp+i*8], rcx
    mov     rcx, [rdi+i*8]
    xor     [bdp+i*8+0], rcx
    mov     rcx, [rsi+rax*8+8]
    xor     [udp+rax*8+8], rcx
    mov     rcx, [rdi+rax*8+8]
    xor     [bdp+rax*8+8], rcx
    add     rax, 2
    cmp     rbx, rax
    jnz     short loc_5F9660
loc_5F968E:
    cmp     r14d, r9d
    jnz     loc_5F923F
    mov     eax, r14d
    add     eax, 0FFFFFFFFh
    sar     eax, 1Fh
    shr     eax, 1Ah
    lea     r14d, [r14+rax]
    add     r14d, 0FFFFFFFFh
    mov     eax, r14d
    sar     eax, 6
    cdqe
    and     r14d, 0FFFFFFC0h
    xor     r14d, 0FFFFFFC0h
    nop     dword ptr [utop+utop+00h]
loc_5F96C0:
    mov     rdi, [udp+utop*8]; l
    add     r14d, 40h ; '@'
    add     rax, 0FFFFFFFFFFFFFFFFh
    jnb     loc_5F9230
    test    ul, ul
    jz      short loc_5F96C0
    jmp     loc_5F9230
loc_5F96DC:
    xor     eax, eax
    mov     r8, [rbp+p]
    mov     r9d, [rbp+vbits]
    mov     rbx, [rbp+var_38]
    mov     rdi, [rbp+cdp]
    mov     rsi, [rbp+var_50]
    mov     r14, [rbp+ubits]
    jmp     loc_5F9630
loc_5F96FB:
    xor     eax, eax
    mov     r8, [rbp+p]
    jmp     loc_5F9619
loc_5F9706:
    mov     rbx, [rbp+b]
    mov     rdi, rbx; a
    call    bn_correct_top
    mov     rdi, [rbp+r]; a
    mov     rsi, rbx; b
    call    BN_copy
    xor     ecx, ecx
    test    rax, rax
    setnz   cl
    mov     dword ptr [rbp+ret], ecx
    mov     r14, [rbp+ctx]
    jmp     err
BN_GF2m_mod_inv_vartime endp

