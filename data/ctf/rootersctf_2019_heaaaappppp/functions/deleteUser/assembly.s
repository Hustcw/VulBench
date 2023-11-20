deleteUser proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:root
    test    rax, rax
    jnz     short loc_134E
    mov     eax, 0
    call    bye
loc_134E:
    mov     rax, cs:root
    mov     rdi, rax; ptr
    call    _free
    nop
    pop     rbp
    retn
deleteUser endp

