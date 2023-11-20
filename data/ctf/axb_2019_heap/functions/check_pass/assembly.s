check_pass proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    mov     rax, [rax]
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    sub     rdx, rax
    mov     rax, rdx
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 1000h
    jg      short loc_CDC
    mov     eax, 0
    jmp     short loc_CE1
loc_CDC:
    mov     eax, 1
loc_CE1:
    pop     rbp
    retn
check_pass endp

