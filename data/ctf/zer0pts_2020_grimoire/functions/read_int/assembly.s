read_int proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+nptr]
    mov     esi, 7
    mov     rdi, rax
    call    readline
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_FD9
    call    ___stack_chk_fail
locret_FD9:
    leave
    retn
read_int endp

