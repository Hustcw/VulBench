sub_4009DB proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+nptr], 0
    lea     rax, [rbp+nptr]
    mov     esi, 20h ; ' '
    mov     rdi, rax
    call    sub_400986
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    atoi
    leave
    retn
sub_4009DB endp

