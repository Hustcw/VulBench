initialize proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:__bss_start
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    nop
    pop     rbp
    retn
initialize endp

