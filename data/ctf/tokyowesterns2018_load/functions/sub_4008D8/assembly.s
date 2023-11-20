sub_4008D8 proc
    push    rbp
    mov     rbp, rsp
    mov     edi, 0; fd
    call    close
    mov     edi, 1; fd
    call    close
    mov     edi, 2; fd
    call    close
    nop
    pop     rbp
    retn
sub_4008D8 endp

