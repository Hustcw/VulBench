handler proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     edi, 1; status
    call    _exit
handler endp

