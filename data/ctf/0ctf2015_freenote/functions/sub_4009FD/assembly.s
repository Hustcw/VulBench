sub_4009FD proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 3Ch ; '<'; seconds
    call    _alarm
    pop     rbp
    retn
sub_4009FD endp

