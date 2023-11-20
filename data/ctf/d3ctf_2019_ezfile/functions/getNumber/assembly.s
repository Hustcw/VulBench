getNumber proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rax, [rbp+buf]
    mov     esi, 10h; size
    mov     rdi, rax; buf
    call    getContent
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    leave
    retn
getNumber endp

