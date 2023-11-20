main proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     edx, 0Ah; n
    mov     esi, offset aWarmUp; "-Warm Up-\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 4; n
    mov     esi, offset aWow; "WOW:"
    mov     edi, 1; fd
    call    _write
    lea     rax, [rbp+s]
    mov     edx, offset sub_40060D
    mov     esi, offset format; "%p\n"
    mov     rdi, rax; s
    mov     eax, 0
    call    _sprintf
    lea     rax, [rbp+s]
    mov     edx, 9; n
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    _write
    mov     edx, 1; n
    mov     esi, offset asc_400755; ">"
    mov     edi, 1; fd
    call    _write
    lea     rax, [rbp+var_40]
    mov     rdi, rax
    mov     eax, 0
    call    _gets
    leave
    retn
main endp

