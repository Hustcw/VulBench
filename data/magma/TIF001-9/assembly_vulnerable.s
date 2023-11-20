fpDiff proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r14, cc
    mov     r15, cp0
    mov     rax, [tif+3F0h]
    mov     r13, [rax+8]
    movzx   ebx, word ptr [tif+74h]
    shr     rbx, 3
    mov     rax, rdx
    cqo
    idiv    rbx
    mov     r12, rax
    mov     tif, cc; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_439AD0
    mov     rbp, rax
    mov     rdi, rax; d
    mov     rsi, cp0; s
    mov     rdx, cc; c
    call    _TIFFmemcpy
    test    wc, wc
    jle     loc_43991F
    movzx   r10d, bx
    mov     r9d, r10d
    and     r9d, 1
    mov     rdx, tmp
    add     rdx, 1
    lea     eax, [bps-2]
    mov     [rsp+38h+var_34], eax
    mov     r11, r10
    sub     r11, r9
    xor     edi, edi
    test    bx, bx
    jnz     short loc_439895
loc_439880:
    add     count, 1
    add     rdx, r10
    cmp     count, wc
    jz      loc_43991F
    test    bx, bx
    jz      short loc_439880
loc_439895:
    cmp     bx, 1
    jnz     short loc_4398B0
    xor     ecx, ecx
    xor     eax, eax
    test    r9, r9
    jz      short loc_439880
    jmp     short loc_4398FD
loc_4398B0:
    mov     r8, tmp
    mov     rsi, bps
    mov     eax, [rsp+38h+var_34]
    xor     ecx, ecx
    nop     dword ptr [rax+00h]
loc_4398C0:
    movzx   ebx, byte ptr [rdx+byte-1]
    lea     ebp, [rax+1]
    imul    rbp, wc
    add     rbp, count
    mov     [cp0+rbp], bl
    movzx   ebx, byte ptr [rdx+rcx]
    mov     ebp, eax
    imul    rbp, wc
    add     rbp, count
    mov     [cp0+rbp], bl
    add     rcx, 2
    add     eax, 0FFFFFFFEh
    cmp     r11, rcx
    jnz     short loc_4398C0
    mov     eax, ecx
    mov     rbx, rsi
    mov     rbp, r8
    test    r9, r9
    jz      short loc_439880
loc_4398FD:
    mov     rsi, count
    imul    rsi, rbx
    add     rsi, rcx
    mov     cl, [rbp+rsi+0]
    not     eax
    add     eax, ebx
    imul    rax, wc
    add     rax, count
    mov     [cp0+rax], cl
    jmp     loc_439880
loc_43991F:
    mov     rdi, tmp; p
    call    _TIFFfree
    mov     eax, 1
    cmp     stride, count
    jge     loc_439AD2
    mov     rcx, stride
    not     rcx
    add     rcx, count
    add     cp0, rcx
    lea     rcx, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     r10, [r11+1]
    mov     rdi, i
    and     rdi, 0FFFFFFFFFFFFFFF0h
    mov     r8, i
    sub     r8, rdi
    mov     r9, rdi
    neg     r9
    mov     r12d, r10d
    and     r12d, 1
    sub     r10, r12
    cmp     stride, 4
    jbe     short loc_4399BE
    jmp     short def_4399BE; jumptable 00000000004399BE default case
loc_439980:
    mov     dl, [cp]; jumptable 00000000004399BE case 4
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 3
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 2
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 1
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    sub     count, stride; jumptable 00000000004399BE case 0
    cmp     count, stride
    jle     loc_439AD2
    cmp     stride, 4; switch 5 cases
    ja      short def_4399BE; jumptable 00000000004399BE default case
def_4399BE:
    jmp     ds:jpt_4399BE[stride*8]; switch jump
    test    i, i; jumptable 00000000004399BE default case
    jle     short loc_439980; jumptable 00000000004399BE case 4
    cmp     i, 10h
    jnb     short loc_4399D9
    mov     rdx, i
    jmp     loc_439AB0
loc_4399D9:
    test    r11, r11
    jz      loc_439AC7
    lea     rbx, [cp-7]
    lea     rdx, [cp+stride]
    add     rdx, 0FFFFFFFFFFFFFFF9h
    xor     ebp, ebp
    mov     rsi, r10
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax]
loc_439A00:
    movq    xmm0, qword ptr [rdx+rbp]
    movq    xmm1, qword ptr [rdx+rbp-8]
    movq    xmm2, qword ptr [rbx+rbp]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rbx+rbp-8]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rbp], xmm0
    movq    qword ptr [rdx+rbp-8], xmm1
    movq    xmm0, qword ptr [rdx+rbp-10h]
    movq    xmm1, qword ptr [rdx+rbp-18h]
    movq    xmm2, qword ptr [rbx+rbp-10h]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rbx+rbp-18h]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rbp-10h], xmm0
    movq    qword ptr [rdx+rbp-18h], xmm1
    add     rbp, 0FFFFFFFFFFFFFFE0h
    add     rsi, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_439A00
    neg     rbp
    test    r12, r12
    jz      short loc_439A9B
loc_439A67:
    mov     rdx, cp
    sub     rdx, rbp
    movq    xmm0, qword ptr [rdx+stride-7]
    movq    xmm1, qword ptr [rdx+stride-0Fh]
    movq    xmm2, qword ptr [rdx-7]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdx-0Fh]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+stride-7], xmm0
    movq    qword ptr [rdx+stride-0Fh], xmm1
loc_439A9B:
    add     cp, r9
    mov     rdx, r8
    cmp     i, rdi
    jz      loc_439980; jumptable 00000000004399BE case 4
    nop     word ptr [rax+rax+00h]
loc_439AB0:
    movzx   ebx, byte ptr [cp]
    sub     [cp+stride], bl
    add     cp, 0FFFFFFFFFFFFFFFFh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439AB0
    jmp     loc_439980; jumptable 00000000004399BE case 4
loc_439AC7:
    xor     ebp, ebp
    test    r12, r12
    jnz     short loc_439A67
    jmp     short loc_439A9B
loc_439AD0:
    xor     eax, eax
loc_439AD2:
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     stride
    pop     r14
    pop     r15
    pop     rbp
    retn
fpDiff endp

