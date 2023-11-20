psf_fwrite proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    xor     eax, eax
    test    bytes, bytes
    jz      short loc_439479
    mov     rbx, items
    test    rdx, rdx
    jz      short loc_439479
    mov     r15, psf
    mov     r14, bytes
    mov     r12, ptr
    cmp     dword ptr [rcx+1F30h], 0
    jz      short loc_439488
    imul    items, bytes
    mov     rdx, [psf+1F60h]
    mov     rdi, ptr
    mov     rsi, rbx
    call    qword ptr [psf+1F50h]
loc_439474:
    cqo
    idiv    bytes
loc_439479:
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_439488:
    imul    items, bytes
    test    items, items
    jle     short loc_4394EC
    xor     ecx, ecx
loc_439493:
    cmp     items, 40000001h
    mov     ebp, 40000000h
    cmovl   rbp, items
    mov     [rsp+38h+var_38], total
    lea     r13, [ptr+rcx]
    nop     dword ptr [rax+rax+00h]
loc_4394B0:
    test    items, items
    jle     short loc_4394F8
    mov     edi, [psf+900h]; fd
    mov     rsi, r13; buf
    mov     rdx, count; n
    call    _write
    cmp     count, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_4394DB
    call    ___errno_location
    mov     esi, [rax]; error
    cmp     esi, 4
    jz      short loc_4394B0
    jmp     short loc_4394F0
loc_4394DB:
    test    count, count
    jz      short loc_4394F8
    mov     rcx, [rsp+38h+var_38]
    add     total, count
    sub     items, count
    jmp     short loc_439493
loc_4394EC:
    xor     eax, eax
    jmp     short loc_439479
loc_4394F0:
    mov     rdi, psf; psf
    call    psf_log_syserr
loc_4394F8:
    cmp     dword ptr [psf+1D90h], 0
    mov     rax, [rsp+38h+var_38]
    jz      loc_439474
    add     [psf+1D98h], total
    jmp     loc_439474
psf_fwrite endp

