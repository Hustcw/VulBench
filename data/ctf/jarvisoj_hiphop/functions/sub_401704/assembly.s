sub_401704 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    add     rax, 20h ; ' '
    mov     esi, 0
    mov     rdi, rax
    call    sub_40114A
    nop
    leave
    retn
sub_401704 endp

