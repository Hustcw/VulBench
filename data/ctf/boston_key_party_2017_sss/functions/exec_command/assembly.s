exec_command proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+command], rdi
    mov     rax, [rbp+command]
    mov     rdi, rax; command
    call    _system
    nop
    leave
    retn
exec_command endp

