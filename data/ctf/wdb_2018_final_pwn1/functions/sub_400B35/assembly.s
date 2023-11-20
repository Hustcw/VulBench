sub_400B35 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     rsi, rax
    lea     rdi, aS; "=== %s ===\n\n"
    mov     eax, 0
    call    _printf
    nop
    leave
    retn
sub_400B35 endp

