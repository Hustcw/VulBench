bye proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "baii"
    call    _puts
    mov     edi, 0; status
    call    _exit
bye endp

