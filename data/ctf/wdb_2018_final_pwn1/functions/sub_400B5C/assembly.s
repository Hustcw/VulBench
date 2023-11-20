sub_400B5C proc
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
    mov     rax, cs:stderr
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     edi, 1Eh; seconds
    call    _alarm
    nop
    pop     rbp
    retn
sub_400B5C endp

