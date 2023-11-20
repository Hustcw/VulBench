horAcc32 proc
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     rax, [rax+8]
    mov     rcx, cc
    sar     rcx, 3Fh
    shr     rcx, 3Eh
    add     rcx, cc
    sar     rcx, 2
    sub     wc, stride
    jle     loc_438A4D
    lea     r12, [stride-4]
    lea     r9, [stride-0Ch]
    shr     r9, 3
    lea     r8, [r9+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF8h
    mov     r10, i
    sub     r10, r15
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    lea     r14, [stride+0Ch]
    cmp     stride, 4
    jbe     short loc_438953
    jmp     short def_438953; jumptable 0000000000438953 default case
loc_438920:
    mov     edx, [wp]; jumptable 0000000000438953 case 4
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438953 case 3
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438953 case 2
    add     [wp+stride*4], edx
    add     wp, 4
    mov     edx, [wp]; jumptable 0000000000438953 case 1
    add     [wp+stride*4], edx
    add     wp, 4
    sub     wc, stride; jumptable 0000000000438953 case 0
    jle     loc_438A4D
    cmp     stride, 4; switch 5 cases
    ja      short def_438953; jumptable 0000000000438953 default case
def_438953:
    jmp     ds:jpt_438953[stride*8]; switch jump
    test    i, i; jumptable 0000000000438953 default case
    jle     short loc_438920; jumptable 0000000000438953 case 4
    cmp     i, 8
    jnb     short loc_43896D
    mov     cc, i
    jmp     loc_438A30
loc_43896D:
    test    r9, r9
    jz      loc_438A44
    lea     tif, [wp+r14*4]
    xor     ebx, ebx
    mov     cc, r8
    nop
loc_438980:
    movdqu  xmm0, xmmword ptr [wp+rbx*4]
    movdqu  xmm1, xmmword ptr [wp+rbx*4+10h]
    movdqu  xmm2, xmmword ptr [rdi+rbx*4-30h]
    paddd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbx*4-20h]
    paddd   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rbx*4-10h]
    movdqu  xmm3, xmmword ptr [rdi+rbx*4]
    movdqu  xmmword ptr [rdi+rbx*4-30h], xmm2
    movdqu  xmmword ptr [rdi+rbx*4-20h], xmm0
    movdqu  xmm0, xmmword ptr [wp+rbx*4+20h]
    paddd   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [wp+rbx*4+30h]
    paddd   xmm1, xmm3
    movdqu  xmmword ptr [rdi+rbx*4-10h], xmm0
    movdqu  xmmword ptr [rdi+rbx*4], xmm1
    add     rbx, 10h
    add     rdx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438980
    test    r11, r11
    jz      short loc_438A11
loc_4389E4:
    lea     rdx, [wp+rbx*4]
    movdqu  xmm0, xmmword ptr [wp+rbx*4]
    movdqu  xmm1, xmmword ptr [wp+rbx*4+10h]
    movdqu  xmm2, xmmword ptr [rdx+stride*4]
    paddd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdx+stride*4+10h]
    paddd   xmm0, xmm1
    movdqu  xmmword ptr [rdx+stride*4], xmm2
    movdqu  xmmword ptr [rdx+stride*4+10h], xmm0
loc_438A11:
    lea     wp, [wp+r15*4]
    mov     rdx, r10
    cmp     i, r15
    jz      loc_438920; jumptable 0000000000438953 case 4
    nop     word ptr [stride+stride+00000000h]
    nop     dword ptr [stride+stride+00h]
loc_438A30:
    mov     edi, [wp]
    add     [wp+stride*4], edi
    add     wp, 4
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438A30
    jmp     loc_438920; jumptable 0000000000438953 case 4
loc_438A44:
    xor     ebx, ebx
    test    r11, r11
    jnz     short loc_4389E4
    jmp     short loc_438A11
loc_438A4D:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    retn
horAcc32 endp

