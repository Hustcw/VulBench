sub_400806 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    nop
    pop     rbp
    retn
sub_400806 endp

