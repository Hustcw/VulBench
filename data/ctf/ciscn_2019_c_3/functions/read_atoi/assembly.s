read_atoi proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 8; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+s]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_E49
    call    ___stack_chk_fail
locret_E49:
    leave
    retn
read_atoi endp

