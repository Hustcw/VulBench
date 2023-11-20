main proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:__bss_start
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     eax, 0
    call    func
    mov     eax, 0
    pop     rbp
    retn
main endp

