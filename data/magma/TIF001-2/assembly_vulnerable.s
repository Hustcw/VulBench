horAcc16 proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     rax, [rax+8]
    mov     r13, cc
    shr     r13, 3Fh
    add     r13, cc
    sar     r13, 1
    sub     wc, stride
    jle     loc_4388AF
    lea     r12, [stride-4]
    lea     r9, [stride-14h]
    shr     r9, 4
    lea     r8, [r9+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r15
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    lea     r14, [stride+stride]
    cmp     stride, 4
    jbe     short loc_4387AB
    jmp     short def_4387AB; jumptable 00000000004387AB default case
loc_438770:
    movzx   ecx, word ptr [wp]; jumptable 00000000004387AB case 4
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 00000000004387AB case 3
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 00000000004387AB case 2
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 00000000004387AB case 1
    add     [wp+stride*2], cx
    add     wp, 2
    sub     wc, stride; jumptable 00000000004387AB case 0
    jle     loc_4388AF
    cmp     stride, 4; switch 5 cases
    ja      short def_4387AB; jumptable 00000000004387AB default case
def_4387AB:
    jmp     ds:jpt_4387AB[stride*8]; switch jump
    test    i, i; jumptable 00000000004387AB default case
    jle     short loc_438770; jumptable 00000000004387AB case 4
    cmp     i, 10h
    jnb     short loc_4387C5
    mov     rcx, i
    jmp     loc_438890
loc_4387C5:
    test    r9, r9
    jz      loc_4388A6
    lea     tif, [wp+30h]
    lea     cc, [wp+r14]
    add     rdx, 30h ; '0'
    xor     ebx, ebx
    mov     rcx, r8
    nop
loc_4387E0:
    movdqu  xmm0, xmmword ptr [rdi+rbx*2-30h]
    movdqu  xmm1, xmmword ptr [rdi+rbx*2-20h]
    movdqu  xmm2, xmmword ptr [rdx+rbx*2-30h]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdx+rbx*2-20h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdx+rbx*2-10h]
    movdqu  xmm3, xmmword ptr [rdx+rbx*2]
    movdqu  xmmword ptr [rdx+rbx*2-30h], xmm2
    movdqu  xmmword ptr [rdx+rbx*2-20h], xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbx*2-10h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rbx*2]
    paddw   xmm1, xmm3
    movdqu  xmmword ptr [rdx+rbx*2-10h], xmm0
    movdqu  xmmword ptr [rdx+rbx*2], xmm1
    add     rbx, 20h ; ' '
    add     rcx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4387E0
    test    r11, r11
    jz      short loc_438871
loc_438844:
    lea     rcx, [wp+rbx*2]
    movdqu  xmm0, xmmword ptr [rcx+stride*2]
    movdqu  xmm1, xmmword ptr [rcx+stride*2+10h]
    movdqu  xmm2, xmmword ptr [wp+rbx*2]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rbx*2+10h]
    paddw   xmm0, xmm1
    movdqu  xmmword ptr [rcx+stride*2], xmm2
    movdqu  xmmword ptr [rcx+stride*2+10h], xmm0
loc_438871:
    lea     wp, [wp+r15*2]
    mov     rcx, r10
    cmp     i, r15
    jz      loc_438770; jumptable 00000000004387AB case 4
    nop     word ptr [stride+stride+00000000h]
    nop     dword ptr [stride+stride+00h]
loc_438890:
    movzx   edx, word ptr [wp]
    add     [wp+stride*2], dx
    add     wp, 2
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438890
    jmp     loc_438770; jumptable 00000000004387AB case 4
loc_4388A6:
    xor     ebx, ebx
    test    r11, r11
    jnz     short loc_438844
    jmp     short loc_438871
loc_4388AF:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
horAcc16 endp

