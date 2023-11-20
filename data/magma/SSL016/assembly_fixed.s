BN_GF2m_mod_inv_vartime proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 98h
    mov     rbx, ctx
    mov     r13, p_0
    mov     r12, a
    mov     [rbp+r], r_0
    mov     rdi, rcx; ctx
    call    BN_CTX_start
    mov     rdi, ctx; ctx
    call    BN_CTX_get
    mov     [rbp+b], rax
    mov     rdi, ctx; ctx
    call    BN_CTX_get
    mov     [rbp+c], rax
    mov     rdi, ctx; ctx
    call    BN_CTX_get
    mov     r14, rax
    mov     rdi, ctx; ctx
    call    BN_CTX_get
    xor     r15d, r15d
    test    v_0, v_0
    mov     [rbp+var_C0], ctx
    jz      short err
    mov     [rbp+v], v_0
    mov     rdi, u_0; r
    mov     rsi, a; a
    mov     [rbp+p], p_0
    mov     rdx, r13; p
    call    BN_GF2m_mod
    test    eax, eax
    jz      short err
    mov     rdi, u_0; a
    call    BN_is_zero
    test    eax, eax
    jz      short loc_650B8D
    mov     rdi, [rbp+var_C0]; ctx
    call    BN_CTX_end
    mov     eax, r15d
    add     rsp, 98h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     ret
    pop     rbp
    retn
loc_650B8D:
    mov     ctx, [rbp+v]
    mov     rdi, rbx; a
    mov     a, [rbp+p]
    mov     rsi, r12; b
    call    BN_copy
    test    rax, rax
    jz      short err
    mov     rdi, u_0; a
    call    BN_num_bits
    mov     qword ptr [rbp+ubits], rax
    mov     rdi, rbx; a
    call    BN_num_bits
    mov     [rbp+vbits], eax
    mov     ebx, [r12+8]
    mov     rdi, u_0; a
    mov     esi, ebx; words
    call    bn_wexpand
    test    rax, rax
    jz      short err
    mov     rax, u_0
    mov     u_0, [u_0]
    mov     [rbp+tmp], rax
    movsxd  rax, dword ptr [rax+8]
    cmp     eax, ebx
    mov     rsi, top
    mov     qword ptr [rbp+words], top
    jge     short loc_650C04
    lea     rdi, [udp+i*8]; s
    not     eax
    add     eax, esi
    lea     rdx, ds:8[rax*8]; n
    xor     esi, esi; c
    call    _memset
    mov     rsi, qword ptr [rbp+words]; words
loc_650C04:
    mov     rax, [rbp+tmp]
    mov     [rax+8], esi
    mov     top, [rbp+b]
    mov     rdi, rbx; a
    mov     r12, rsi
    call    bn_wexpand
    test    rax, rax
    jz      err
    mov     r13, [rbx]
    mov     qword ptr [bdp+0], 1
    cmp     r12d, 2
    mov     rsi, r12
    jl      short loc_650C4D
    lea     rdi, [bdp+8]; s
    lea     edx, [rsi-1]
    shl     rdx, 3; n
    xor     esi, esi; c
    call    _memset
    mov     rsi, qword ptr [rbp+words]; words
loc_650C4D:
    mov     [rbx+8], esi
    mov     rbx, [rbp+c]
    mov     rdi, rbx; a
    mov     r12, rsi
    call    bn_wexpand
    test    rax, rax
    jz      err
    mov     r15, [rbx]
    test    r12d, r12d
    mov     rcx, r12
    jle     short loc_650C89
    lea     rdx, ds:0[rcx*8]; n
    mov     rdi, cdp_0; s
    xor     esi, esi; c
    call    _memset
    mov     rcx, qword ptr [rbp+words]
loc_650C89:
    mov     [rbp+cdp], cdp_0
    mov     [rbx+8], ecx
    mov     rax, [rbp+v]
    mov     rax, [rax]
    lea     r15d, [rcx-1]
    lea     rdx, [r15+1]
    mov     [rbp+var_98], rdx
    mov     edx, r15d
    and     edx, 0FFFFFFFEh
    mov     [rbp+var_B8], rdx
    mov     edx, ecx
    and     edx, 0FFFFFFFCh
    mov     [rbp+var_A0], rdx
    neg     rcx
    mov     [rbp+var_A8], rcx
    mov     [rbp+vdp], vdp_0
    mov     [rbp+var_58], rax
    mov     r8, [rbp+p]
    mov     rax, qword ptr [rbp+ubits]
    jmp     short loc_650CEB
