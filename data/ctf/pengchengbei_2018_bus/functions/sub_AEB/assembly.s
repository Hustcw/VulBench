sub_AEB proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin
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
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 300h; seconds
    call    _alarm
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     cs:qword_202068, 0FFFFFFFFFFFFFFFFh
    nop
    pop     rbp
    retn
sub_AEB endp

