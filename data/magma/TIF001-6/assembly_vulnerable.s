horDiff8 proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     r13, [sp_0+8]
    cmp     stride, cc
    jge     loc_4391FF
    sub     cc, stride
    cmp     stride, 4
    jz      short loc_439019
    cmp     stride, 3
    jnz     loc_43907C
    mov     bl, [cp0]
    mov     cl, [cp0+1]
    mov     r9b, [cp0+2]
    add     cp0, 5
    nop     dword ptr [sp_0]
loc_438FE0:
    movzx   edi, byte ptr [rsi-2]
    movzx   r8d, byte ptr [rsi-1]
    mov     eax, edi
    sub     al, bl
    mov     [rsi-2], al
    mov     eax, r8d
    sub     al, cl
    mov     [rsi-1], al
    movzx   eax, byte ptr [rsi]
    mov     ecx, eax
    sub     cl, r9b
    mov     [rsi], cl
    add     rsi, 3
    mov     r9d, eax
    mov     ecx, r8d
    mov     ebx, edi
    add     cc, 0FFFFFFFFFFFFFFFDh
    jg      short loc_438FE0
    jmp     loc_4391FF
loc_439019:
    mov     al, [cp0]
    mov     bl, [cp0+1]
    mov     r10b, [cp0+2]
    mov     dil, [cp0+3]
    add     cp0, 7
    nop     word ptr [r2+r2+00h]
loc_439030:
    movzx   r8d, byte ptr [rsi-3]
    movzx   r9d, byte ptr [rsi-2]
    mov     ecx, r8d
    sub     cl, al
    mov     [rsi-3], cl
    mov     eax, r9d
    sub     al, bl
    mov     [rsi-2], al
    movzx   r11d, byte ptr [rsi-1]
    mov     eax, r11d
    sub     al, r10b
    mov     [rsi-1], al
    movzx   ecx, byte ptr [rsi]
    mov     eax, ecx
    sub     al, dil
    mov     [rsi], al
    add     rsi, 4
    mov     eax, r8d
    mov     ebx, r9d
    mov     r10d, r11d
    mov     edi, ecx
    add     cc, 0FFFFFFFFFFFFFFFCh
    jg      short loc_439030
    jmp     loc_4391FF
loc_43907C:
    lea     rcx, [cc+cp0]
    add     rcx, 0FFFFFFFFFFFFFFFFh
    lea     r12, [stride-4]
    lea     r9, [stride-14h]
    shr     r9, 4
    lea     r8, [r9+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r15
    mov     r11, r15
    neg     r11
    mov     r14d, r8d
    and     r14d, 1
    sub     r8, r14
    cmp     stride, 4
    jbe     short loc_4390F7
    jmp     short def_4390F7; jumptable 00000000004390F7 default case
loc_4390C0:
    mov     al, [cp]; jumptable 00000000004390F7 case 4
    sub     [cp+stride], al
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     al, [cp]; jumptable 00000000004390F7 case 3
    sub     [cp+stride], al
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     al, [cp]; jumptable 00000000004390F7 case 2
    sub     [cp+stride], al
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     al, [cp]; jumptable 00000000004390F7 case 1
    sub     [cp+stride], al
    add     cp, 0FFFFFFFFFFFFFFFFh
    sub     cc, stride; jumptable 00000000004390F7 case 0
    jle     loc_4391FF
    cmp     stride, 4; switch 5 cases
    ja      short def_4390F7; jumptable 00000000004390F7 default case
def_4390F7:
    jmp     ds:jpt_4390F7[stride*8]; switch jump
    test    i, i; jumptable 00000000004390F7 default case
    jle     short loc_4390C0; jumptable 00000000004390F7 case 4
    cmp     i, 10h
    jnb     short loc_439112
    mov     sp_0, i
    jmp     loc_4391E0
loc_439112:
    test    r9, r9
    jz      loc_4391F6
    lea     tif, [cp-7]
    lea     cp0, [cp+stride]
    add     rsi, 0FFFFFFFFFFFFFFF9h
    xor     ebx, ebx
    mov     sp_0, r8
    nop     dword ptr [rax+00h]
loc_439130:
    movq    xmm0, qword ptr [rsi+rbx]
    movq    xmm1, qword ptr [rsi+rbx-8]
    movq    xmm2, qword ptr [rdi+rbx]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdi+rbx-8]
    psubb   xmm1, xmm2
    movq    qword ptr [rsi+rbx], xmm0
    movq    qword ptr [rsi+rbx-8], xmm1
    movq    xmm0, qword ptr [rsi+rbx-10h]
    movq    xmm1, qword ptr [rsi+rbx-18h]
    movq    xmm2, qword ptr [rdi+rbx-10h]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdi+rbx-18h]
    psubb   xmm1, xmm2
    movq    qword ptr [rsi+rbx-10h], xmm0
    movq    qword ptr [rsi+rbx-18h], xmm1
    add     rbx, 0FFFFFFFFFFFFFFE0h
    add     rax, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_439130
    neg     rbx
    test    r14, r14
    jz      short loc_4391CB
loc_439197:
    mov     rax, cp
    sub     rax, rbx
    movq    xmm0, qword ptr [rax+stride-7]
    movq    xmm1, qword ptr [rax+stride-0Fh]
    movq    xmm2, qword ptr [rax-7]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rax-0Fh]
    psubb   xmm1, xmm2
    movq    qword ptr [rax+stride-7], xmm0
    movq    qword ptr [rax+stride-0Fh], xmm1
loc_4391CB:
    add     cp, r11
    mov     rax, r10
    cmp     i, r15
    jz      loc_4390C0; jumptable 00000000004390F7 case 4
    nop     word ptr [i+i+00h]
loc_4391E0:
    movzx   ebx, byte ptr [cp]
    sub     [cp+stride], bl
    add     cp, 0FFFFFFFFFFFFFFFFh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_4391E0
    jmp     loc_4390C0; jumptable 00000000004390F7 case 4
loc_4391F6:
    xor     ebx, ebx
    test    r14, r14
    jnz     short loc_439197
    jmp     short loc_4391CB
loc_4391FF:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     stride
    pop     r14
    pop     r15
    retn
horDiff8 endp

