horDiff16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     sp_0, [sp_0+8]
    mov     rcx, cc
    shr     rcx, 3Fh
    add     rcx, cc
    sar     rcx, 1
    sub     wc, stride
    jle     loc_4393BF
    lea     cc, [wp+wc*2]
    add     rdx, 0FFFFFFFFFFFFFFFEh
    lea     r13, [stride-4]
    lea     r9, [stride-14h]
    shr     r9, 4
    lea     r8, [r9+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r12
    mov     r11, r12
    neg     r11
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride+stride]
    cmp     stride, 4
    jbe     short loc_4392BB
    jmp     short def_4392BB; jumptable 00000000004392BB default case
loc_439280:
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 4
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 3
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 2
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 1
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    sub     wc, stride; jumptable 00000000004392BB case 0
    jle     loc_4393BF
    cmp     stride, 4; switch 5 cases
    ja      short def_4392BB; jumptable 00000000004392BB default case
def_4392BB:
    jmp     ds:jpt_4392BB[stride*8]; switch jump
    test    i, i; jumptable 00000000004392BB default case
    jle     short loc_439280; jumptable 00000000004392BB case 4
    cmp     i, 10h
    jnb     short loc_4392D5
    mov     cp0, i
    jmp     loc_4393A0
loc_4392D5:
    test    r9, r9
    jz      loc_4393B6
    lea     tif, [wp-0Eh]
    lea     cp0, [wp+r14]
    add     rsi, 0FFFFFFFFFFFFFFF2h
    xor     ebx, ebx
    mov     rbp, r8
    nop
loc_4392F0:
    movdqu  xmm0, xmmword ptr [rsi+rbx*2-30h]
    movdqu  xmm1, xmmword ptr [rsi+rbx*2-20h]
    movdqu  xmm2, xmmword ptr [rsi+rbx*2-10h]
    movdqu  xmm3, xmmword ptr [rsi+rbx*2]
    movdqu  xmm4, xmmword ptr [rdi+rbx*2-10h]
    psubw   xmm2, xmm4
    movdqu  xmm4, xmmword ptr [rdi+rbx*2]
    psubw   xmm3, xmm4
    movdqu  xmmword ptr [rsi+rbx*2], xmm3
    movdqu  xmmword ptr [rsi+rbx*2-10h], xmm2
    movdqu  xmm2, xmmword ptr [rdi+rbx*2-30h]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi+rbx*2-20h]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rsi+rbx*2-20h], xmm1
    movdqu  xmmword ptr [rsi+rbx*2-30h], xmm0
    add     rbx, 0FFFFFFFFFFFFFFE0h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4392F0
    neg     rbx
    test    r15, r15
    jz      short loc_43938A
loc_439357:
    add     rbx, rbx
    mov     rsi, wp
    sub     rsi, rbx
    movdqu  xmm0, xmmword ptr [rsi+stride*2-1Eh]
    movdqu  xmm1, xmmword ptr [rsi+stride*2-0Eh]
    movdqu  xmm2, xmmword ptr [rsi-1Eh]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rsi-0Eh]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rsi+stride*2-0Eh], xmm1
    movdqu  xmmword ptr [rsi+stride*2-1Eh], xmm0
loc_43938A:
    lea     wp, [wp+r11*2]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439280; jumptable 00000000004392BB case 4
    nop     word ptr [stride+stride+00h]
loc_4393A0:
    movzx   edi, word ptr [wp]
    sub     [wp+stride*2], di
    add     wp, 0FFFFFFFFFFFFFFFEh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_4393A0
    jmp     loc_439280; jumptable 00000000004392BB case 4
loc_4393B6:
    xor     ebx, ebx
    test    r15, r15
    jnz     short loc_439357
    jmp     short loc_43938A
loc_4393BF:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff16 endp

