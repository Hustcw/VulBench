sub_DA8 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_28], rdi
    mov     [rbp+var_2C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    cmp     [rbp+var_2C], 0
    jnz     short loc_DD3
    mov     eax, 0
    jmp     short loc_E26
loc_DD3:
    mov     [rbp+var_18], 0
    jmp     short loc_E17
loc_DDD:
    mov     eax, [rbp+var_2C]
    cdqe
    sub     rax, [rbp+var_18]
    mov     rcx, rax
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     rdx, rcx; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     [rbp+var_10], rax
    cmp     [rbp+var_10], 0
    jle     short loc_E17
    mov     rax, [rbp+var_10]
    add     [rbp+var_18], rax
loc_E17:
    mov     eax, [rbp+var_2C]
    cdqe
    cmp     rax, [rbp+var_18]
    jg      short loc_DDD
    mov     rax, [rbp+var_18]
loc_E26:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_E3A
    call    __stack_chk_fail
locret_E3A:
    leave
    retn
sub_DA8 endp

