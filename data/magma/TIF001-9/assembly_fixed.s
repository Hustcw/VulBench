fpDiff proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r14, cc
    mov     rax, [tif+3F0h]
    mov     r12, [rax+8]
    movzx   r13d, word ptr [tif+74h]
    shr     r13, 3
    mov     rax, rdx
    cqo
    idiv    r13
    mov     rbp, rax
    mov     rcx, stride
    imul    rcx, r13
    mov     rax, cc
    cqo
    idiv    rcx
    test    rdx, rdx
    jz      short loc_439CE1
    mov     tif, [tif+458h]; fd
    xor     ebp, ebp
    mov     esi, offset aFpdiff; "fpDiff"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset asc_4697E4; "("
    xor     eax, eax
    call    TIFFErrorExt
loc_439CD0:
    mov     eax, ebp
    add     rsp, 8
    pop     rbx
    pop     stride
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_439CE1:
    mov     r15, cp0
    mov     tif, cc; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_439F90
    mov     rbx, rax
    mov     rdi, rax; d
    mov     rsi, cp0; s
    mov     rdx, cc; c
    call    _TIFFmemcpy
    test    wc, wc
    jle     loc_439DDC
    movzx   r10d, r13w
    mov     r9d, r10d
    and     r9d, 1
    mov     rdx, tmp
    add     rdx, 1
    lea     eax, [bps-2]
    mov     [rsp+38h+var_34], eax
    mov     r11, r10
    sub     r11, r9
    xor     esi, esi
    test    r13w, r13w
    jnz     short loc_439D56
    nop     word ptr [rax+rax+00000000h]
loc_439D40:
    add     count, 1
    add     rdx, r10
    cmp     count, wc
    jz      loc_439DDC
    test    r13w, r13w
    jz      short loc_439D40
loc_439D56:
    cmp     r13w, 1
    jnz     short loc_439D70
    xor     ecx, ecx
    xor     eax, eax
    test    r9, r9
    jz      short loc_439D40
    jmp     short loc_439DBA
loc_439D70:
    mov     r8, tmp
    mov     eax, [rsp+38h+var_34]
    xor     ecx, ecx
    nop     dword ptr [rax+00000000h]
loc_439D80:
    movzx   ebx, byte ptr [rdx+byte-1]
    lea     edi, [rax+1]
    imul    rdi, wc
    add     rdi, count
    mov     [cp0+rdi], bl
    movzx   ebx, byte ptr [rdx+rcx]
    mov     edi, eax
    imul    rdi, wc
    add     rdi, count
    mov     [cp0+rdi], bl
    add     rcx, 2
    add     eax, 0FFFFFFFEh
    cmp     r11, rcx
    jnz     short loc_439D80
    mov     eax, ecx
    mov     rbx, r8
    test    r9, r9
    jz      short loc_439D40
loc_439DBA:
    mov     rdi, count
    imul    rdi, bps
    add     rdi, rcx
    mov     cl, [rbx+rdi]
    not     eax
    add     eax, r13d
    imul    rax, wc
    add     rax, count
    mov     [cp0+rax], cl
    jmp     loc_439D40
loc_439DDC:
    mov     rdi, tmp; p
    call    _TIFFfree
    mov     ebp, 1
    cmp     stride, count
    jge     loc_439CD0
    mov     rax, stride
    not     rax
    add     rax, count
    add     cp0, rax
    lea     rax, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     r10, [r11+1]
    mov     r13, i
    and     r13, 0FFFFFFFFFFFFFFF0h
    mov     r8, i
    sub     r8, r13
    mov     r9, r13
    neg     r9
    mov     ebx, r10d
    and     ebx, 1
    sub     r10, rbx
    cmp     stride, 4
    jbe     short loc_439E7E
    jmp     short def_439E7E; jumptable 0000000000439E7E default case
loc_439E40:
    mov     cl, [cp]; jumptable 0000000000439E7E case 4
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439E7E case 3
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439E7E case 2
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    mov     cl, [cp]; jumptable 0000000000439E7E case 1
    sub     [cp+stride], cl
    add     cp, 0FFFFFFFFFFFFFFFFh
    sub     count, stride; jumptable 0000000000439E7E case 0
    cmp     count, stride
    jle     loc_439CD0
    cmp     stride, 4; switch 5 cases
    ja      short def_439E7E; jumptable 0000000000439E7E default case
def_439E7E:
    jmp     ds:jpt_439E7E[stride*8]; switch jump
    test    i, i; jumptable 0000000000439E7E default case
    jle     short loc_439E40; jumptable 0000000000439E7E case 4
    cmp     i, 10h
    jnb     short loc_439E99
    mov     rcx, i
    jmp     loc_439F70
loc_439E99:
    test    r11, r11
    jz      loc_439F87
    lea     rcx, [cp-7]
    lea     rdx, [cp+stride]
    add     rdx, 0FFFFFFFFFFFFFFF9h
    xor     edi, edi
    mov     rsi, r10
    nop     word ptr [i+i+00000000h]
    nop     dword ptr [i]
loc_439EC0:
    movq    xmm0, qword ptr [rdx+rdi]
    movq    xmm1, qword ptr [rdx+rdi-8]
    movq    xmm2, qword ptr [rcx+rdi]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rcx+rdi-8]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rdi], xmm0
    movq    qword ptr [rdx+rdi-8], xmm1
    movq    xmm0, qword ptr [rdx+rdi-10h]
    movq    xmm1, qword ptr [rdx+rdi-18h]
    movq    xmm2, qword ptr [rcx+rdi-10h]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rcx+rdi-18h]
    psubb   xmm1, xmm2
    movq    qword ptr [rdx+rdi-10h], xmm0
    movq    qword ptr [rdx+rdi-18h], xmm1
    add     rdi, 0FFFFFFFFFFFFFFE0h
    add     rsi, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_439EC0
    neg     rdi
    test    rbx, rbx
    jz      short loc_439F5B
loc_439F27:
    mov     rcx, cp
    sub     rcx, rdi
    movq    xmm0, qword ptr [rcx+stride-7]
    movq    xmm1, qword ptr [rcx+stride-0Fh]
    movq    xmm2, qword ptr [rcx-7]
    psubb   xmm0, xmm2
    movq    xmm2, qword ptr [rcx-0Fh]
    psubb   xmm1, xmm2
    movq    qword ptr [rcx+stride-7], xmm0
    movq    qword ptr [rcx+stride-0Fh], xmm1
loc_439F5B:
    add     cp, r9
    mov     rcx, r8
    cmp     i, r13
    jz      loc_439E40; jumptable 0000000000439E7E case 4
    nop     word ptr [rax+rax+00h]
loc_439F70:
    movzx   edx, byte ptr [cp]
    sub     [cp+stride], dl
    add     cp, 0FFFFFFFFFFFFFFFFh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439F70
    jmp     loc_439E40; jumptable 0000000000439E7E case 4
loc_439F87:
    xor     edi, edi
    test    rbx, rbx
    jnz     short loc_439F27
    jmp     short loc_439F5B
loc_439F90:
    xor     ebp, ebp
    jmp     loc_439CD0
fpDiff endp

