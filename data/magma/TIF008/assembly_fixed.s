NeXTDecode proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r12, occ
    mov     rbp, op
    mov     rbx, tif
    test    rdx, rdx
    jle     short loc_42F37C
    mov     rdi, op; s
    mov     esi, 0FFh; c
    mov     rdx, occ; n
    call    _memset
loc_42F37C:
    mov     r15, [tif+3F8h]
    mov     rax, occ
    cqo
    idiv    scanline
    test    rdx, rdx
    jz      short loc_42F3AF
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset NeXTDecode_module; "NeXTDecode"
    mov     edx, offset aFractionalScan_1; "Fractional scanlines cannot be read"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_42F60A
loc_42F3AF:
    mov     rsi, [tif+428h]
    mov     rax, [tif+430h]
    test    cc, cc
    mov     [rsp+48h+var_40], tif
    jle     loc_42F5AB
    test    r12, r12
    jle     loc_42F5AB
loc_42F3D4:
    lea     r13, [bp_0+1]
    mov     r8b, [rsi]
    lea     r14, [cc-1]
    cmp     r8b, 40h ; '@'
    jz      short loc_42F410
    test    r8b, r8b
    jnz     loc_42F490
    cmp     rax, scanline
    jle     bad
    mov     rdi, row; d
    mov     rsi, bp_0; s
    mov     rdx, scanline; c
    call    _TIFFmemcpy
    add     bp_0, scanline
    sub     cc, scanline
    jmp     short loc_42F468
loc_42F410:
    cmp     rax, 5
    jl      bad
    movzx   edx, byte ptr [rsi+3]
    shl     rdx, 8
    movzx   ecx, byte ptr [rsi+4]
    lea     rbx, [rdx+rcx]
    add     rbx, 4
    cmp     rax, rbx
    jle     bad
    movzx   eax, byte ptr [rsi+1]
    shl     rax, 8
    movzx   edi, byte ptr [rsi+2]
    or      rdi, rax
    or      rdx, rcx; c
    lea     rax, [n+off]
    cmp     rax, scanline
    jg      bad
    add     off, row; d
    add     rsi, 5; s
    call    _TIFFmemcpy
    add     bp_0, rbx
    sub     cc, rbx
loc_42F468:
    mov     rax, cc
    mov     rsi, bp_0
    test    cc, cc
    jle     loc_42F5AB
loc_42F477:
    sub     occ, scanline
    add     rbp, scanline
    test    occ, occ
    jg      loc_42F3D4
    jmp     loc_42F5AB
loc_42F490:
    mov     rcx, [rsp+48h+var_40]
    test    byte ptr [rcx+11h], 4
    mov     eax, 64h ; 'd'
    mov     edx, 58h ; 'X'
    cmovz   rax, rdx
    mov     eax, [rcx+rax]
    xor     edx, edx
    mov     [rsp+48h+var_38], row
    xor     esi, esi
    nop     word ptr [imagewidth+imagewidth+00000000h]
    nop     dword ptr [imagewidth]
loc_42F4C0:
    cmp     edx, eax
    setb    bl
    cmp     op_offset, scanline
    setl    cl
    mov     edi, r8d
    and     dil, 3Fh
    jz      loc_42F579
    cmp     edx, eax
    jnb     loc_42F579
    cmp     op_offset, scanline
    jge     loc_42F579
    mov     r9d, r8d
    shr     r9b, 6
    movzx   edi, dil
    lea     r10d, ds:0[grey*4]
    mov     r11d, r9d
    shl     r11b, 4
    and     r8b, 0C0h
    add     n, 0FFFFFFFFFFFFFFFFh
    nop     dword ptr [imagewidth+imagewidth+00h]
loc_42F510:
    mov     ecx, edx
    lea     edx, [npixels+1]
    and     ecx, 3
    jmp     ds:jpt_42F518[rcx*8]; switch 4 cases
    mov     [row+0], r8b; jumptable 000000000042F518 case 0
    jmp     short loc_42F55C
    or      [row+0], r11b; jumptable 000000000042F518 case 1
    jmp     short loc_42F55C
    or      [row+0], r10b; jumptable 000000000042F518 case 2
    jmp     short loc_42F55C
    or      [row+0], r9b; jumptable 000000000042F518 case 3
    add     row, 1
    add     op_offset, 1
loc_42F55C:
    cmp     edx, eax
    setb    bl
    cmp     op_offset, scanline
    setl    cl
    test    rdi, rdi
    jle     short loc_42F579
    cmp     edx, eax
    jnb     short loc_42F579
    add     rdi, 0FFFFFFFFFFFFFFFFh
    cmp     op_offset, scanline
    jl      short loc_42F510
loc_42F579:
    test    bl, bl
    jz      short loc_42F597
    test    cl, cl
    jz      short loc_42F5E5
    test    cc, cc
    jz      short bad
    mov     r8b, [bp_0+0]
    add     bp_0, 1
    add     cc, 0FFFFFFFFFFFFFFFFh
    jmp     loc_42F4C0
loc_42F597:
    mov     rax, cc
    mov     rsi, bp_0
    mov     op, [rsp+48h+var_38]
    test    cc, cc
    jg      loc_42F477
loc_42F5AB:
    mov     rcx, [rsp+48h+var_40]
    mov     [rcx+428h], bp_0
    mov     [rcx+430h], cc
    mov     ebx, 1
    jmp     short loc_42F60A
    mov     rax, [rsp+48h+var_40]
    mov     rdi, [rax+458h]
    mov     ecx, [rax+31Ch]
    xor     ebx, ebx
    mov     esi, offset NeXTDecode_module; "NeXTDecode"
    mov     edx, offset aNotEnoughDataF_0; "Not enough data for scanline %u"
    jmp     short loc_42F603
loc_42F5E5:
    mov     imagewidth, [rsp+48h+var_40]
    mov     rdi, [rax+458h]; fd
    mov     ecx, [rax+31Ch]
    xor     ebx, ebx
    mov     esi, offset NeXTDecode_module; "NeXTDecode"
    mov     edx, offset aInvalidDataFor; "Invalid data for scanline %u"
loc_42F603:
    xor     eax, eax
    call    TIFFErrorExt
loc_42F60A:
    mov     eax, ebx
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     scanline
    pop     rbp
    retn
NeXTDecode endp

