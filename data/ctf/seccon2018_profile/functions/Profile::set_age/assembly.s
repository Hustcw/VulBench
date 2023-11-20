Profile::set_age proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_8], rdi
    mov     [rbp+var_C], esi
    mov     rax, [rbp+var_8]
    mov     edx, [rbp+var_C]
    mov     [rax+40h], edx
    nop
    pop     rbp
    retn
Profile::set_age endp

