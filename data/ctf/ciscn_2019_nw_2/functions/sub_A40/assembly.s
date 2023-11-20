sub_A40 proc
    sub     rsp, 8
    mov     rdi, cs:stdin; stream
    xor     esi, esi; buf
    call    _setbuf
    mov     rdi, cs:stdout; stream
    xor     esi, esi; buf
    call    _setbuf
    mov     edi, 78h ; 'x'; seconds
    xor     eax, eax
    add     rsp, 8
    jmp     _alarm
sub_A40 endp

