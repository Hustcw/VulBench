fpAcc proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r12, cc
    mov     rax, [tif+3F0h]
    mov     rbp, [rax+8]
    movzx   r13d, word ptr [tif+74h]
    shr     r13, 3
    mov     rax, rdx
    cqo
    idiv    r13
    mov     rbx, rax
    mov     rcx, stride
    imul    rcx, r13
    mov     rax, count
    cqo
    idiv    rcx
    test    rdx, rdx
    jz      short loc_439038
    mov     tif, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset aFpacc; "fpAcc"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCcBpsStride0; "cc%(bps*stride))!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_4392DB
loc_439038:
    mov     r14, cp0
    mov     tif, count; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_4392D9
    mov     r15, rax
    cmp     stride, count
    jge     loc_4391F1
    lea     r11, [stride-4]
    lea     rsi, [stride-24h]
    shr     rsi, 5
    lea     rax, [rsi+1]
    mov     rcx, i
    and     rcx, 0FFFFFFFFFFFFFFE0h
    mov     rdx, i
    mov     [rsp+58h+var_38], rcx
    sub     rdx, rcx
    mov     [rsp+58h+var_40], rdx
    mov     ecx, eax
    and     ecx, 1
    mov     [rsp+58h+var_48], rcx
    sub     rax, rcx
    mov     [rsp+58h+var_50], rax
    mov     rdi, cp
    mov     rcx, count
    cmp     stride, 4
    jbe     short loc_4390D6
    jmp     short def_4390D6; jumptable 00000000004390D6 default case
loc_4390A0:
    mov     al, [cp]; jumptable 00000000004390D6 case 4
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004390D6 case 3
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004390D6 case 2
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 00000000004390D6 case 1
    add     [cp+stride], al
    add     cp, 1
    sub     count, stride; jumptable 00000000004390D6 case 0
    cmp     count, stride
    jle     loc_4391F1
    cmp     stride, 4; switch 5 cases
    ja      short def_4390D6; jumptable 00000000004390D6 default case
def_4390D6:
    jmp     ds:jpt_4390D6[stride*8]; switch jump
    test    i, i; jumptable 00000000004390D6 default case
    jle     short loc_4390A0; jumptable 00000000004390D6 case 4
    cmp     i, 20h ; ' '
    jnb     short loc_4390F0
    mov     rdx, i
    jmp     loc_4391D0
loc_4390F0:
    test    rsi, rsi
    jz      loc_4391E5
    lea     r8, [cp+30h]
    lea     r9, [cp+stride]
    add     r9, 30h ; '0'
    xor     edx, edx
    mov     r10, [rsp+58h+var_50]
    nop     dword ptr [rax+00h]
loc_439110:
    movdqu  xmm0, xmmword ptr [r8+rdx-30h]
    movdqu  xmm1, xmmword ptr [r8+rdx-20h]
    movdqu  xmm2, xmmword ptr [r9+rdx-30h]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [r9+rdx-20h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [r9+rdx-10h]
    movdqu  xmm3, xmmword ptr [r9+rdx]
    movdqu  xmmword ptr [r9+rdx-30h], xmm2
    movdqu  xmmword ptr [r9+rdx-20h], xmm0
    movdqu  xmm0, xmmword ptr [r8+rdx-10h]
    paddb   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [r8+rdx]
    paddb   xmm1, xmm3
    movdqu  xmmword ptr [r9+rdx-10h], xmm0
    movdqu  xmmword ptr [r9+rdx], xmm1
    add     rdx, 40h ; '@'
    add     r10, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_439110
    cmp     [rsp+58h+var_48], 0
    jz      short loc_4391B8
loc_439183:
    mov     rax, rsi
    lea     rsi, [cp+rdx]
    movdqu  xmm0, xmmword ptr [stride+rsi+0]
    movdqu  xmm1, xmmword ptr [stride+rsi+10h]
    movdqu  xmm2, xmmword ptr [cp+rdx]
    paddb   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [cp+rdx+10h]
    paddb   xmm0, xmm1
    movdqu  xmmword ptr [stride+rsi+0], xmm2
    movdqu  xmmword ptr [stride+rsi+10h], xmm0
    mov     rsi, rax
loc_4391B8:
    mov     rax, [rsp+58h+var_38]
    add     cp, rax
    mov     rdx, [rsp+58h+var_40]
    cmp     i, rax
    jz      loc_4390A0; jumptable 00000000004390D6 case 4
    xchg    ax, ax
loc_4391D0:
    movzx   eax, byte ptr [cp]
    add     [cp+stride], al
    add     cp, 1
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_4391D0
    jmp     loc_4390A0; jumptable 00000000004390D6 case 4
loc_4391E5:
    xor     edx, edx
    cmp     [rsp+58h+var_48], 0
    jnz     short loc_439183
    jmp     short loc_4391B8
loc_4391F1:
    mov     rdi, tmp; d
    mov     rsi, cp0; s
    mov     rdx, cc; c
    call    _TIFFmemcpy
    test    wc, wc
    jle     loc_4392CA
    movzx   r10d, r13w
    mov     r9d, r10d
    and     r9d, 1
    lea     rdx, [cp+1]
    lea     r8d, [bps-2]
    mov     rdi, r10
    sub     rdi, r9
    xor     ebp, ebp
    test    r13w, r13w
    jnz     short loc_439246
    nop     dword ptr [rax+00000000h]
loc_439230:
    add     count, 1
    add     rdx, r10
    cmp     count, wc
    jz      loc_4392CA
    test    r13w, r13w
    jz      short loc_439230
loc_439246:
    cmp     r13w, 1
    jnz     short loc_439260
    xor     esi, esi
    xor     ecx, ecx
    test    r9, r9
    jz      short loc_439230
    jmp     short loc_4392A7
loc_439260:
    mov     ecx, r8d
    xor     esi, esi
    nop     word ptr [rax+rax+00000000h]
    nop
loc_439270:
    lea     eax, [rcx+1]
    imul    rax, wc
    add     rax, count
    movzx   eax, byte ptr [tmp+rax]
    mov     [rdx+byte-1], al
    mov     eax, ecx
    imul    rax, wc
    add     rax, count
    movzx   eax, byte ptr [tmp+rax]
    mov     [rdx+rsi], al
    add     rsi, 2
    add     ecx, 0FFFFFFFEh
    cmp     rdi, rsi
    jnz     short loc_439270
    mov     ecx, esi
    test    r9, r9
    jz      short loc_439230
loc_4392A7:
    mov     rax, count
    imul    rax, bps
    not     ecx
    add     ecx, r13d
    imul    rcx, wc
    add     rcx, count
    mov     cl, [tmp+rcx]
    add     rax, rsi
    mov     [cp+rax], cl
    jmp     loc_439230
loc_4392CA:
    mov     rdi, tmp; p
    call    _TIFFfree
    mov     ebx, 1
    jmp     short loc_4392DB
loc_4392D9:
    xor     ebx, ebx
loc_4392DB:
    mov     eax, ebx
    add     rsp, 28h
    pop     rbx
    pop     cc
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
fpAcc endp

