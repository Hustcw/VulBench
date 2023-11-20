horAcc8 proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [rax+8]
    mov     rax, rdx
    cqo
    idiv    stride
    test    rdx, rdx
    jz      short loc_4386A8
    mov     tif, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aHoracc8; "horAcc8"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCcStride0; "(cc%stride)!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43894E
loc_4386A8:
    mov     r14d, 1
    cmp     stride, cc
    jge     loc_43894E
    cmp     stride, 4
    jz      short loc_438709
    cmp     stride, 3
    jnz     loc_4387DF
    add     rcx, 0FFFFFFFFFFFFFFFDh
    jle     loc_43894E
    movzx   eax, byte ptr [cp0+2]
    movzx   edx, byte ptr [cp0+1]
    movzx   edi, byte ptr [cp0]
    add     cp0, 5
loc_4386E0:
    movzx   ebp, byte ptr [rsi-2]
    add     edi, ebp
    mov     [rsi-2], dil
    movzx   ebp, byte ptr [rsi-1]
    add     edx, ebp
    mov     [rsi-1], dl
    movzx   ebp, byte ptr [rsi]
    add     eax, ebp
    mov     [rsi], al
    add     rsi, 3
    add     cc, 0FFFFFFFFFFFFFFFDh
    jg      short loc_4386E0
    jmp     loc_43894E
loc_438709:
    mov     r9, rcx
    add     r9, 0FFFFFFFFFFFFFFFCh
    jle     loc_43894E
    movzx   r10d, byte ptr [cp0+3]
    movzx   r11d, byte ptr [cp0+2]
    movzx   edi, byte ptr [cp0+1]
    movzx   ebx, byte ptr [cp0]
    lea     r8, [rcx-5]
    test    r8b, 4
    jnz     short loc_438765
    movzx   ebp, byte ptr [cp0+4]
    add     ebx, ebp
    mov     [cp0+4], bl
    movzx   ebp, byte ptr [cp0+5]
    add     edi, ebp
    mov     [cp0+5], dil
    movzx   ebp, byte ptr [cp0+6]
    add     r11d, ebp
    mov     [cp0+6], r11b
    movzx   ebp, byte ptr [cp0+7]
    add     r10d, ebp
    mov     [cp0+7], r10b
    add     cp0, 4
    add     rcx, 0FFFFFFFFFFFFFFF8h
    mov     r9, cc
loc_438765:
    cmp     r8, 4
    jb      loc_43894E
    add     rsi, 0Bh
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax]
loc_438780:
    movzx   ecx, byte ptr [rsi-7]
    add     ecx, ebx
    mov     [rsi-7], cl
    movzx   ebp, byte ptr [rsi-6]
    add     ebp, edi
    mov     [rsi-6], bpl
    movzx   eax, byte ptr [rsi-5]
    add     eax, r11d
    mov     [rsi-5], al
    movzx   edx, byte ptr [rsi-4]
    add     edx, r10d
    mov     [rsi-4], dl
    movzx   ebx, byte ptr [rsi-3]
    add     ebx, ecx
    mov     [rsi-3], bl
    movzx   edi, byte ptr [rsi-2]
    add     edi, ebp
    mov     [rsi-2], dil
    movzx   r11d, byte ptr [rsi-1]
    add     r11d, eax
    mov     [rsi-1], r11b
    movzx   r10d, byte ptr [rsi]
    add     r10d, edx
    mov     [rsi], r10b
    add     rsi, 8
    add     cc, 0FFFFFFFFFFFFFFF8h
    jg      short loc_438780
    jmp     loc_43894E
loc_4387DF:
    sub     cc, stride
    lea     r12, [stride-4]
    lea     r10, [stride-24h]
    shr     r10, 5
    lea     r8, [r10+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFE0h
    mov     r9, i
    sub     r9, r15
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    cmp     stride, 4
    jbe     short loc_438853
    jmp     short def_438853; jumptable 0000000000438853 default case
loc_438820:
    mov     al, [cp]; jumptable 0000000000438853 case 4
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438853 case 3
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438853 case 2
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438853 case 1
    add     [cp+stride], al
    add     cp, 1
    sub     cc, stride; jumptable 0000000000438853 case 0
    jle     loc_43894E
    cmp     stride, 4; switch 5 cases
    ja      short def_438853; jumptable 0000000000438853 default case
def_438853:
    jmp     ds:jpt_438853[stride*8]; switch jump
    test    i, i; jumptable 0000000000438853 default case
    jle     short loc_438820; jumptable 0000000000438853 case 4
    cmp     i, 20h ; ' '
    jnb     short loc_43886D
    mov     rax, i
    jmp     loc_438930
loc_43886D:
    test    r10, r10
    jz      loc_438945
    lea     rdx, [cp0+30h]
    lea     tif, [cp0+stride]
    add     rdi, 30h ; '0'
    xor     ebp, ebp
    mov     rax, r8
    nop     word ptr [rax+rax+00000000h]
loc_438890:
    movdqu  xmm0, xmmword ptr [rdx+rbp-30h]
    movdqu  xmm1, xmmword ptr [rdx+rbp-20h]
    movdqu  xmm2, xmmword ptr [rdi+rbp-30h]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbp-20h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rbp-10h]
    movdqu  xmm3, xmmword ptr [rdi+rbp]
    movdqu  xmmword ptr [rdi+rbp-30h], xmm2
    movdqu  xmmword ptr [rdi+rbp-20h], xmm0
    movdqu  xmm0, xmmword ptr [rdx+rbp-10h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdx+rbp]
    paddb   xmm1, xmm3
    movdqu  xmmword ptr [rdi+rbp-10h], xmm0
    movdqu  xmmword ptr [rdi+rbp], xmm1
    add     rbp, 40h ; '@'
    add     rax, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438890
    test    r11, r11
    jz      short loc_438921
loc_4388F4:
    lea     rax, [cp0+rbp]
    movdqu  xmm0, xmmword ptr [stride+rax]
    movdqu  xmm1, xmmword ptr [stride+rax+10h]
    movdqu  xmm2, xmmword ptr [cp0+rbp]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [cp0+rbp+10h]
    paddb   xmm0, xmm1
    movdqu  xmmword ptr [stride+rax], xmm2
    movdqu  xmmword ptr [stride+rax+10h], xmm0
loc_438921:
    add     cp0, r15
    mov     rax, r9
    cmp     i, r15
    jz      loc_438820; jumptable 0000000000438853 case 4
loc_438930:
    movzx   edx, byte ptr [cp]
    add     [cp+stride], dl
    add     cp, 1
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438930
    jmp     loc_438820; jumptable 0000000000438853 case 4
loc_438945:
    xor     ebp, ebp
    test    r11, r11
    jnz     short loc_4388F4
    jmp     short loc_438921
loc_43894E:
    mov     eax, r14d
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
horAcc8 endp

