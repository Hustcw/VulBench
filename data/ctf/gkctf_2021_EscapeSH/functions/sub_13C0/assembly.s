sub_13C0 proc
    sub     rsp, 8
    mov     rax, cs:stdin_ptr
    xor     ecx, ecx; n
    mov     edx, 1; modes
    xor     esi, esi; buf
    mov     rdi, [rax]; stream
    call    setvbuf
    mov     rax, cs:stdout_ptr
    xor     ecx, ecx; n
    mov     edx, 2; modes
    xor     esi, esi; buf
    mov     rdi, [rax]; stream
    call    setvbuf
    mov     rax, cs:stderr_ptr
    xor     ecx, ecx; n
    mov     edx, 1; modes
    xor     esi, esi; buf
    mov     rdi, [rax]; stream
    add     rsp, 8
    jmp     setvbuf
sub_13C0 endp

