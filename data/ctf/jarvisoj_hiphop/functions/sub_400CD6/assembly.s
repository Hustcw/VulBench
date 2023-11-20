sub_400CD6 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     qword ptr [rax], 32h ; '2'
    nop
    pop     rbp
    retn
sub_400CD6 endp

