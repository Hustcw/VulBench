sub_400903 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, 1Eh; seconds
    mov     eax, 0
    call    _alarm
    nop
    pop     rbp
    retn
sub_400903 endp

