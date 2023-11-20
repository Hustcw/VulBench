print_menu_line proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+cmd], rdi
    mov     [rbp+desc], rsi
    mov     rdx, [rbp+desc]
    mov     rax, [rbp+cmd]
    mov     rsi, rax
    lea     rdi, format; "%-12s: %s\n"
    mov     eax, 0
    call    _printf
    nop
    leave
    retn
print_menu_line endp

