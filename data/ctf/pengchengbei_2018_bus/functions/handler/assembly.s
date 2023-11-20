handler proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    lea     rdi, s; "Bye bye"
    call    _puts
    mov     edi, 0; status
    call    _exit
handler endp

