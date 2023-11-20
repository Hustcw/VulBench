horAcc32 proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [rax+8]
    lea     rbp, ds:0[stride*4]
    mov     rax, rdx
    cqo
    idiv    rbp
    test    rdx, rdx
    jz      short loc_438BB0
    mov     tif, [tif+458h]; fd
    xor     r12d, r12d
    mov     esi, offset aHoracc32; "horAcc32"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCc4Stride0; "cc%(4*stride))!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_438D3D
loc_438BB0:
    mov     rax, cc
    sar     rax, 3Fh
    shr     rax, 3Eh
    add     rax, cc
    sar     rax, 2
    mov     r12d, 1
    sub     wc, stride
    jle     loc_438D3D
    lea     cc, [stride-4]
    lea     r10, [stride-0Ch]
    shr     r10, 3
    lea     r8, [r10+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF8h
    mov     r9, i
    sub     r9, r15
    mov     r14d, r8d
    and     r14d, 1
    sub     r8, r14
    lea     r11, [stride+0Ch]
    cmp     stride, 4
    jbe     short loc_438C43
    jmp     short def_438C43; jumptable 0000000000438C43 default case
loc_438C10:
    mov     edx, [wp]; jumptable 0000000000438C43 case 4
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438C43 case 3
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438C43 case 2
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438C43 case 1
    add     [wp+stride*4], edx
    add     wp, 4
    sub     wc, stride; jumptable 0000000000438C43 case 0
    jle     loc_438D3D
    cmp     stride, 4; switch 5 cases
    ja      short def_438C43; jumptable 0000000000438C43 default case
def_438C43:
    jmp     ds:jpt_438C43[stride*8]; switch jump
    test    i, i; jumptable 0000000000438C43 default case
    jle     short loc_438C10; jumptable 0000000000438C43 case 4
    cmp     i, 8
    jnb     short loc_438C5D
    mov     rdx, i
    jmp     loc_438D20
loc_438C5D:
    test    r10, r10
    jz      loc_438D34
    lea     tif, [wp+r11*4]
    xor     edx, edx
    mov     rbp, r8
    nop
loc_438C70:
    movdqu  xmm0, xmmword ptr [wp+rdx*4]
    movdqu  xmm1, xmmword ptr [wp+rdx*4+10h]
    movdqu  xmm2, xmmword ptr [rdi+rdx*4-30h]
    paddd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rdx*4-20h]
    paddd   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rdx*4-10h]
    movdqu  xmm3, xmmword ptr [rdi+rdx*4]
    movdqu  xmmword ptr [rdi+rdx*4-30h], xmm2
    movdqu  xmmword ptr [rdi+rdx*4-20h], xmm0
    movdqu  xmm0, xmmword ptr [wp+rdx*4+20h]
    paddd   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [wp+rdx*4+30h]
    paddd   xmm1, xmm3
    movdqu  xmmword ptr [rdi+rdx*4-10h], xmm0
    movdqu  xmmword ptr [rdi+rdx*4], xmm1
    add     rdx, 10h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438C70
    test    r14, r14
    jz      short loc_438D01
loc_438CD4:
    lea     rdi, [wp+rdx*4]
    movdqu  xmm0, xmmword ptr [wp+rdx*4]
    movdqu  xmm1, xmmword ptr [wp+rdx*4+10h]
    movdqu  xmm2, xmmword ptr [rdi+stride*4]
    paddd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+stride*4+10h]
    paddd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+stride*4], xmm2
    movdqu  xmmword ptr [rdi+stride*4+10h], xmm0
loc_438D01:
    lea     wp, [wp+r15*4]
    mov     rdx, r9
    cmp     i, r15
    jz      loc_438C10; jumptable 0000000000438C43 case 4
    nop     word ptr [wc+wc+00000000h]
    nop     dword ptr [wc+wc+00h]
loc_438D20:
    mov     edi, [wp]
    add     [wp+stride*4], edi
    add     wp, 4
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438D20
    jmp     loc_438C10; jumptable 0000000000438C43 case 4
loc_438D34:
    xor     edx, edx
    test    r14, r14
    jnz     short loc_438CD4
    jmp     short loc_438D01
loc_438D3D:
    mov     eax, r12d
    pop     stride
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
horAcc32 endp

