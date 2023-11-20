get_int proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+nptr], 0
    mov     [rbp+var_18], 0
    lea     rax, [rbp+nptr]
    mov     esi, 0Fh
    mov     rdi, rax
    call    read_n
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    atoi
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_D88
    call    __stack_chk_fail
locret_D88:
    leave
    retn
get_int endp

