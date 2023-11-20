sub_B30 proc
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
    mov     rax, cs:stderr
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     edi, 3Ch ; '<'; seconds
    call    alarm
    nop
    pop     rbp
    retn
sub_B30 endp

