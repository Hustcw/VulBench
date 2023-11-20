sub_BC6 proc
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 10h
    mov     r14, rdi
    mov     r12d, esi
    mov     rax, fs:28h
    mov     [rsp+38h+var_30], rax
    xor     eax, eax
    test    esi, esi
    jz      short loc_C33
    mov     rbp, rdi
    mov     ebx, 0
    lea     r13, [rsp+38h+buf]
loc_BF9:
    mov     edx, 1; nbytes
    mov     rsi, r13; buf
    mov     edi, 0; fd
    call    read
    movzx   edx, [rsp+38h+buf]
    cmp     dl, 0Ah
    jz      short loc_C19
    test    dl, dl
    jnz     short loc_C24
loc_C19:
    mov     eax, ebx
    mov     byte ptr [r14+rax], 0
    mov     eax, ebx
    jmp     short loc_C40
loc_C24:
    add     ebx, 1
    mov     [rbp+0], dl
    add     rbp, 1
    cmp     r12d, ebx
    jnz     short loc_BF9
loc_C33:
    lea     eax, [r12-1]
    mov     byte ptr [r14+rax], 0
    mov     eax, r12d
loc_C40:
    mov     rcx, [rsp+38h+var_30]
    xor     rcx, fs:28h
    jz      short loc_C55
    call    __stack_chk_fail
loc_C55:
    add     rsp, 10h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    retn
sub_BC6 endp

