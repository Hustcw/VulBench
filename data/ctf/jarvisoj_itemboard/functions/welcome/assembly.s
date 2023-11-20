welcome proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "***************************************"...
    call    _puts
    lea     rdi, aItemBoard; "**            Item Board           **"
    call    _puts
    lea     rdi, s; "***************************************"...
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    pop     rbp
    retn
welcome endp

