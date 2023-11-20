horDiff16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     sp_0, [sp_0+8]
    mov     rcx, cc
    shr     rcx, 3Fh
    add     rcx, cc
    sar     rcx, 1
    sub     wc, stride
    jle     loc_4393BF
    lea     cc, [wp+wc*2]
    add     rdx, 0FFFFFFFFFFFFFFFEh
    lea     r13, [stride-4]
    lea     r9, [stride-14h]
    shr     r9, 4
    lea     r8, [r9+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r12
    mov     r11, r12
    neg     r11
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride+stride]
    cmp     stride, 4
    jbe     short loc_4392BB
    jmp     short def_4392BB; jumptable 00000000004392BB default case
loc_439280:
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 4
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 3
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 2
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 00000000004392BB case 1
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    sub     wc, stride; jumptable 00000000004392BB case 0
    jle     loc_4393BF
    cmp     stride, 4; switch 5 cases
    ja      short def_4392BB; jumptable 00000000004392BB default case
def_4392BB:
    jmp     ds:jpt_4392BB[stride*8]; switch jump
    test    i, i; jumptable 00000000004392BB default case
    jle     short loc_439280; jumptable 00000000004392BB case 4
    cmp     i, 10h
    jnb     short loc_4392D5
    mov     cp0, i
    jmp     loc_4393A0
loc_4392D5:
    test    r9, r9
    jz      loc_4393B6
    lea     tif, [wp-0Eh]
    lea     cp0, [wp+r14]
    add     rsi, 0FFFFFFFFFFFFFFF2h
    xor     ebx, ebx
    mov     rbp, r8
    nop
loc_4392F0:
    movdqu  xmm0, xmmword ptr [rsi+rbx*2-30h]
    movdqu  xmm1, xmmword ptr [rsi+rbx*2-20h]
    movdqu  xmm2, xmmword ptr [rsi+rbx*2-10h]
    movdqu  xmm3, xmmword ptr [rsi+rbx*2]
    movdqu  xmm4, xmmword ptr [rdi+rbx*2-10h]
    psubw   xmm2, xmm4
    movdqu  xmm4, xmmword ptr [rdi+rbx*2]
    psubw   xmm3, xmm4
    movdqu  xmmword ptr [rsi+rbx*2], xmm3
    movdqu  xmmword ptr [rsi+rbx*2-10h], xmm2
    movdqu  xmm2, xmmword ptr [rdi+rbx*2-30h]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi+rbx*2-20h]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rsi+rbx*2-20h], xmm1
    movdqu  xmmword ptr [rsi+rbx*2-30h], xmm0
    add     rbx, 0FFFFFFFFFFFFFFE0h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4392F0
    neg     rbx
    test    r15, r15
    jz      short loc_43938A
loc_439357:
    add     rbx, rbx
    mov     rsi, wp
    sub     rsi, rbx
    movdqu  xmm0, xmmword ptr [rsi+stride*2-1Eh]
    movdqu  xmm1, xmmword ptr [rsi+stride*2-0Eh]
    movdqu  xmm2, xmmword ptr [rsi-1Eh]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rsi-0Eh]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rsi+stride*2-0Eh], xmm1
    movdqu  xmmword ptr [rsi+stride*2-1Eh], xmm0
loc_43938A:
    lea     wp, [wp+r11*2]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439280; jumptable 00000000004392BB case 4
    nop     word ptr [stride+stride+00h]
loc_4393A0:
    movzx   edi, word ptr [wp]
    sub     [wp+stride*2], di
    add     wp, 0FFFFFFFFFFFFFFFEh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_4393A0
    jmp     loc_439280; jumptable 00000000004392BB case 4
loc_4393B6:
    xor     ebx, ebx
    test    r15, r15
    jnz     short loc_439357
    jmp     short loc_43938A
loc_4393BF:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff16 endp



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



fpDiff proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r14, cc
    mov     r15, cp0
    mov     rax, [tif+3F0h]
    mov     r13, [rax+8]
    movzx   ebx, word ptr [tif+74h]
    shr     rbx, 3
    mov     rax, rdx
    cqo
    idiv    rbx
    mov     r12, rax
    mov     tif, cc; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_439AD0
    mov     rbp, rax
    mov     rdi, rax; d
    mov     rsi, cp0; s
    mov     rdx, cc; c
    call    _TIFFmemcpy
    test    wc, wc
    jle     loc_43991F
    movzx   r10d, bx
    mov     r9d, r10d
    and     r9d, 1
    mov     rdx, tmp
    add     rdx, 1
    lea     eax, [bps-2]
    mov     [rsp+38h+var_34], eax
    mov     r11, r10
    sub     r11, r9
    xor     edi, edi
    test    bx, bx
    jnz     short loc_439895
