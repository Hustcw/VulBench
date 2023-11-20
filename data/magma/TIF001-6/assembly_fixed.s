horDiff8 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r9, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [sp_0+8]
    mov     sp_0, rdx
    cqo
    idiv    stride
    test    rdx, rdx
    jz      short loc_43933B
    mov     tif, [tif+458h]; fd
    xor     r13d, r13d
    mov     esi, offset aHordiff8; "horDiff8"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCcStride0; "(cc%stride)!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43958E
loc_43933B:
    mov     r13d, 1
    cmp     stride, cc
    jge     loc_43958E
    sub     cc, stride
    cmp     stride, 4
    jz      short loc_4393A9
    cmp     stride, 3
    jnz     loc_439409
    mov     dl, [cp0]
    mov     cl, [cp0+1]
    mov     r10b, [cp0+2]
    add     cp0, 5
    nop     word ptr [rax+rax+00h]
loc_439370:
    movzx   r8d, byte ptr [rsi-2]
    movzx   edi, byte ptr [rsi-1]
    mov     ebx, r8d
    sub     bl, dl
    mov     [rsi-2], bl
    mov     edx, edi
    sub     dl, cl
    mov     [rsi-1], dl
    movzx   eax, byte ptr [rsi]
    mov     ecx, eax
    sub     cl, r10b
    mov     [rsi], cl
    add     rsi, 3
    mov     edx, r8d
    mov     ecx, edi
    mov     r10d, eax
    add     cc, 0FFFFFFFFFFFFFFFDh
    jg      short loc_439370
    jmp     loc_43958E
loc_4393A9:
    mov     cl, [cp0]
    mov     bl, [cp0+1]
    mov     dl, [cp0+2]
    mov     r10b, [cp0+3]
    add     cp0, 7
    nop     dword ptr [rax+00000000h]
loc_4393C0:
    movzx   edi, byte ptr [rsi-3]
    movzx   r8d, byte ptr [rsi-2]
    mov     eax, edi
    sub     al, cl
    mov     [rsi-3], al
    mov     eax, r8d
    sub     al, bl
    mov     [rsi-2], al
    movzx   r11d, byte ptr [rsi-1]
    mov     ecx, r11d
    sub     cl, dl
    mov     [rsi-1], cl
    movzx   eax, byte ptr [rsi]
    mov     ecx, eax
    sub     cl, r10b
    mov     [rsi], cl
    add     rsi, 4
    mov     ecx, edi
    mov     ebx, r8d
    mov     edx, r11d
    mov     r10d, eax
    add     cc, 0FFFFFFFFFFFFFFFCh
    jg      short loc_4393C0
    jmp     loc_43958E
loc_439409:
    lea     rax, [cc+cp0]
    add     rax, 0FFFFFFFFFFFFFFFFh
    lea     r12, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     r8, [r11+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF0h
    mov     tif, i
    sub     rdi, r15
    mov     r10, r15
    neg     r10
    mov     r14d, r8d
    and     r14d, 1
    sub     r8, r14
    cmp     stride, 4
    jbe     short loc_439483
    jmp     short def_439483; jumptable 0000000000439483 default case
loc_439450:
    mov     cl, [cp]; jumptable 0000000000439483 case 4
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439483 case 3
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439483 case 2
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439483 case 1
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    sub     cc, stride; jumptable 0000000000439483 case 0
    jle     loc_43958E
    cmp     stride, 4; switch 5 cases
    ja      short def_439483; jumptable 0000000000439483 default case
def_439483:
    jmp     ds:jpt_439483[stride*8]; switch jump
    test    i, i; jumptable 0000000000439483 default case
    jle     short loc_439450; jumptable 0000000000439483 case 4
    cmp     i, 10h
    jnb     short loc_43949D
    mov     rdx, i
    jmp     loc_439570
loc_43949D:
    test    r11, r11
    jz      loc_439585
    mov     rcx, rdi
    lea     rdi, [cp-7]
    lea     rdx, [cp+stride]
    add     rdx, 0FFFFFFFFFFFFFFF9h
    xor     esi, esi
    mov     rbp, r8
    nop     word ptr [cp+cp+00h]
loc_4394C0:
    movq    xmm0, qword ptr [rdx+rsi]
    movq    xmm1, qword ptr [rdx+rsi-8]
    movq    xmm2, qword ptr [rdi+rsi]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdi+rsi-8]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rsi], xmm0
    movq    qword ptr [rdx+rsi-8], xmm1
    movq    xmm0, qword ptr [rdx+rsi-10h]
    movq    xmm1, qword ptr [rdx+rsi-18h]
    movq    xmm2, qword ptr [rdi+rsi-10h]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdi+rsi-18h]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rsi-10h], xmm0
    movq    qword ptr [rdx+rsi-18h], xmm1
    add     rsi, 0FFFFFFFFFFFFFFE0h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4394C0
    neg     rsi
    mov     rdi, rcx
    test    r14, r14
    jz      short loc_43955A
loc_43952A:
    mov     rdx, cp
    sub     rdx, rsi
    movq    xmm0, qword ptr [rdx+stride-7]
    movq    xmm1, qword ptr [rdx+stride-0Fh]
    movq    xmm2, qword ptr [rdx-7]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdx-0Fh]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+stride-7], xmm0
    movq    qword ptr [rdx+stride-0Fh], xmm1
loc_43955A:
    add     cp, r10
    mov     rdx, rdi
    cmp     i, r15
    jz      loc_439450; jumptable 0000000000439483 case 4
    nop     dword ptr [cp+00000000h]
loc_439570:
    movzx   ecx, byte ptr [cp]
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439570
    jmp     loc_439450; jumptable 0000000000439483 case 4
loc_439585:
    xor     esi, esi
    test    r14, r14
    jnz     short loc_43952A
    jmp     short loc_43955A
loc_43958E:
    mov     eax, r13d
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff8 endp

