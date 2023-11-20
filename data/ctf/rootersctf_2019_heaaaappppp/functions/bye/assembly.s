bye proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "You must create a user first"
    call    _puts
    mov     edi, 0; status
    call    _exit
bye endp