loc_650CE0:
    call    BN_num_bits_word
    sub     eax, ebx
    mov     r8, [rbp+p]
loc_650CEB:
    mov     r10, [udp]
    test    eax, eax
    jz      loc_650EE0
    mov     rcx, [rbp+var_98]
    lea     rdx, [udp+rcx*8]
    lea     rcx, ds:0[rcx*8]
    add     rcx, bdp
    mov     [rbp+var_88], rcx
    cmp     udp, rcx
    setb    cl
    mov     qword ptr [rbp+ubits], rdx
    cmp     bdp, rdx
    setb    dl
    and     dl, cl
    mov     [rbp+var_29], dl
    mov     r11d, eax
    test    r10b, 1
    jz      short loc_650D6A
    jmp     loc_650EF0
loc_650D40:
    xor     ecx, ecx
loc_650D42:
    shr     u0, 1
    mov     ecx, ecx
    mov     [udp+rcx*8], r10
    shr     b0, 1
    mov     [bdp+rcx*8+0], rdi
    mov     r10, [udp]
    add     r11d, 0FFFFFFFFh
    jz      loc_650F00
    test    r10b, 1
    jnz     loc_650EF0
loc_650D6A:
    mov     rbx, [bdp+0]
    mov     edx, ebx
    and     edx, 1
    neg     rdx
    mov     rcx, [r8]
    mov     rdi, [rcx]
    and     rdi, mask
    xor     rdi, b0
    xor     eax, eax
    test    r15d, r15d
    jle     short loc_650D40
    cmp     r15d, 1
    jnz     short loc_650DA0
    xor     r12d, r12d
    jmp     loc_650EA0
loc_650DA0:
    lea     r12, [rcx+8]
    mov     rsi, [rbp+var_98]
    lea     rbx, [rcx+rsi*8]
    cmp     udp, rbx
    setb    r8b
    cmp     r12, qword ptr [rbp+ubits]
    setb    r9b
    and     r9b, r8b
    or      r9b, [rbp+var_29]
    cmp     bdp, rbx
    setb    r8b
    cmp     r12, [rbp+var_88]
    setb    r12b
    test    r9b, r9b
    jnz     loc_650E96
    and     r8b, r12b
    jnz     loc_650E96
    movq    xmm0, mask
    pshufd  xmm0, xmm0, 44h ; 'D'
    movq    xmm1, b0
    pshufd  xmm2, xmm1, 44h ; 'D'
    movq    xmm1, u0
    pshufd  xmm1, xmm1, 44h ; 'D'
    xor     esi, esi
    mov     rbx, [rbp+var_B8]
loc_650E10:
    movdqa  xmm3, xmm1
    movdqa  xmm4, xmm2
    movups  xmm1, xmmword ptr [udp+rsi*8+8]
    shufps  xmm3, xmm1, 4Eh ; 'N'
    psrlq   xmm3, 1
    movaps  xmm2, xmm1
    psllq   xmm2, 3Fh ; '?'
    por     xmm2, xmm3
    movdqu  xmmword ptr [udp+rsi*8], xmm2
    movdqu  xmm3, xmmword ptr [bdp+rsi*8+8]
    movdqu  xmm2, xmmword ptr [rcx+rsi*8+8]
    pand    xmm2, xmm0
    pxor    xmm2, xmm3
    shufps  xmm4, xmm2, 4Eh ; 'N'
    psrlq   xmm4, 1
    movdqa  xmm3, xmm2
    psllq   xmm3, 3Fh ; '?'
    por     xmm3, xmm4
    movdqu  xmmword ptr [bdp+rsi*8+0], xmm3
    add     rsi, 2
    cmp     rbx, rsi
    jnz     short loc_650E10
    pshufd  xmm0, xmm2, 4Eh ; 'N'
    movq    b0, xmm0
    pshufd  xmm0, xmm1, 4Eh ; 'N'
    movq    u0, xmm0
    cmp     rbx, r15
    mov     r8, [rbp+p]
    jz      short loc_650ED4
    mov     r12, rbx
    jmp     short loc_650EA0
