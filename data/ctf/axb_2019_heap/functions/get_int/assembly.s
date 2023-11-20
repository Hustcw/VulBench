get_int proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+buf]
    mov     edx, 0Ah; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_C1C
    call    ___stack_chk_fail
locret_C1C:
    leave
    retn
get_int endp

