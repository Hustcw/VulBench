beNice proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:__bss_start
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    nop
    pop     rbp
    retn
beNice endp

