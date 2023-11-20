sub_14F5 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rax, [rbp+buf]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    leave
    retn
sub_14F5 endp

