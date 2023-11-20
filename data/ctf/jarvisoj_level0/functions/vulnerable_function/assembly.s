vulnerable_function proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    lea     rax, [rbp+buf]
    mov     edx, 200h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    leave
    retn
vulnerable_function endp