loc_439880:
    add     count, 1
    add     rdx, r10
    cmp     count, wc
    jz      loc_43991F
    test    bx, bx
    jz      short loc_439880
loc_439895:
    cmp     bx, 1
    jnz     short loc_4398B0
    xor     ecx, ecx
    xor     eax, eax
    test    r9, r9
    jz      short loc_439880
    jmp     short loc_4398FD
loc_4398B0:
    mov     r8, tmp
    mov     rsi, bps
    mov     eax, [rsp+38h+var_34]
    xor     ecx, ecx
    nop     dword ptr [rax+00h]
loc_4398C0:
    movzx   ebx, byte ptr [rdx+byte-1]
    lea     ebp, [rax+1]
    imul    rbp, wc
    add     rbp, count
    mov     [cp0+rbp], bl
    movzx   ebx, byte ptr [rdx+rcx]
    mov     ebp, eax
    imul    rbp, wc
    add     rbp, count
    mov     [cp0+rbp], bl
    add     rcx, 2
    add     eax, 0FFFFFFFEh
    cmp     r11, rcx
    jnz     short loc_4398C0
    mov     eax, ecx
    mov     rbx, rsi
    mov     rbp, r8
    test    r9, r9
    jz      short loc_439880
loc_4398FD:
    mov     rsi, count
    imul    rsi, rbx
    add     rsi, rcx
    mov     cl, [rbp+rsi+0]
    not     eax
    add     eax, ebx
    imul    rax, wc
    add     rax, count
    mov     [cp0+rax], cl
    jmp     loc_439880
loc_43991F:
    mov     rdi, tmp; p
    call    _TIFFfree
    mov     eax, 1
    cmp     stride, count
    jge     loc_439AD2
    mov     rcx, stride
    not     rcx
    add     rcx, count
    add     cp0, rcx
    lea     rcx, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     r10, [r11+1]
    mov     rdi, i
    and     rdi, 0FFFFFFFFFFFFFFF0h
    mov     r8, i
    sub     r8, rdi
    mov     r9, rdi
    neg     r9
    mov     r12d, r10d
    and     r12d, 1
    sub     r10, r12
    cmp     stride, 4
    jbe     short loc_4399BE
    jmp     short def_4399BE; jumptable 00000000004399BE default case
loc_439980:
    mov     dl, [cp]; jumptable 00000000004399BE case 4
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 3
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 2
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     dl, [cp]; jumptable 00000000004399BE case 1
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    sub     count, stride; jumptable 00000000004399BE case 0
    cmp     count, stride
    jle     loc_439AD2
    cmp     stride, 4; switch 5 cases
    ja      short def_4399BE; jumptable 00000000004399BE default case
def_4399BE:
    jmp     ds:jpt_4399BE[stride*8]; switch jump
    test    i, i; jumptable 00000000004399BE default case
    jle     short loc_439980; jumptable 00000000004399BE case 4
    cmp     i, 10h
    jnb     short loc_4399D9
    mov     rdx, i
    jmp     loc_439AB0
loc_4399D9:
    test    r11, r11
    jz      loc_439AC7
    lea     rbx, [cp-7]
    lea     rdx, [cp+stride]
    add     rdx, 0FFFFFFFFFFFFFFF9h
    xor     ebp, ebp
    mov     rsi, r10
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax]
loc_439A00:
    movq    xmm0, qword ptr [rdx+rbp]
    movq    xmm1, qword ptr [rdx+rbp-8]
    movq    xmm2, qword ptr [rbx+rbp]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rbx+rbp-8]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rbp], xmm0
    movq    qword ptr [rdx+rbp-8], xmm1
    movq    xmm0, qword ptr [rdx+rbp-10h]
    movq    xmm1, qword ptr [rdx+rbp-18h]
    movq    xmm2, qword ptr [rbx+rbp-10h]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rbx+rbp-18h]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rbp-10h], xmm0
    movq    qword ptr [rdx+rbp-18h], xmm1
    add     rbp, 0FFFFFFFFFFFFFFE0h
    add     rsi, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_439A00
    neg     rbp
    test    r12, r12
    jz      short loc_439A9B
