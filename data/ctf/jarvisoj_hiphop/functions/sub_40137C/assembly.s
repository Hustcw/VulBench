sub_40137C proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     byte ptr [rax+0Dh], 0
    mov     rax, [rbp+var_8]
    mov     byte ptr [rax+0Ch], 0
    mov     rax, [rbp+var_8]
    mov     byte ptr [rax+0Eh], 0
    nop
    pop     rbp
    retn
sub_40137C endp