loc_650E96:
    xor     r12d, r12d
    mov     r8, [rbp+p]
    nop     dword ptr [rax]
loc_650EA0:
    mov     rsi, r10
    mov     r10, [udp+r12*8+8]
    shrd    rsi, u1, 1
    mov     rbx, rdi
    mov     [udp+i*8], u0
    mov     rdi, [rcx+i*8+8]
    and     rdi, mask
    xor     rdi, [bdp+i*8+8]
    shrd    rbx, b1, 1
    mov     [bdp+i*8+0], rbx
    add     i, 1
    cmp     r15, r12
    jnz     short loc_650EA0
loc_650ED4:
    mov     ecx, r15d
    jmp     loc_650D42
loc_650EE0:
    xor     eax, eax
    test    r10, r10
    jnz     short loc_650F09
    jmp     loc_6511B9
loc_650EF0:
    mov     eax, r11d
    cmp     r11d, 40h ; '@'
    jg      short loc_650F16
    nop     dword ptr [rax+00000000h]
loc_650F00:
    test    r10, r10
    jz      loc_6511B9
loc_650F09:
    mov     r11d, eax
    cmp     r10, 1
    jz      loc_6511C1
loc_650F16:
    mov     r10d, [rbp+vbits]
    cmp     r11d, r10d
    jge     short loc_650F70
    mov     rsi, [rbp+tmp]
    mov     rbx, [rsi]
    mov     bdp, [rbp+cdp]
    mov     rdx, [rbp+b]
    mov     rcx, [rdx]
    mov     eax, r10d
    mov     r10d, r11d
    mov     rdi, rsi
    mov     udp, [rbp+var_58]
    mov     [rbp+vdp], vdp_0
    mov     rsi, cdp_0
    mov     rcx, [rbp+v]
    mov     [rbp+tmp], rcx
    mov     rcx, rdx
    mov     rdx, [rbp+c]
    mov     [rbp+b], rdx
    mov     [rbp+c], rcx
    mov     [rbp+v], rdi
    mov     i, qword ptr [rbp+words]
    jmp     short loc_650F7F
loc_650F70:
    mov     eax, r11d
    mov     i, qword ptr [rbp+words]
    mov     rsi, [rbp+cdp]
    mov     rbx, [rbp+var_58]
loc_650F7F:
    test    r11d, r11d
    mov     [rbp+cdp], cdp_0
    mov     [rbp+var_58], vdp_0
    mov     [rbp+vbits], r10d
    jle     loc_651140
    cmp     r11d, 4
    jnb     short loc_651010
    xor     edi, edi
loc_650F9C:
    mov     rcx, i
    not     rcx
    test    r11b, 1
    jz      short loc_650FBD
    mov     rdx, [rbx+i*8]
    xor     [udp+i*8], rdx
    mov     rdx, [rsi+i*8]
    xor     [bdp+i*8+0], rdx
    or      i, 1
loc_650FBD:
    cmp     rcx, [rbp+var_A8]
    jz      loc_651140
    nop     word ptr [rax+rax+00h]
loc_650FD0:
    mov     rcx, [rbx+i*8]
    xor     [udp+i*8], rcx
    mov     rcx, [rsi+i*8]
    xor     [bdp+i*8+0], rcx
    mov     rcx, [rbx+rdi*8+8]
    xor     [udp+rdi*8+8], rcx
    mov     rcx, [rsi+rdi*8+8]
    xor     [bdp+rdi*8+8], rcx
    add     rdi, 2
    cmp     r11, rdi
    jnz     short loc_650FD0
    jmp     loc_651140
