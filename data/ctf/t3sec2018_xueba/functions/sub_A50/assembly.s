sub_A50 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stderr
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    nop
    pop     rbp
    retn
sub_A50 endp

