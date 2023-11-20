horDiff16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [sp_0+8]
    lea     r13, [stride+stride]
    mov     sp_0, rdx
    cqo
    idiv    r13
    test    rdx, rdx
    jz      short loc_4395EF
    mov     tif, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aHordiff8; "horDiff8"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset asc_4696AB; "("
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43978F
loc_4395EF:
    mov     rax, cc
    shr     rax, 3Fh
    add     rax, cc
    sar     rax, 1
    mov     r14d, 1
    sub     wc, stride
    jle     loc_43978F
    lea     cc, [cp0+wc*2]
    add     rcx, 0FFFFFFFFFFFFFFFEh
    lea     rdx, [stride-4]
    lea     r11, [stride-14h]
    shr     r11, 4
    lea     cp0, [r11+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF0h
    mov     r10, i
    sub     r10, r12
    mov     r9, r12
    neg     r9
    mov     r15d, esi
    and     r15d, 1
    sub     rsi, r15
    mov     [rsp+38h+var_38], rsi
    cmp     stride, 4
    jbe     short loc_43968B
    jmp     short def_43968B; jumptable 000000000043968B default case
loc_439650:
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 4
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 3
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 2
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    movzx   esi, word ptr [wp]; jumptable 000000000043968B case 1
    sub     [wp+stride*2], si
    add     wp, 0FFFFFFFFFFFFFFFEh
    sub     wc, stride; jumptable 000000000043968B case 0
    jle     loc_43978F
    cmp     stride, 4; switch 5 cases
    ja      short def_43968B; jumptable 000000000043968B default case
def_43968B:
    jmp     ds:jpt_43968B[stride*8]; switch jump
    test    i, i; jumptable 000000000043968B default case
    jle     short loc_439650; jumptable 000000000043968B case 4
    cmp     i, 10h
    jnb     short loc_4396A5
    mov     rsi, i
    jmp     loc_439770
loc_4396A5:
    test    r11, r11
    jz      loc_439786
    lea     tif, [wp-0Eh]
    lea     rbp, [wp+r13]
    add     rbp, 0FFFFFFFFFFFFFFF2h
    xor     esi, esi
    mov     r8, [rsp+38h+var_38]
loc_4396C0:
    movdqu  xmm0, xmmword ptr [rbp+rsi*2-30h]
    movdqu  xmm1, xmmword ptr [rbp+rsi*2-20h]
    movdqu  xmm2, xmmword ptr [rbp+rsi*2-10h]
    movdqu  xmm3, xmmword ptr [rbp+rsi*2+0]
    movdqu  xmm4, xmmword ptr [rdi+rsi*2-10h]
    psubw   xmm2, xmm4
    movdqu  xmm4, xmmword ptr [rdi+rsi*2]
    psubw   xmm3, xmm4
    movdqu  xmmword ptr [rbp+rsi*2+0], xmm3
    movdqu  xmmword ptr [rbp+rsi*2-10h], xmm2
    movdqu  xmm2, xmmword ptr [rdi+rsi*2-30h]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi+rsi*2-20h]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rbp+rsi*2-20h], xmm1
    movdqu  xmmword ptr [rbp+rsi*2-30h], xmm0
    add     rsi, 0FFFFFFFFFFFFFFE0h
    add     r8, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4396C0
    neg     rsi
    test    r15, r15
    jz      short loc_43975C
loc_439729:
    add     rsi, rsi
    mov     rdi, wp
    sub     rdi, rsi
    movdqu  xmm0, xmmword ptr [rdi+stride*2-1Eh]
    movdqu  xmm1, xmmword ptr [rdi+stride*2-0Eh]
    movdqu  xmm2, xmmword ptr [rdi-1Eh]
    psubw   xmm0, xmm2
    movdqu  xmm2, xmmword ptr [rdi-0Eh]
    psubw   xmm1, xmm2
    movdqu  xmmword ptr [rdi+stride*2-0Eh], xmm1
    movdqu  xmmword ptr [rdi+stride*2-1Eh], xmm0
loc_43975C:
    lea     wp, [wp+r9*2]
    mov     rsi, r10
    cmp     i, r12
    jz      loc_439650; jumptable 000000000043968B case 4
    nop     dword ptr [wc+00h]
loc_439770:
    movzx   edi, word ptr [wp]
    sub     [wp+stride*2], di
    add     wp, 0FFFFFFFFFFFFFFFEh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439770
    jmp     loc_439650; jumptable 000000000043968B case 4
loc_439786:
    xor     esi, esi
    test    r15, r15
    jnz     short loc_439729
    jmp     short loc_43975C
loc_43978F:
    mov     eax, r14d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
