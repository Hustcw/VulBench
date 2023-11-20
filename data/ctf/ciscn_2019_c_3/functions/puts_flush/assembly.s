puts_flush proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+s], rdi
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _puts
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     rdi, rax; stream
    call    _fflush
    nop
    leave
    retn
puts_flush endp