loc_439A67:
    mov     rdx, cp
    sub     rdx, rbp
    movq    xmm0, qword ptr [rdx+stride-7]
    movq    xmm1, qword ptr [rdx+stride-0Fh]
    movq    xmm2, qword ptr [rdx-7]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rdx-0Fh]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+stride-7], xmm0
    movq    qword ptr [rdx+stride-0Fh], xmm1
loc_439A9B:
    add     cp, r9
    mov     rdx, r8
    cmp     i, rdi
    jz      loc_439980; jumptable 00000000004399BE case 4
    nop     word ptr [rax+rax+00h]
loc_439AB0:
    movzx   ebx, byte ptr [cp]
    sub     [cp+stride], bl
    add     cp, 0FFFFFFFFFFFFFFFFh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439AB0
    jmp     loc_439980; jumptable 00000000004399BE case 4
loc_439AC7:
    xor     ebp, ebp
    test    r12, r12
    jnz     short loc_439A67
    jmp     short loc_439A9B
loc_439AD0:
    xor     eax, eax
loc_439AD2:
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     stride
    pop     r14
    pop     r15
    pop     rbp
    retn
fpDiff endp



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



PredictorDecodeTile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r13, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_438BB3
    mov     rax, [sp_0+48h]
    test    rax, rax
    jz      loc_438BCC
    mov     r14, occ0
    mov     rbx, op0
    mov     r15, tif
    movzx   ecx, cx
    call    rax
    xor     r12d, r12d
    test    eax, eax
    jz      short loc_438BA1
    mov     rbp, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_438BE5
    mov     rcx, [sp_0+50h]
    test    rcx, rcx
    jz      loc_438BFE
    test    occ0, occ0
    jle     short loc_438B9B
    mov     rdi, tif
    mov     rsi, op0
    mov     rdx, rowsize
    call    rcx
    test    eax, eax
    jz      short loc_438BA1
    add     op0, rowsize
    xchg    ax, ax
loc_438B80:
    sub     occ0, rowsize
    jle     short loc_438B9B
    mov     rsi, rbx
    add     rbx, rowsize
    mov     rdi, tif
    mov     rdx, rowsize
    call    qword ptr [sp_0+50h]
    test    eax, eax
    jnz     short loc_438B80
    jmp     short loc_438BA1
loc_438B9B:
    mov     r12d, 1
loc_438BA1:
    mov     eax, r12d
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     sp_0
    pop     r14
    pop     tif
    pop     rbp
    retn
loc_438BB3:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F7h; line
    call    ___assert_fail
loc_438BCC:
    mov     edi, offset aSpDecodetileNu; "sp->decodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F8h; line
    call    ___assert_fail
loc_438BE5:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1FCh; line
    call    ___assert_fail
loc_438BFE:
    mov     edi, offset aSpDecodepfuncN; "sp->decodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 20Ah; line
    call    ___assert_fail
PredictorDecodeTile endp



horDiff32 proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     rax, [tif+3F0h]
    mov     sp_0, [sp_0+8]
    mov     rcx, cc
    sar     rcx, 3Fh
    shr     rcx, 3Eh
    add     rcx, cc
    sar     rcx, 2
    sub     wc, stride
    jle     loc_43956D
    lea     cc, [wp+wc*4]
    add     rdx, 0FFFFFFFFFFFFFFFCh
    lea     r13, [stride-4]
    lea     r9, [stride-0Ch]
    shr     r9, 3
    lea     r8, [r9+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF8h
    mov     r10, i
    sub     r10, r12
    mov     r11, r12
    neg     r11
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride-3]
    cmp     stride, 4
    jbe     short loc_439473
    jmp     short def_439473; jumptable 0000000000439473 default case
loc_439440:
    mov     esi, [wp]; jumptable 0000000000439473 case 4
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 3
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 2
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 0000000000439473 case 1
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    sub     wc, stride; jumptable 0000000000439473 case 0
    jle     loc_43956D
    cmp     stride, 4; switch 5 cases
    ja      short def_439473; jumptable 0000000000439473 default case
def_439473:
    jmp     ds:jpt_439473[stride*8]; switch jump
    test    i, i; jumptable 0000000000439473 default case
    jle     short loc_439440; jumptable 0000000000439473 case 4
    cmp     i, 8
    jnb     short loc_43948D
    mov     cp0, i
    jmp     loc_439550
loc_43948D:
    test    r9, r9
    jz      loc_439564
    lea     tif, [wp+r14*4]
    xor     ebx, ebx
    mov     cp0, r8
    nop
