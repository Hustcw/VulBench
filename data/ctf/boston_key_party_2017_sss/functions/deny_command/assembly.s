deny_command proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     rsi, rax
    mov     edi, offset format; "wrong signature for %s - it wasn't sign"...
    mov     eax, 0
    call    _printf
    nop
    leave
    retn
deny_command endp

