sub_B1A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+nptr], 0
    mov     [rbp+var_18], 0
    lea     rax, [rbp+nptr]
    mov     esi, 20h ; ' '
    mov     rdi, rax
    call    sub_ACC
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atol
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_B72
    call    ___stack_chk_fail
locret_B72:
    leave
    retn
sub_B1A endp

