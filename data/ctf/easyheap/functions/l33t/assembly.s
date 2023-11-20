l33t proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset command; "cat /home/pwn/flag"
    call    _system
    nop
    pop     rbp
    retn
l33t endp

