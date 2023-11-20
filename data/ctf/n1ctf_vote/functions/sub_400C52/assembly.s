sub_400C52 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+s], rdi
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     rdx, rax; n
    mov     rax, [rbp+s]
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    _write
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    nop
    leave
    retn
sub_400C52 endp

