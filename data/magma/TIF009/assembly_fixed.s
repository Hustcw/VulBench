TIFFWriteDirectoryTagTransferfunction proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    test    dir, dir
    jz      short loc_4184D0
    mov     r14, dir
    mov     r13, tif
    movzx   r12d, word ptr [rdi+74h]
    mov     eax, 1
    mov     ecx, r12d
    shl     eax, cl
    mov     [rsp+48h+var_48], m
    movzx   eax, word ptr [rdi+82h]
    sub     ax, [rdi+0D4h]
    mov     r15d, 3
    cmp     ax, 3
    cmovb   r15d, eax
    mov     [rsp+48h+var_38], ndir
    jb      short loc_4184DD
    mov     rsi, [tif+168h]; p2
    test    rsi, rsi
    jz      short loc_4184EA
    mov     rdi, [tif+158h]; p1
    mov     edx, dword ptr [rsp+48h+var_48]
    add     m, m; c
    call    _TIFFmemcmp
    cmp     r15w, 2
    jz      short loc_4184EA
    test    eax, eax
    jz      short loc_4184EA
    test    r15w, r15w
    jnz     short loc_418516
    jmp     short loc_418511
loc_4184D0:
    add     dword ptr [ndir], 1
    mov     ebx, 1
    jmp     loc_4185D4
loc_4184DD:
    test    r15w, r15w
    jz      short loc_418511
    cmp     r15w, 2
    jnz     short loc_418516
loc_4184EA:
    mov     rsi, [tif+160h]; p2
    test    rsi, rsi
    jz      short loc_418511
    mov     rdi, [tif+158h]; p1
    mov     edx, dword ptr [rsp+48h+var_48]
    add     ndir, ndir; c
    call    _TIFFmemcmp
    mov     r15w, 2
    test    eax, eax
    jnz     short loc_418516
loc_418511:
    mov     r15w, 1
loc_418516:
    movzx   ebp, r15w
    mov     ecx, r12d
    shl     ebp, cl
    mov     rdi, rbp
    add     rdi, rbp; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_4185BA
    mov     rbx, rax
    mov     [rsp+48h+var_40], dir
    mov     rsi, [tif+158h]; s
    mov     r14d, dword ptr [rsp+48h+var_48]
    lea     r12, [r14+r14]
    mov     rdi, rax; d
    mov     rdx, r12; c
    call    _TIFFmemcpy
    cmp     r15w, 2
    jb      short loc_41858F
    lea     rdi, [o+r14*2]; d
    mov     rsi, [tif+160h]; s
    mov     rdx, r12; c
    call    _TIFFmemcpy
    cmp     r15w, 2
    jz      short loc_41858F
    mov     rax, [rsp+48h+var_48]
    add     eax, eax
    lea     rdi, [o+rax*2]; d
    mov     rsi, [tif+168h]; s
    mov     rdx, r12; c
    call    _TIFFmemcpy
loc_41858F:
    mov     rdi, tif; tif
    mov     rsi, [rsp+48h+var_38]; ndir
    mov     rdx, [rsp+48h+var_40]; dir
    mov     ecx, 12Dh; tag
    mov     r8d, ebp; count
    mov     r9, o; value
    call    TIFFWriteDirectoryTagCheckedShortArray
    mov     ebp, eax
    mov     rdi, o; p
    call    _TIFFfree
    mov     eax, ebp
    jmp     short loc_4185D6
loc_4185BA:
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset TIFFWriteDirectoryTagTransferfunction_module; "TIFFWriteDirectoryTagTransferfunction"
    mov     edx, offset aOutOfMemory; "Out of memory"
    xor     eax, eax
    call    TIFFErrorExt
loc_4185D4:
    mov     eax, ebx
loc_4185D6:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
TIFFWriteDirectoryTagTransferfunction endp

