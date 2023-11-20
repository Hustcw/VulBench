sendstr proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+s], rsi
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     rdx, rax
    mov     rcx, [rbp+s]
    mov     eax, [rbp+var_4]
    mov     rsi, rcx
    mov     edi, eax
    call    sendlen
    leave
    retn
sendstr endp

