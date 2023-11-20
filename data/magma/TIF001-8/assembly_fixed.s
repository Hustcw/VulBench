horDiff32 proc
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
    lea     rbp, ds:0[stride*4]
    mov     sp_0, rdx
    cqo
    idiv    rbp
    test    rdx, rdx
    jz      short loc_439803
    mov     tif, [tif+458h]; fd
    xor     r13d, r13d
    mov     esi, offset aHordiff32; "horDiff32"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset asc_4696C8; "("
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43999D
loc_439803:
    mov     rax, cc
    sar     rax, 3Fh
    shr     rax, 3Eh
    add     rax, cc
    sar     rax, 2
    mov     r13d, 1
    sub     wc, stride
    jle     loc_43999D
    lea     cc, [cp0+wc*4]
    add     rcx, 0FFFFFFFFFFFFFFFCh
    lea     rdx, [stride-4]
    lea     r11, [stride-0Ch]
    shr     r11, 3
    lea     r8, [r11+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF8h
    mov     r9, i
    sub     r9, r12
    mov     r10, r12
    neg     r10
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride-3]
    cmp     stride, 4
    jbe     short loc_4398A3
    jmp     short def_4398A3; jumptable 00000000004398A3 default case
loc_439870:
    mov     esi, [wp]; jumptable 00000000004398A3 case 4
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 3
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 2
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 1
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    sub     wc, stride; jumptable 00000000004398A3 case 0
    jle     loc_43999D
    cmp     stride, 4; switch 5 cases
    ja      short def_4398A3; jumptable 00000000004398A3 default case
def_4398A3:
    jmp     ds:jpt_4398A3[stride*8]; switch jump
    test    i, i; jumptable 00000000004398A3 default case
    jle     short loc_439870; jumptable 00000000004398A3 case 4
    cmp     i, 8
    jnb     short loc_4398BD
    mov     cp0, i
    jmp     loc_439980
loc_4398BD:
    test    r11, r11
    jz      loc_439994
    lea     tif, [wp+r14*4]
    xor     esi, esi
    mov     rbp, r8
    nop
loc_4398D0:
    movdqu  xmm0, xmmword ptr [wp+rsi*4-1Ch]
    movdqu  xmm1, xmmword ptr [wp+rsi*4-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+rsi*4-30h]
    movdqu  xmm3, xmmword ptr [rdi+rsi*4-20h]
    movdqu  xmm4, xmmword ptr [rdi+rsi*4-10h]
    psubd   xmm4, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rsi*4]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+rsi*4], xmm0
    movdqu  xmmword ptr [rdi+rsi*4-10h], xmm4
    movdqu  xmm0, xmmword ptr [wp+rsi*4-3Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rsi*4-2Ch]
    psubd   xmm3, xmm0
    movdqu  xmmword ptr [rdi+rsi*4-20h], xmm3
    movdqu  xmmword ptr [rdi+rsi*4-30h], xmm2
    add     rsi, 0FFFFFFFFFFFFFFF0h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4398D0
    neg     rsi
    test    r15, r15
    jz      short loc_43996C
loc_439938:
    shl     rsi, 2
    mov     rdi, wp
    sub     rdi, rsi
    movdqu  xmm0, xmmword ptr [rdi-1Ch]
    movdqu  xmm1, xmmword ptr [rdi-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+stride*4-1Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+stride*4-0Ch]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+stride*4-0Ch], xmm0
    movdqu  xmmword ptr [rdi+stride*4-1Ch], xmm2
loc_43996C:
    lea     wp, [wp+r10*4]
    mov     rsi, r9
    cmp     i, r12
    jz      loc_439870; jumptable 00000000004398A3 case 4
    nop     dword ptr [wc+00h]
loc_439980:
    mov     edi, [wp]
    sub     [wp+stride*4], edi
    add     wp, 0FFFFFFFFFFFFFFFCh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439980
    jmp     loc_439870; jumptable 00000000004398A3 case 4
loc_439994:
    xor     esi, esi
    test    r15, r15
    jnz     short loc_439938
    jmp     short loc_43996C
loc_43999D:
    mov     eax, r13d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff32 endp

