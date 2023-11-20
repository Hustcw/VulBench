sub_4008A9 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     rax, cs:stdout
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    nop
    pop     rbp
    retn
sub_4008A9 endp

