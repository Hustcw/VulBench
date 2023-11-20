horAcc8 proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     r12, [rax+8]
    cmp     stride, cc
    jge     loc_4386FF
    cmp     stride, 4
    jz      short loc_4384A9
    cmp     stride, 3
    jnz     loc_43857F
    add     rdx, 0FFFFFFFFFFFFFFFDh
    jle     loc_4386FF
    movzx   eax, byte ptr [cp0+2]
    movzx   ecx, byte ptr [cp0+1]
    movzx   edi, byte ptr [cp0]
    add     cp0, 5
    nop     word ptr [cb+cb+00000000h]
    nop
loc_438480:
    movzx   ebx, byte ptr [rsi-2]
    add     edi, ebx
    mov     [rsi-2], dil
    movzx   ebx, byte ptr [rsi-1]
    add     ecx, ebx
    mov     [rsi-1], cl
    movzx   ebx, byte ptr [rsi]
    add     eax, ebx
    mov     [rsi], al
    add     rsi, 3
    add     cc, 0FFFFFFFFFFFFFFFDh
    jg      short loc_438480
    jmp     loc_4386FF
loc_4384A9:
    mov     r8, rdx
    add     r8, 0FFFFFFFFFFFFFFFCh
    jle     loc_4386FF
    movzx   r9d, byte ptr [cp0+3]
    movzx   r11d, byte ptr [cp0+2]
    movzx   ebp, byte ptr [cp0+1]
    movzx   eax, byte ptr [cp0]
    lea     r10, [rdx-5]
    test    r10b, 4
    jnz     short loc_438505
    movzx   ebx, byte ptr [cp0+4]
    add     eax, ebx
    mov     [cp0+4], al
    movzx   ebx, byte ptr [cp0+5]
    add     ebp, ebx
    mov     [cp0+5], bpl
    movzx   ebx, byte ptr [cp0+6]
    add     r11d, ebx
    mov     [cp0+6], r11b
    movzx   ebx, byte ptr [cp0+7]
    add     r9d, ebx
    mov     [cp0+7], r9b
    add     cp0, 4
    add     rdx, 0FFFFFFFFFFFFFFF8h
    mov     r8, cc
loc_438505:
    cmp     r10, 4
    jb      loc_4386FF
    add     rsi, 0Bh
    nop     word ptr [cr+cr+00000000h]
    nop     dword ptr [cr]
loc_438520:
    movzx   edx, byte ptr [rsi-7]
    add     edx, eax
    mov     [rsi-7], dl
    movzx   ebx, byte ptr [rsi-6]
    add     ebx, ebp
    mov     [rsi-6], bl
    movzx   ecx, byte ptr [rsi-5]
    add     ecx, r11d
    mov     [rsi-5], cl
    movzx   edi, byte ptr [rsi-4]
    add     edi, r9d
    mov     [rsi-4], dil
    movzx   eax, byte ptr [rsi-3]
    add     eax, edx
    mov     [rsi-3], al
    movzx   ebp, byte ptr [rsi-2]
    add     ebp, ebx
    mov     [rsi-2], bpl
    movzx   r11d, byte ptr [rsi-1]
    add     r11d, ecx
    mov     [rsi-1], r11b
    movzx   r9d, byte ptr [rsi]
    add     r9d, edi
    mov     [rsi], r9b
    add     rsi, 8
    add     cc, 0FFFFFFFFFFFFFFF8h
    jg      short loc_438520
    jmp     loc_4386FF
loc_43857F:
    sub     cc, stride
    lea     r15, [stride-4]
    lea     r9, [stride-24h]
    shr     r9, 5
    lea     r8, [r9+1]
    mov     r14, i
    and     r14, 0FFFFFFFFFFFFFFE0h
    mov     r10, i
    sub     r10, r14
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    cmp     stride, 4
    jbe     short loc_4385F7
    jmp     short def_4385F7; jumptable 00000000004385F7 default case
loc_4385C0:
    mov     al, [cp]; jumptable 00000000004385F7 case 4
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004385F7 case 3
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004385F7 case 2
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004385F7 case 1
    add     [cp+stride], al
    add     cp, 1
    sub     cc, stride; jumptable 00000000004385F7 case 0
    jle     loc_4386FF
    cmp     stride, 4; switch 5 cases
    ja      short def_4385F7; jumptable 00000000004385F7 default case
def_4385F7:
    jmp     ds:jpt_4385F7[stride*8]; switch jump
    test    i, i; jumptable 00000000004385F7 default case
    jle     short loc_4385C0; jumptable 00000000004385F7 case 4
    cmp     i, 20h ; ' '
    jnb     short loc_438612
    mov     rax, i
    jmp     loc_4386E0
loc_438612:
    test    r9, r9
    jz      loc_4386F6
    lea     tif, [cp0+30h]
    lea     rcx, [cp0+stride]
    add     rcx, 30h ; '0'
    xor     ebx, ebx
    mov     rax, r8
    nop     dword ptr [rax+00h]
loc_438630:
    movdqu  xmm0, xmmword ptr [rdi+rbx-30h]
    movdqu  xmm1, xmmword ptr [rdi+rbx-20h]
    movdqu  xmm2, xmmword ptr [rcx+rbx-30h]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rcx+rbx-20h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rcx+rbx-10h]
    movdqu  xmm3, xmmword ptr [rcx+rbx]
    movdqu  xmmword ptr [rcx+rbx-30h], xmm2
    movdqu  xmmword ptr [rcx+rbx-20h], xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbx-10h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rbx]
    paddb   xmm1, xmm3
    movdqu  xmmword ptr [rcx+rbx-10h], xmm0
    movdqu  xmmword ptr [rcx+rbx], xmm1
    add     rbx, 40h ; '@'
    add     rax, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438630
    test    r11, r11
    jz      short loc_4386C5
loc_438694:
    lea     rax, [cp0+rbx]
    movdqu  xmm0, xmmword ptr [stride+rax]
    movdqu  xmm1, xmmword ptr [stride+rax+10h]
    movdqu  xmm2, xmmword ptr [cp0+rbx]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [cp0+rbx+10h]
    paddb   xmm0, xmm1
    movdqu  xmmword ptr [stride+rax], xmm2
    movdqu  xmmword ptr [stride+rax+10h], xmm0
loc_4386C5:
    add     cp0, r14
    mov     rax, r10
    cmp     i, r14
    jz      loc_4385C0; jumptable 00000000004385F7 case 4
    nop     word ptr [i+i+00000000h]
    xchg    ax, ax
loc_4386E0:
    movzx   ecx, byte ptr [cp]
    add     [cp+stride], cl
    add     cp, 1
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_4386E0
    jmp     loc_4385C0; jumptable 00000000004385F7 case 4
loc_4386F6:
    xor     ebx, ebx
    test    r11, r11
    jnz     short loc_438694
    jmp     short loc_4386C5
loc_4386FF:
    mov     eax, 1
    pop     rbx
    pop     stride
    pop     r14
    pop     r15
    pop     rbp
    retn
horAcc8 endp