loc_651010:
    mov     qword ptr [rbp+ubits], ubits_0
    lea     rcx, [udp+r11*8]
    lea     r8, ds:0[r11*8]
    add     r8, bdp
    lea     rdx, [rbx+r11*8]
    lea     rdi, [rsi+r11*8]
    cmp     udp, r8
    setb    byte ptr [rbp+var_88]
    cmp     bdp, rcx
    setb    r12b
    cmp     udp, rdx
    setb    al
    mov     r11, [rbp+vdp]
    cmp     r11, rcx
    setb    r10b
    cmp     udp, rdi
    setb    bl
    cmp     rsi, rcx
    setb    [rbp+var_29]
    cmp     bdp, rdx
    setb    r9b
    cmp     r11, r8
    setb    dl
    cmp     bdp, rdi
    setb    cl
    cmp     rsi, r8
    setb    r8b
    test    byte ptr [rbp+var_88], r12b
    jnz     loc_65119A
    and     al, r10b
    jnz     loc_65119A
    and     bl, [rbp+var_29]
    mov     r10d, [rbp+vbits]
    mov     r11, qword ptr [rbp+words]
    mov     rsi, [rbp+cdp]
    mov     rbx, [rbp+var_58]
    jnz     loc_65118B
    and     r9b, dl
    jnz     loc_65118B
    mov     edi, 0
    and     cl, r8b
    mov     r8, [rbp+p]
    mov     rax, qword ptr [rbp+ubits]
    jnz     loc_650F9C
    xor     edx, edx
    mov     rcx, [rbp+var_A0]
    xchg    ax, ax
loc_6510D0:
    movups  xmm0, xmmword ptr [rbx+rdx*8]
    movups  xmm1, xmmword ptr [rbx+rdx*8+10h]
    movups  xmm2, xmmword ptr [udp+rdx*8]
    xorps   xmm2, xmm0
    movups  xmm0, xmmword ptr [udp+rdx*8+10h]
    xorps   xmm0, xmm1
    movups  xmmword ptr [udp+rdx*8], xmm2
    movups  xmmword ptr [udp+rdx*8+10h], xmm0
    movdqu  xmm0, xmmword ptr [rsi+rdx*8]
    movdqu  xmm1, xmmword ptr [rsi+rdx*8+10h]
    movdqu  xmm2, xmmword ptr [bdp+rdx*8+0]
    pxor    xmm2, xmm0
    movdqu  xmm0, xmmword ptr [bdp+rdx*8+10h]
    pxor    xmm0, xmm1
    movdqu  xmmword ptr [bdp+rdx*8+0], xmm2
    movdqu  xmmword ptr [bdp+rdx*8+10h], xmm0
    add     rdx, 4
    cmp     rcx, rdx
    jnz     short loc_6510D0
    mov     rdi, rcx
    cmp     rcx, r11
    jnz     loc_650F9C
    nop     dword ptr [rax+00000000h]
loc_651140:
    cmp     eax, r10d
    jnz     loc_650CEB
    mov     ecx, eax
    add     ecx, 0FFFFFFFFh
    sar     ecx, 1Fh
    shr     ecx, 1Ah
    lea     ebx, [rax+rcx]
    add     ebx, 0FFFFFFFFh
    mov     eax, ebx
    sar     eax, 6
    cdqe
    and     ebx, 0FFFFFFC0h
    xor     ebx, 0FFFFFFC0h
    nop     word ptr [utop+utop+00000000h]
loc_651170:
    mov     rdi, [udp+utop*8]; l
    add     ebx, 40h ; '@'
    add     rax, 0FFFFFFFFFFFFFFFFh
    jnb     loc_650CE0
    test    ul, ul
    jz      short loc_651170
    jmp     loc_650CE0
loc_65118B:
    xor     edi, edi
    mov     r8, [rbp+p]
    mov     rax, qword ptr [rbp+ubits]
    jmp     loc_650F9C
loc_65119A:
    xor     edi, edi
    mov     r8, [rbp+p]
    mov     r10d, [rbp+vbits]
    mov     r11, qword ptr [rbp+words]
    mov     rsi, [rbp+cdp]
    mov     rbx, [rbp+var_58]
    mov     rax, qword ptr [rbp+ubits]
    jmp     loc_650F9C
loc_6511B9:
    xor     r15d, r15d
    jmp     err
loc_6511C1:
    mov     rbx, [rbp+b]
    mov     rdi, rbx; a
    call    bn_correct_top
    mov     rdi, [rbp+r]; a
    mov     rsi, rbx; b
    call    BN_copy
    xor     r15d, r15d
    test    rax, rax
    setnz   r15b
    jmp     err
BN_GF2m_mod_inv_vartime endp

