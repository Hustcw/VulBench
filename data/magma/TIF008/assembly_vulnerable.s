NeXTDecode proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r13, occ
    mov     rbp, op
    mov     rbx, tif
    test    rdx, rdx
    jle     short loc_42F19C
    mov     rdi, op; s
    mov     esi, 0FFh; c
    mov     rdx, occ; n
    call    _memset
loc_42F19C:
    mov     rcx, [tif+3F8h]
    mov     rax, occ
    cqo
    idiv    scanline
    test    rdx, rdx
    jz      short loc_42F1CF
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset NeXTDecode_module; "NeXTDecode"
    mov     edx, offset aFractionalScan_1; "Fractional scanlines cannot be read"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_42F41B
loc_42F1CF:
    mov     rsi, [tif+428h]
    mov     rax, [tif+430h]
    test    cc, cc
    mov     [rsp+48h+var_38], tif
    jle     loc_42F3DC
    test    r13, r13
    jle     loc_42F3DC
    mov     [rsp+48h+c], scanline
    jmp     short loc_42F227
loc_42F200:
    mov     rax, r12
    mov     rsi, bp_0
    mov     rcx, [rsp+48h+c]
    test    cc, cc
    jle     loc_42F3DC
loc_42F213:
    sub     occ, rcx
    mov     rbp, [rsp+48h+d]
    add     rbp, rcx
    test    occ, occ
    jle     loc_42F3DC
loc_42F227:
    mov     [rsp+48h+d], row
    lea     r14, [bp_0+1]
    mov     r10b, [rsi]
    lea     r12, [cc-1]
    cmp     r10b, 40h ; '@'
    jz      short loc_42F280
    test    r10b, r10b
    jnz     loc_42F2E0
    cmp     rax, scanline
    jle     bad
    mov     rdi, [rsp+48h+d]; d
    mov     rsi, bp_0; s
    mov     rbx, [rsp+48h+c]
    mov     rdx, row; c
    call    _TIFFmemcpy
    mov     rcx, row
    add     bp_0, row
    sub     cc, row
    mov     rax, cc
    mov     rsi, bp_0
    test    cc, cc
    jg      short loc_42F213
    jmp     loc_42F3DC
loc_42F280:
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
    cmp     rax, [rsp+48h+c]
    jg      bad
    add     off, [rsp+48h+d]; d
    add     rsi, 5; s
    call    _TIFFmemcpy
    add     bp_0, rbx
    sub     cc, rbx
    jmp     loc_42F200
loc_42F2E0:
    mov     scanline, [rsp+48h+var_38]
    test    byte ptr [rcx+11h], 4
    mov     eax, 64h ; 'd'
    mov     edx, 58h ; 'X'
    cmovz   rax, rdx
    mov     eax, [rcx+rax]
    xor     ecx, ecx
    mov     rsi, [rsp+48h+d]
    nop     word ptr [imagewidth+imagewidth+00000000h]
    nop     dword ptr [imagewidth+imagewidth+00h]
loc_42F310:
    cmp     ecx, eax
    setb    dl
    mov     ebx, r10d
    and     bl, 3Fh
    jz      loc_42F3D0
    cmp     ecx, eax
    jnb     loc_42F3D0
    mov     r9d, r10d
    shr     r9b, 6
    movzx   ebp, bl
    lea     r8d, ds:0[grey*4]
    mov     r11d, r9d
    shl     r11b, 4
    and     r10b, 0C0h
    add     n, 0FFFFFFFFFFFFFFFFh
    mov     rdi, op
    nop     dword ptr [imagewidth]
loc_42F350:
    mov     r15d, ecx
    lea     ecx, [npixels+1]
    and     r15d, 3
    mov     edx, r11d
    mov     ebx, r10d
    jmp     ds:jpt_42F361[r15*8]; switch 4 cases
    mov     edx, r8d; jumptable 000000000042F361 case 2
    mov     rdi, op
    jmp     short loc_42F387; jumptable 000000000042F361 case 1
    lea     rdi, [op+1]; jumptable 000000000042F361 case 3
    mov     edx, r9d
loc_42F387:
    or      dl, [rsi]; jumptable 000000000042F361 case 1
    mov     ebx, edx
    mov     [rsi], bl; jumptable 000000000042F361 case 0
    cmp     ecx, eax
    setb    dl
    test    rbp, rbp
    jle     short loc_42F3A2
    add     rbp, 0FFFFFFFFFFFFFFFFh
    mov     rsi, op
    cmp     ecx, eax
    jb      short loc_42F350
loc_42F3A2:
    test    dl, dl
    jz      loc_42F200
loc_42F3AA:
    test    cc, cc
    jz      short bad
    mov     r10b, [bp_0]
    add     bp_0, 1
    add     cc, 0FFFFFFFFFFFFFFFFh
    mov     rsi, op
    jmp     loc_42F310
loc_42F3D0:
    mov     rdi, op
    test    dl, dl
    jnz     short loc_42F3AA
    jmp     loc_42F200
loc_42F3DC:
    mov     rcx, [rsp+48h+var_38]
    mov     [rcx+428h], bp_0
    mov     [rcx+430h], cc
    mov     ebx, 1
    jmp     short loc_42F41B
    mov     rax, [rsp+48h+var_38]
    mov     rdi, [rax+458h]; fd
    mov     ecx, [rax+31Ch]
    xor     ebx, ebx
    mov     esi, offset NeXTDecode_module; "NeXTDecode"
    mov     edx, offset aNotEnoughDataF_0; "Not enough data for scanline %u"
    xor     eax, eax
    call    TIFFErrorExt
loc_42F41B:
    mov     eax, ebx
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
NeXTDecode endp

