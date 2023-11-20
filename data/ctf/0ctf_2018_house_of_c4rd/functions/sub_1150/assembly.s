sub_1150 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    mov     [rbp+fd], edi
    mov     [rbp+var_18], rsi
    mov     [rbp+var_20], rdx
    mov     [rbp+var_30], 0
loc_1178:
    mov     rax, [rbp+var_30]
    cmp     rax, [rbp+var_20]
    jnb     loc_11B9
    mov     edi, [rbp+fd]; fd
    mov     rax, [rbp+var_18]
    add     rax, [rbp+var_30]
    mov     rcx, [rbp+var_20]
    sub     rcx, [rbp+var_30]
    mov     rsi, rax; buf
    mov     rdx, rcx; n
    call    _write
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_28]
    add     rax, [rbp+var_30]
    mov     [rbp+var_30], rax
    jmp     loc_1178
loc_11B9:
    mov     rax, [rbp+var_30]
    mov     rcx, fs:28h
    mov     rdx, [rbp+var_8]
    cmp     rcx, rdx
    mov     [rbp+var_38], rax
    jnz     loc_11E1
    mov     rax, [rbp+var_38]
    add     rsp, 40h
    pop     rbp
    retn
loc_11E1:
    call    ___stack_chk_fail
sub_1150 endp

