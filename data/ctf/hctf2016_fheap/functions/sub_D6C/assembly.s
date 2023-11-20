sub_D6C proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+ptr], rdi
    mov     rax, [rbp+ptr]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    leave
    retn
sub_D6C endp

