horDiff16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [sp_0+8]
    lea     r13, [stride+stride]
    mov     sp_0, rdx
    cqo
    idiv    r13
    test    rdx, rdx
    jz      short loc_4395EF
    mov     tif, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aHordiff8; "horDiff8"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset asc_4696AB; "("
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43978F
loc_4395EF:
    mov     rax, cc
    shr     rax, 3Fh
    add     rax, cc
    sar     rax, 1
    mov     r14d, 1
    sub     wc, stride
    jle     loc_43978F
    lea     cc, [cp0+wc*2]
    add     rcx, 0FFFFFFFFFFFFFFFEh
    lea     rdx, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     cp0, [r11+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r12
    mov     r9, r12
    neg     r9
    mov     r15d, esi
    and     r15d, 1
    sub     rsi, r15
    mov     [rsp+38h+var_38], rsi
    cmp     stride, 4
    jbe     short loc_43968B
    jmp     short def_43968B; jumptable 000000000043968B default case
loc_439650:
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 4
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 3
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 2
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 1
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    sub     wc, stride; jumptable 000000000043968B case 0
    jle     loc_43978F
    cmp     stride, 4; switch 5 cases
    ja      short def_43968B; jumptable 000000000043968B default case
def_43968B:
    jmp     ds:jpt_43968B[stride*8]; switch jump
    test    i, i; jumptable 000000000043968B default case
    jle     short loc_439650; jumptable 000000000043968B case 4
    cmp     i, 10h
    jnb     short loc_4396A5
    mov     rsi, i
    jmp     loc_439770
loc_4396A5:
    test    r11, r11
    jz      loc_439786
    lea     tif, [wp-0Eh]
    lea     rbp, [wp+r13]
    add     rbp, 0FFFFFFFFFFFFFFF2h
    xor     esi, esi
    mov     r8, [rsp+38h+var_38]
loc_4396C0:
    movdqu  xmm0, xmmword ptr [rbp+rsi*2-30h]
    movdqu  xmm1, xmmword ptr [rbp+rsi*2-20h]
    movdqu  xmm2, xmmword ptr [rbp+rsi*2-10h]
    movdqu  xmm3, xmmword ptr [rbp+rsi*2+0]
    movdqu  xmm4, xmmword ptr [rdi+rsi*2-10h]
    psubw   xmm2, xmm4
    movdqu  xmm4, xmmword ptr [rdi+rsi*2]
    psubw   xmm3, xmm4
    movdqu  xmmword ptr [rbp+rsi*2+0], xmm3
    movdqu  xmmword ptr [rbp+rsi*2-10h], xmm2
    movdqu  xmm2, xmmword ptr [rdi+rsi*2-30h]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi+rsi*2-20h]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rbp+rsi*2-20h], xmm1
    movdqu  xmmword ptr [rbp+rsi*2-30h], xmm0
    add     rsi, 0FFFFFFFFFFFFFFE0h
    add     r8, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4396C0
    neg     rsi
    test    r15, r15
    jz      short loc_43975C
loc_439729:
    add     rsi, rsi
    mov     rdi, wp
    sub     rdi, rsi
    movdqu  xmm0, xmmword ptr [rdi+stride*2-1Eh]
    movdqu  xmm1, xmmword ptr [rdi+stride*2-0Eh]
    movdqu  xmm2, xmmword ptr [rdi-1Eh]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi-0Eh]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rdi+stride*2-0Eh], xmm1
    movdqu  xmmword ptr [rdi+stride*2-1Eh], xmm0
loc_43975C:
    lea     wp, [wp+r9*2]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439650; jumptable 000000000043968B case 4
    nop     dword ptr [wc+00h]
loc_439770:
    movzx   edi, word ptr [wp]
    sub     [wp+stride*2], di
    add     wp, 0FFFFFFFFFFFFFFFEh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439770
    jmp     loc_439650; jumptable 000000000043968B case 4
loc_439786:
    xor     esi, esi
    test    r15, r15
    jnz     short loc_439729
    jmp     short loc_43975C
loc_43978F:
    mov     eax, r14d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff16 endp

