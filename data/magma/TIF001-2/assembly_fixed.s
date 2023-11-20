horAcc16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [rax+8]
    lea     r12, [stride+stride]
    mov     rax, rdx
    cqo
    idiv    r12
    test    rdx, rdx
    jz      short loc_4389AF
    mov     tif, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aHoracc16; "horAcc16"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCc2Stride0; "cc%(2*stride))!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_438B3F
loc_4389AF:
    mov     rax, cc
    shr     rax, 3Fh
    add     rax, cc
    sar     rax, 1
    mov     r14d, 1
    sub     wc, stride
    jle     loc_438B3F
    lea     r13, [stride-4]
    lea     r10, [stride-14h]
    shr     r10, 4
    lea     r8, [r10+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF0h
    mov     r9, i
    sub     r9, r15
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    cmp     stride, 4
    jbe     short loc_438A3B
    jmp     short def_438A3B; jumptable 0000000000438A3B default case
loc_438A00:
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 4
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 3
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 2
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 1
    add     [wp+stride*2], cx
    add     wp, 2
    sub     wc, stride; jumptable 0000000000438A3B case 0
    jle     loc_438B3F
    cmp     stride, 4; switch 5 cases
    ja      short def_438A3B; jumptable 0000000000438A3B default case
def_438A3B:
    jmp     ds:jpt_438A3B[stride*8]; switch jump
    test    i, i; jumptable 0000000000438A3B default case
    jle     short loc_438A00; jumptable 0000000000438A3B case 4
    cmp     i, 10h
    jnb     short loc_438A55
    mov     cc, i
    jmp     loc_438B20
loc_438A55:
    test    r10, r10
    jz      loc_438B36
    lea     tif, [wp+30h]
    lea     rbp, [wp+r12]
    add     rbp, 30h ; '0'
    xor     edx, edx
    mov     cc, r8
    nop
loc_438A70:
    movdqu  xmm0, xmmword ptr [rdi+rdx*2-30h]
    movdqu  xmm1, xmmword ptr [rdi+rdx*2-20h]
    movdqu  xmm2, xmmword ptr [rbp+rdx*2-30h]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rbp+rdx*2-20h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rbp+rdx*2-10h]
    movdqu  xmm3, xmmword ptr [rbp+rdx*2+0]
    movdqu  xmmword ptr [rbp+rdx*2-30h], xmm2
    movdqu  xmmword ptr [rbp+rdx*2-20h], xmm0
    movdqu  xmm0, xmmword ptr [rdi+rdx*2-10h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rdx*2]
    paddw   xmm1, xmm3
    movdqu  xmmword ptr [rbp+rdx*2-10h], xmm0
    movdqu  xmmword ptr [rbp+rdx*2+0], xmm1
    add     rdx, 20h ; ' '
    add     rcx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438A70
    test    r11, r11
    jz      short loc_438B03
loc_438AD6:
    lea     rcx, [wp+rdx*2]
    movdqu  xmm0, xmmword ptr [rcx+stride*2]
    movdqu  xmm1, xmmword ptr [rcx+stride*2+10h]
    movdqu  xmm2, xmmword ptr [wp+rdx*2]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rdx*2+10h]
    paddw   xmm0, xmm1
    movdqu  xmmword ptr [rcx+stride*2], xmm2
    movdqu  xmmword ptr [rcx+stride*2+10h], xmm0
loc_438B03:
    lea     wp, [wp+r15*2]
    mov     rcx, r9
    cmp     i, r15
    jz      loc_438A00; jumptable 0000000000438A3B case 4
    nop     word ptr [wc+wc+00000000h]
    nop     dword ptr [wc]
loc_438B20:
    movzx   edx, word ptr [wp]
    add     [wp+stride*2], dx
    add     wp, 2
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438B20
    jmp     loc_438A00; jumptable 0000000000438A3B case 4
loc_438B36:
    xor     edx, edx
    test    r11, r11
    jnz     short loc_438AD6
    jmp     short loc_438B03
loc_438B3F:
    mov     eax, r14d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horAcc16 endp

