myRead proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+buf], rdi
    mov     [rbp+var_C], esi
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    nop
    leave
    retn
myRead endp

