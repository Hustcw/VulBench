psf_fwrite proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r12, psf
    mov     rbx, items
    mov     r14, bytes
    cmp     dword ptr [rcx+1F30h], 0
    jz      short loc_43938E
    imul    items, bytes
    mov     rdx, [psf+1F60h]
    mov     rsi, rbx
    call    qword ptr [psf+1F50h]
    mov     r15, rax
loc_439377:
    mov     rax, r15
    cqo
    idiv    bytes
loc_43937F:
    add     rsp, 8
    pop     rbx
    pop     psf
    pop     r13
    pop     bytes
    pop     r15
    pop     rbp
    retn
loc_43938E:
    imul    items, bytes
    test    items, items
    jle     short loc_4393FD
    xor     r15d, r15d
    mov     [rsp+38h+var_38], ptr
loc_43939E:
    cmp     items, 40000001h
    mov     ebp, 40000000h
    cmovl   rbp, items
    lea     r13, [ptr+total]
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_4393C0:
    test    items, items
    jle     short loc_43940C
    mov     edi, [psf+900h]; fd
    mov     rsi, r13; buf
    mov     rdx, count; n
    call    _write
    cmp     count, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_4393EC
    call    ___errno_location
    mov     esi, [rax]; error
    cmp     esi, 4
    jz      short loc_4393C0
    jmp     short loc_439404
loc_4393EC:
    test    count, count
    jz      short loc_43940C
    add     total, count
    sub     items, count
    mov     rdi, [rsp+38h+var_38]
    jmp     short loc_43939E
loc_4393FD:
    xor     eax, eax
    jmp     loc_43937F
loc_439404:
    mov     rdi, psf; psf
    call    psf_log_syserr
loc_43940C:
    cmp     dword ptr [psf+1D90h], 0
    jz      loc_439377
    add     [psf+1D98h], total
    jmp     loc_439377
psf_fwrite endp