loc_4394A0:
    movdqu  xmm0, xmmword ptr [wp+rbx*4-1Ch]
    movdqu  xmm1, xmmword ptr [wp+rbx*4-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+rbx*4-30h]
    movdqu  xmm3, xmmword ptr [rdi+rbx*4-20h]
    movdqu  xmm4, xmmword ptr [rdi+rbx*4-10h]
    psubd   xmm4, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rbx*4]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+rbx*4], xmm0
    movdqu  xmmword ptr [rdi+rbx*4-10h], xmm4
    movdqu  xmm0, xmmword ptr [wp+rbx*4-3Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rbx*4-2Ch]
    psubd   xmm3, xmm0
    movdqu  xmmword ptr [rdi+rbx*4-20h], xmm3
    movdqu  xmmword ptr [rdi+rbx*4-30h], xmm2
    add     rbx, 0FFFFFFFFFFFFFFF0h
    add     rsi, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4394A0
    neg     rbx
    test    r15, r15
    jz      short loc_43953C
loc_439508:
    shl     rbx, 2
    mov     rsi, wp
    sub     rsi, rbx
    movdqu  xmm0, xmmword ptr [rsi-1Ch]
    movdqu  xmm1, xmmword ptr [rsi-0Ch]
    movdqu  xmm2, xmmword ptr [rsi+stride*4-1Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rsi+stride*4-0Ch]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rsi+stride*4-0Ch], xmm0
    movdqu  xmmword ptr [rsi+stride*4-1Ch], xmm2
loc_43953C:
    lea     wp, [wp+r11*4]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439440; jumptable 0000000000439473 case 4
    nop     dword ptr [stride+00h]
loc_439550:
    mov     edi, [wp]
    sub     [wp+stride*4], edi
    add     wp, 0FFFFFFFFFFFFFFFCh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439550
    jmp     loc_439440; jumptable 0000000000439473 case 4
loc_439564:
    xor     ebx, ebx
    test    r15, r15
    jnz     short loc_439508
    jmp     short loc_43953C
loc_43956D:
    mov     eax, 1
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
horDiff32 endp



fpAcc proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r12, cc
    mov     r14, cp0
    mov     rax, [tif+3F0h]
    mov     rbp, [rax+8]
    movzx   r13d, word ptr [tif+74h]
    shr     r13, 3
    mov     rax, rdx
    cqo
    idiv    r13
    mov     rbx, rax
    mov     tif, count; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_438F89
    mov     r15, rax
    cmp     stride, count
    jge     loc_438EA1
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
    jbe     short loc_438D86
    jmp     short def_438D86; jumptable 0000000000438D86 default case
loc_438D50:
    mov     al, [cp]; jumptable 0000000000438D86 case 4
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438D86 case 3
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438D86 case 2
    add     [cp+stride], al
    add     cp, 1
    mov     al, [cp]; jumptable 0000000000438D86 case 1
    add     [cp+stride], al
    add     cp, 1
    sub     count, stride; jumptable 0000000000438D86 case 0
    cmp     count, stride
    jle     loc_438EA1
    cmp     stride, 4; switch 5 cases
    ja      short def_438D86; jumptable 0000000000438D86 default case
def_438D86:
    jmp     ds:jpt_438D86[stride*8]; switch jump
    test    i, i; jumptable 0000000000438D86 default case
    jle     short loc_438D50; jumptable 0000000000438D86 case 4
    cmp     i, 20h ; ' '
    jnb     short loc_438DA0
    mov     rdx, i
    jmp     loc_438E80
loc_438DA0:
    test    rsi, rsi
    jz      loc_438E95
    lea     r8, [cp+30h]
    lea     r9, [cp+stride]
    add     r9, 30h ; '0'
    xor     edx, edx
    mov     r10, [rsp+58h+var_50]
    nop     dword ptr [rax+00h]
loc_438DC0:
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
    jnz     short loc_438DC0
    cmp     [rsp+58h+var_48], 0
    jz      short loc_438E68
loc_438E33:
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
loc_438E68:
    mov     rax, [rsp+58h+var_38]
    add     cp, rax
    mov     rdx, [rsp+58h+var_40]
    cmp     i, rax
    jz      loc_438D50; jumptable 0000000000438D86 case 4
    xchg    ax, ax
loc_438E80:
    movzx   eax, byte ptr [cp]
    add     [cp+stride], al
    add     cp, 1
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438E80
    jmp     loc_438D50; jumptable 0000000000438D86 case 4
