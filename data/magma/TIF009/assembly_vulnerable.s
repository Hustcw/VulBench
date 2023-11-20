TIFFWriteDirectoryTagTransferfunction proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    test    dir, dir
    jz      short loc_4182E5
    mov     r13, tif
    movzx   r12d, word ptr [rdi+74h]
    mov     r14d, 1
    mov     ecx, r12d
    shl     r14d, cl
    movzx   eax, word ptr [rdi+82h]
    sub     ax, [rdi+0D4h]
    mov     ebp, 3
    cmp     ax, 3
    cmovb   ebp, eax
    mov     [rsp+48h+var_38], dir
    mov     [rsp+48h+var_40], ndir
    jb      short loc_4182F2
    mov     rdi, [tif+158h]; p1
    mov     rsi, [tif+168h]; p2
    mov     ebx, r14d
    add     rbx, rbx
    mov     rdx, rbx; c
    call    _TIFFmemcmp
    cmp     bp, 2
    jz      short loc_4182FE
    test    eax, eax
    jnz     short loc_41831F
    jmp     short loc_4182FE
loc_4182E5:
    add     dword ptr [ndir], 1
    mov     ebx, 1
    jmp     loc_4183E4
loc_4182F2:
    cmp     bp, 2
    jnz     short loc_41831F
    mov     ebx, r14d
    add     rbx, rbx
loc_4182FE:
    mov     rdi, [tif+158h]; p1
    mov     rsi, [tif+160h]; p2
    mov     rdx, rbx; c
    call    _TIFFmemcmp
    cmp     eax, 1
    mov     bp, 2
    sbb     bp, 0
loc_41831F:
    test    bp, bp
    mov     r15d, 1
    cmovnz  r15d, ebp
    movzx   ebp, r15w
    mov     ecx, r12d
    shl     ebp, cl
    mov     rdi, rbp
    add     rdi, rbp; s
    call    _TIFFmalloc
    test    rax, rax
    jz      loc_4183CA
    mov     rbx, rax
    mov     rsi, [tif+158h]; s
    mov     r12d, r14d
    lea     rdx, [r12+r12]; c
    mov     rdi, rax; d
    mov     [rsp+48h+c], rdx
    call    _TIFFmemcpy
    cmp     r15w, 2
    jb      short loc_41839F
    lea     rdi, [o+r12*2]; d
    mov     rsi, [tif+160h]; s
    mov     rdx, [rsp+48h+c]; c
    call    _TIFFmemcpy
    cmp     r15w, 2
    jz      short loc_41839F
    add     r14d, r14d
    lea     rdi, [o+r14*2]; d
    mov     rsi, [tif+168h]; s
    mov     rdx, [rsp+48h+c]; c
    call    _TIFFmemcpy
loc_41839F:
    mov     rdi, tif; tif
    mov     rsi, [rsp+48h+var_40]; ndir
    mov     rdx, [rsp+48h+var_38]; dir
    mov     ecx, 12Dh; tag
    mov     r8d, ebp; count
    mov     r9, o; value
    call    TIFFWriteDirectoryTagCheckedShortArray
    mov     ebp, eax
    mov     rdi, o; p
    call    _TIFFfree
    mov     eax, ebp
    jmp     short loc_4183E6
loc_4183CA:
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset TIFFWriteDirectoryTagTransferfunction_module; "TIFFWriteDirectoryTagTransferfunction"
    mov     edx, offset aOutOfMemory; "Out of memory"
    xor     eax, eax
    call    TIFFErrorExt
loc_4183E4:
    mov     eax, ebx
loc_4183E6:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
TIFFWriteDirectoryTagTransferfunction endp

