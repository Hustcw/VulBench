set_null proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+offset], rdi
    mov     [rbp+var_8], 0
    pop     rbp
    retn
set_null endp