horDiff16 endp



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
    jz      loc_438EE3
    mov     rax, [sp_0+48h]
    test    rax, rax
    jz      loc_438EFC
    mov     rbx, occ0
    mov     rbp, op0
    mov     r15, tif
    movzx   ecx, cx
    call    rax
    xor     r14d, r14d
    test    eax, eax
    jz      loc_438ED1
    mov     r12, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_438F15
    mov     rax, occ0
    cqo
    idiv    rowsize
    test    rdx, rdx
    jz      short loc_438E7D
    mov     rdi, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aPredictordecod; "PredictorDecodeTile"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aOcc0Rowsize0; "occ0%rowsize != 0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_438ED1
loc_438E7D:
    mov     rcx, [sp_0+50h]
    test    rcx, rcx
    jz      loc_438F2E
    test    occ0, occ0
    jle     short loc_438ECB
    mov     rdi, tif
    mov     rsi, op0
    mov     rdx, rowsize
    call    rcx
    test    eax, eax
    jz      short loc_438ED1
    add     op0, rowsize
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_438EB0:
    sub     occ0, rowsize
    jle     short loc_438ECB
    mov     rsi, rbp
    add     rbp, rowsize
    mov     rdi, tif
    mov     rdx, rowsize
    call    qword ptr [sp_0+50h]
    test    eax, eax
    jnz     short loc_438EB0
    jmp     short loc_438ED1
loc_438ECB:
    mov     r14d, 1
loc_438ED1:
    mov     eax, r14d
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     sp_0
    pop     r14
    pop     tif
    pop     rbp
    retn
loc_438EE3:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F7h; line
    call    ___assert_fail
loc_438EFC:
    mov     edi, offset aSpDecodetileNu; "sp->decodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F8h; line
    call    ___assert_fail
loc_438F15:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1FCh; line
    call    ___assert_fail
loc_438F2E:
    mov     edi, offset aSpDecodepfuncN; "sp->decodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 20Ah; line
    call    ___assert_fail
PredictorDecodeTile endp



horDiff32 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [sp_0+8]
    lea     rbp, ds:0[stride*4]
    mov     sp_0, rdx
    cqo
    idiv    rbp
    test    rdx, rdx
    jz      short loc_439803
    mov     tif, [tif+458h]; fd
    xor     r13d, r13d
    mov     esi, offset aHordiff32; "horDiff32"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset asc_4696C8; "("
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_43999D
loc_439803:
    mov     rax, cc
    sar     rax, 3Fh
    shr     rax, 3Eh
    add     rax, cc
    sar     rax, 2
    mov     r13d, 1
    sub     wc, stride
    jle     loc_43999D
    lea     cc, [cp0+wc*4]
    add     rcx, 0FFFFFFFFFFFFFFFCh
    lea     rdx, [stride-4]
    lea     r11, [stride-0Ch]
    shr     r11, 3
    lea     r8, [r11+1]
    mov     r12, i
    and     r12, 0FFFFFFFFFFFFFFF8h
    mov     r9, i
    sub     r9, r12
    mov     r10, r12
    neg     r10
    mov     r15d, r8d
    and     r15d, 1
    sub     r8, r15
    lea     r14, [stride-3]
    cmp     stride, 4
    jbe     short loc_4398A3
    jmp     short def_4398A3; jumptable 00000000004398A3 default case
loc_439870:
    mov     esi, [wp]; jumptable 00000000004398A3 case 4
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 3
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 2
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    mov     esi, [wp]; jumptable 00000000004398A3 case 1
    sub     [wp+stride*4], esi
    add     wp, 0FFFFFFFFFFFFFFFCh
    sub     wc, stride; jumptable 00000000004398A3 case 0
    jle     loc_43999D
    cmp     stride, 4; switch 5 cases
    ja      short def_4398A3; jumptable 00000000004398A3 default case
def_4398A3:
    jmp     ds:jpt_4398A3[stride*8]; switch jump
    test    i, i; jumptable 00000000004398A3 default case
    jle     short loc_439870; jumptable 00000000004398A3 case 4
    cmp     i, 8
    jnb     short loc_4398BD
    mov     cp0, i
    jmp     loc_439980
loc_4398BD:
    test    r11, r11
    jz      loc_439994
    lea     tif, [wp+r14*4]
    xor     esi, esi
    mov     rbp, r8
    nop
