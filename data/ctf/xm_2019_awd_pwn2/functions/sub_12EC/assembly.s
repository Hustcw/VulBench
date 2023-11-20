sub_12EC proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+nptr], 0
    mov     [rbp+var_18], 0
    mov     [rbp+var_10], 0
    lea     rax, [rbp+nptr]
    mov     esi, 10h
    mov     rdi, rax
    call    sub_1249
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_134B
    call    ___stack_chk_fail
locret_134B:
    leave
    retn
sub_12EC endp

