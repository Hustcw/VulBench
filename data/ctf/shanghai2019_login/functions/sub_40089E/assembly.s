sub_40089E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+s], rdi
    lea     rdi, aYouPasswordIs; "You password is:"
    call    puts
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    puts
    nop
    leave
    retn
sub_40089E endp