loc_4398D0:
    movdqu  xmm0, xmmword ptr [wp+rsi*4-1Ch]
    movdqu  xmm1, xmmword ptr [wp+rsi*4-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+rsi*4-30h]
    movdqu  xmm3, xmmword ptr [rdi+rsi*4-20h]
    movdqu  xmm4, xmmword ptr [rdi+rsi*4-10h]
    psubd   xmm4, xmm0
    movdqu  xmm0, xmmword ptr [rdi+rsi*4]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+rsi*4], xmm0
    movdqu  xmmword ptr [rdi+rsi*4-10h], xmm4
    movdqu  xmm0, xmmword ptr [wp+rsi*4-3Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rsi*4-2Ch]
    psubd   xmm3, xmm0
    movdqu  xmmword ptr [rdi+rsi*4-20h], xmm3
    movdqu  xmmword ptr [rdi+rsi*4-30h], xmm2
    add     rsi, 0FFFFFFFFFFFFFFF0h
    add     rbp, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_4398D0
    neg     rsi
    test    r15, r15
    jz      short loc_43996C
loc_439938:
    shl     rsi, 2
    mov     rdi, wp
    sub     rdi, rsi
    movdqu  xmm0, xmmword ptr [rdi-1Ch]
    movdqu  xmm1, xmmword ptr [rdi-0Ch]
    movdqu  xmm2, xmmword ptr [rdi+stride*4-1Ch]
    psubd   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rdi+stride*4-0Ch]
    psubd   xmm0, xmm1
    movdqu  xmmword ptr [rdi+stride*4-0Ch], xmm0
    movdqu  xmmword ptr [rdi+stride*4-1Ch], xmm2
loc_43996C:
    lea     wp, [wp+r10*4]
    mov     rsi, r9
    cmp     i, r12
    jz      loc_439870; jumptable 00000000004398A3 case 4
    nop     dword ptr [wc+00h]
loc_439980:
    mov     edi, [wp]
    sub     [wp+stride*4], edi
    add     wp, 0FFFFFFFFFFFFFFFCh
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_439980
    jmp     loc_439870; jumptable 00000000004398A3 case 4
loc_439994:
    xor     esi, esi
    test    r15, r15
    jnz     short loc_439938
    jmp     short loc_43996C
loc_43999D:
    mov     eax, r13d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
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



horAcc16 proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rcx, cc
    mov     rax, [tif+3F0h]
    mov     rbx, [rax+8]
    lea     r12, [stride+stride]
    mov     rax, rdx
    cqo
    idiv    r12
    test    rdx, rdx
    jz      short loc_4389AF
    mov     tif, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aHoracc16; "horAcc16"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCc2Stride0; "cc%(2*stride))!=0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_438B3F
loc_4389AF:
    mov     rax, cc
    shr     rax, 3Fh
    add     rax, cc
    sar     rax, 1
    mov     r14d, 1
    sub     wc, stride
    jle     loc_438B3F
    lea     r13, [stride-4]
    lea     r10, [stride-14h]
    shr     r10, 4
    lea     r8, [r10+1]
    mov     r15, i
    and     r15, 0FFFFFFFFFFFFFFF0h
    mov     r9, i
    sub     r9, r15
    mov     r11d, r8d
    and     r11d, 1
    sub     r8, r11
    cmp     stride, 4
    jbe     short loc_438A3B
    jmp     short def_438A3B; jumptable 0000000000438A3B default case
loc_438A00:
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 4
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 3
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 2
    add     [wp+stride*2], cx
    add     wp, 2
    movzx   ecx, word ptr [wp]; jumptable 0000000000438A3B case 1
    add     [wp+stride*2], cx
    add     wp, 2
    sub     wc, stride; jumptable 0000000000438A3B case 0
    jle     loc_438B3F
    cmp     stride, 4; switch 5 cases
    ja      short def_438A3B; jumptable 0000000000438A3B default case
def_438A3B:
    jmp     ds:jpt_438A3B[stride*8]; switch jump
    test    i, i; jumptable 0000000000438A3B default case
    jle     short loc_438A00; jumptable 0000000000438A3B case 4
    cmp     i, 10h
    jnb     short loc_438A55
    mov     cc, i
    jmp     loc_438B20
loc_438A55:
    test    r10, r10
    jz      loc_438B36
    lea     tif, [wp+30h]
    lea     rbp, [wp+r12]
    add     rbp, 30h ; '0'
    xor     edx, edx
    mov     cc, r8
    nop
loc_438A70:
    movdqu  xmm0, xmmword ptr [rdi+rdx*2-30h]
    movdqu  xmm1, xmmword ptr [rdi+rdx*2-20h]
    movdqu  xmm2, xmmword ptr [rbp+rdx*2-30h]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [rbp+rdx*2-20h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rbp+rdx*2-10h]
    movdqu  xmm3, xmmword ptr [rbp+rdx*2+0]
    movdqu  xmmword ptr [rbp+rdx*2-30h], xmm2
    movdqu  xmmword ptr [rbp+rdx*2-20h], xmm0
    movdqu  xmm0, xmmword ptr [rdi+rdx*2-10h]
    paddw   xmm0, xmm1
    movdqu  xmm1, xmmword ptr [rdi+rdx*2]
    paddw   xmm1, xmm3
    movdqu  xmmword ptr [rbp+rdx*2-10h], xmm0
    movdqu  xmmword ptr [rbp+rdx*2+0], xmm1
    add     rdx, 20h ; ' '
    add     rcx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_438A70
    test    r11, r11
    jz      short loc_438B03
