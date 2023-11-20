sub_40060D proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset command; "cat flag.txt"
    call    _system
    pop     rbp
    retn
sub_40060D endp