loc_438E95:
    xor     edx, edx
    cmp     [rsp+58h+var_48], 0
    jnz     short loc_438E33
    jmp     short loc_438E68
loc_438EA1:
    mov     rdi, tmp; d
    mov     rsi, cp0; s
    mov     rdx, cc; c
    call    _TIFFmemcpy
    test    wc, wc
    jle     loc_438F7A
    movzx   r10d, r13w
    mov     r9d, r10d
    and     r9d, 1
    lea     rdx, [cp+1]
    lea     r8d, [bps-2]
    mov     rdi, r10
    sub     rdi, r9
    xor     ebp, ebp
    test    r13w, r13w
    jnz     short loc_438EF6
    nop     dword ptr [rax+00000000h]
loc_438EE0:
    add     count, 1
    add     rdx, r10
    cmp     count, wc
    jz      loc_438F7A
    test    r13w, r13w
    jz      short loc_438EE0
loc_438EF6:
    cmp     r13w, 1
    jnz     short loc_438F10
    xor     esi, esi
    xor     ecx, ecx
    test    r9, r9
    jz      short loc_438EE0
    jmp     short loc_438F57
loc_438F10:
    mov     ecx, r8d
    xor     esi, esi
    nop     word ptr [rax+rax+00000000h]
    nop
loc_438F20:
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
    jnz     short loc_438F20
    mov     ecx, esi
    test    r9, r9
    jz      short loc_438EE0
loc_438F57:
    mov     rax, count
    imul    rax, bps
    not     ecx
    add     ecx, r13d
    imul    rcx, wc
    add     rcx, count
    mov     cl, [tmp+rcx]
    add     rax, rsi
    mov     [cp+rax], cl
    jmp     loc_438EE0
loc_438F7A:
    mov     rdi, tmp; p
    call    _TIFFfree
    mov     eax, 1
    jmp     short loc_438F8B
loc_438F89:
    xor     eax, eax
loc_438F8B:
    add     rsp, 28h
    pop     wc
    pop     cc
    pop     r13
    pop     cp0
    pop     r15
    pop     rbp
    retn
fpAcc endp



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



PredictorEncodeTile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r14, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_439713
    cmp     qword ptr [sp_0+30h], 0
    jz      loc_43972C
    cmp     qword ptr [sp_0+28h], 0
    jz      loc_439745
    mov     ebx, ecx
    mov     rbp, cc0
    mov     r15, bp0
    mov     r13, tif
    mov     rdi, rdx; s
    call    _TIFFmalloc
    test    rax, rax
    jz      short loc_4396E7
    mov     r12, rax
    mov     [rsp+48h+var_3C], ebx
    mov     rdi, rax; dest
    mov     rsi, bp0; src
    mov     rdx, cc0; n
    call    _memcpy
    mov     rbx, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_43975E
    mov     [rsp+48h+var_38], cc
    test    cc0, cc0
    jle     short loc_4396C5
    mov     cc0, working_copy
    mov     bp0, [rsp+48h+var_38]
loc_4396B0:
    mov     rdi, tif
    mov     rsi, bp_0
    mov     rdx, rowsize
    call    qword ptr [sp_0+30h]
    add     bp_0, rowsize
    sub     cc, rowsize
    jg      short loc_4396B0
loc_4396C5:
    movzx   ecx, word ptr [rsp+48h+var_3C]
    mov     rdi, tif
    mov     rsi, working_copy
    mov     rdx, [rsp+48h+var_38]
    call    qword ptr [sp_0+28h]
    mov     ebx, eax
    mov     rdi, working_copy; p
    call    _TIFFfree
    mov     eax, ebx
    jmp     short loc_439704
loc_4396E7:
    mov     rdi, [tif+458h]; fd
    mov     esi, offset PredictorEncodeTile_module; "PredictorEncodeTile"
    mov     edx, offset aOutOfMemoryAll; "Out of memory allocating %ld byte temp "...
    mov     rcx, cc0
    xor     eax, eax
    call    TIFFErrorExt
    xor     eax, eax
loc_439704:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     tif
    pop     sp_0
    pop     r15
    pop     rbp
    retn
loc_439713:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F7h; line
    call    ___assert_fail
loc_43972C:
    mov     edi, offset aSpEncodepfuncN; "sp->encodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F8h; line
    call    ___assert_fail
loc_439745:
    mov     edi, offset aSpEncodetileNu; "sp->encodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F9h; line
    call    ___assert_fail
loc_43975E:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 30Bh; line
    call    ___assert_fail
PredictorEncodeTile endp



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