loc_438AD6:
    lea     rcx, [wp+rdx*2]
    movdqu  xmm0, xmmword ptr [rcx+stride*2]
    movdqu  xmm1, xmmword ptr [rcx+stride*2+10h]
    movdqu  xmm2, xmmword ptr [wp+rdx*2]
    paddw   xmm2, xmm0
    movdqu  xmm0, xmmword ptr [wp+rdx*2+10h]
    paddw   xmm0, xmm1
    movdqu  xmmword ptr [rcx+stride*2], xmm2
    movdqu  xmmword ptr [rcx+stride*2+10h], xmm0
loc_438B03:
    lea     wp, [wp+r15*2]
    mov     rcx, r9
    cmp     i, r15
    jz      loc_438A00; jumptable 0000000000438A3B case 4
    nop     word ptr [wc+wc+00000000h]
    nop     dword ptr [wc]
loc_438B20:
    movzx   edx, word ptr [wp]
    add     [wp+stride*2], dx
    add     wp, 2
    add     i, 0FFFFFFFFFFFFFFFFh
    jg      short loc_438B20
    jmp     loc_438A00; jumptable 0000000000438A3B case 4
loc_438B36:
    xor     edx, edx
    test    r11, r11
    jnz     short loc_438AD6
    jmp     short loc_438B03
loc_438B3F:
    mov     eax, r14d
    add     rsp, 8
    pop     stride
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
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
    mov     r12, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_439B89
    cmp     qword ptr [sp_0+30h], 0
    jz      loc_439BA2
    cmp     qword ptr [sp_0+28h], 0
    jz      loc_439BBB
    mov     ebp, ecx
    mov     r14, cc0
    mov     r15, bp0
    mov     r13, tif
    mov     rdi, rdx; s
    call    _TIFFmalloc
    test    rax, rax
    jz      short loc_439B05
    mov     rbx, rax
    mov     [rsp+48h+var_3C], ebp
    mov     rdi, rax; dest
    mov     rsi, bp0; src
    mov     rdx, cc0; n
    call    _memcpy
    mov     rbp, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_439BD4
    mov     rax, cc0
    cqo
    idiv    rowsize
    test    rdx, rdx
    jz      short loc_439B24
    mov     rdi, [tif+458h]; fd
    mov     esi, offset aPredictorencod; "PredictorEncodeTile"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCc0Rowsize0; "(cc0%rowsize)!=0"
    xor     eax, eax
    call    TIFFErrorExt
    mov     rdi, working_copy; p
    call    _TIFFfree
    jmp     short loc_439B20
loc_439B05:
    mov     rdi, [tif+458h]; fd
    mov     esi, offset aPredictorencod; "PredictorEncodeTile"
    mov     edx, offset aOutOfMemoryAll; "Out of memory allocating %ld byte temp "...
    mov     rcx, cc0
    xor     eax, eax
    call    TIFFErrorExt
loc_439B20:
    xor     eax, eax
    jmp     short loc_439B7A
loc_439B24:
    mov     [rsp+48h+p], working_copy
    test    cc, cc
    jle     short loc_439B56
    mov     working_copy, [rsp+48h+p]
    mov     bp0, cc
    nop     word ptr [rax+rax+00000000h]
loc_439B40:
    mov     rdi, tif
    mov     rsi, bp_0
    mov     rdx, rowsize
    call    qword ptr [sp_0+30h]
    add     bp_0, rowsize
    sub     cc, rowsize
    jg      short loc_439B40
loc_439B56:
    movzx   ecx, word ptr [rsp+48h+var_3C]
    mov     rdi, tif
    mov     rowsize, [rsp+48h+p]
    mov     rsi, rbp
    mov     rdx, cc0
    call    qword ptr [sp_0+28h]
    mov     ebx, eax
    mov     rdi, rbp; p
    call    _TIFFfree
    mov     eax, ebx
loc_439B7A:
    add     rsp, 18h
    pop     rbx
    pop     sp_0
    pop     tif
    pop     cc0
    pop     r15
    pop     rbp
    retn
loc_439B89:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F7h; line
    call    ___assert_fail
loc_439BA2:
    mov     edi, offset aSpEncodepfuncN; "sp->encodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F8h; line
    call    ___assert_fail
loc_439BBB:
    mov     edi, offset aSpEncodetileNu; "sp->encodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F9h; line
    call    ___assert_fail
loc_439BD4:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 30Bh; line
    call    ___assert_fail
PredictorEncodeTile endp



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

