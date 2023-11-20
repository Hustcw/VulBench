sub_10A4 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_28], rdi
    mov     [rbp+var_2C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    cmp     [rbp+var_2C], 0
    jnz     short loc_10CF
    mov     eax, 0
    jmp     short loc_1122
loc_10CF:
    mov     [rbp+var_18], 0
    jmp     short loc_1113
loc_10D9:
    mov     eax, [rbp+var_2C]
    cdqe
    sub     rax, [rbp+var_18]
    mov     rcx, rax
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     rdx, rcx; n
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    write
    mov     [rbp+var_10], rax
    cmp     [rbp+var_10], 0
    jle     short loc_1113
    mov     rax, [rbp+var_10]
    add     [rbp+var_18], rax
loc_1113:
    mov     eax, [rbp+var_2C]
    cdqe
    cmp     rax, [rbp+var_18]
    jg      short loc_10D9
    mov     rax, [rbp+var_18]
loc_1122:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1136
    call    __stack_chk_fail
locret_1136:
    leave
    retn
sub_10A4 endp

