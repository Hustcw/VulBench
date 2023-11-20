horDiff32 proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     sp_0, [sp_0+8]
    mov     rcx, cc
    sar     rcx, 3Fh
    shr     rcx, 3Eh
    add     rcx, cc
    sar     rcx, 2
    sub     wc, stride
    jle     loc_43956D
    lea     cc, [wp+wc*4]
    add     rdx, 0FFFFFFFFFFFFFFFCh
    lea     r13, [stride-4]
    lea     r9, [stride-0Ch]
    shr     r9, 3
    lea     r8, [r9+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF8h
    mov     r10, i
    sub     r10, r12
    mov     r11, r12
    neg     r11
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride-3]
    cmp     stride, 4
    jbe     short loc_439473
    jmp     short def_439473; jumptable 0000000000439473 default case
loc_439440:
    mov     esi, [wp]; jumptable 0000000000439473 case 4
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 3
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 2
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 1
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    sub     wc, stride; jumptable 0000000000439473 case 0
    jle     loc_43956D
    cmp     stride, 4; switch 5 cases
    ja      short def_439473; jumptable 0000000000439473 default case
def_439473:
    jmp     ds:jpt_439473[stride*8]; switch jump
    test    i, i; jumptable 0000000000439473 default case
    jle     short loc_439440; jumptable 0000000000439473 case 4
    cmp     i, 8
    jnb     short loc_43948D
    mov     cp0, i
    jmp     loc_439550
loc_43948D:
    test    r9, r9
    jz      loc_439564
    lea     tif, [wp+r14*4]
    xor     ebx, ebx
    mov     cp0, r8
    nop
loc_4394A0:
    movdqu  xmm0, xmmword ptr [wp+rbx*4-1Ch]
    movdqu  xmm1, xmmword ptr [wp+rbx*4-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+rbx*4-30h]
    movdqu  xmm3, xmmword ptr [rdi+rbx*4-20h]
    movdqu  xmm4, xmmword ptr [rdi+rbx*4-10h]
    psubd   xmm4, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbx*4]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+rbx*4], xmm0
    movdqu  xmmword ptr [rdi+rbx*4-10h], xmm4
    movdqu  xmm0, xmmword ptr [wp+rbx*4-3Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rbx*4-2Ch]
    psubd   xmm3, xmm0
    movdqu  xmmword ptr [rdi+rbx*4-20h], xmm3
    movdqu  xmmword ptr [rdi+rbx*4-30h], xmm2
    add     rbx, 0FFFFFFFFFFFFFFF0h
    add     rsi, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4394A0
    neg     rbx
    test    r15, r15
    jz      short loc_43953C
loc_439508:
    shl     rbx, 2
    mov     rsi, wp
    sub     rsi, rbx
    movdqu  xmm0, xmmword ptr [rsi-1Ch]
    movdqu  xmm1, xmmword ptr [rsi-0Ch]
    movdqu  xmm2, xmmword ptr [rsi+stride*4-1Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rsi+stride*4-0Ch]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rsi+stride*4-0Ch], xmm0
    movdqu  xmmword ptr [rsi+stride*4-1Ch], xmm2
loc_43953C:
    lea     wp, [wp+r11*4]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439440; jumptable 0000000000439473 case 4
    nop     dword ptr [stride+00h]
loc_439550:
    mov     edi, [wp]
    sub     [wp+stride*4], edi
    add     wp, 0FFFFFFFFFFFFFFFCh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439550
    jmp     loc_439440; jumptable 0000000000439473 case 4
loc_439564:
    xor     ebx, ebx
    test    r15, r15
    jnz     short loc_439508
    jmp     short loc_43953C
loc_43956D:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
horDiff32 endp

