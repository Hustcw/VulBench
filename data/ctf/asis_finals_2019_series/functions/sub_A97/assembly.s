sub_A97 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, cs:stderr
    mov     rdx, [rbp+var_8]
    lea     rsi, format; "[ABORT] %s\n"
    mov     rdi, rax; stream
    mov     eax, 0
    call    _fprintf
    mov     edi, 1; status
    call    _exit
sub_A97 endp

