sub_401E14 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     [rbp+var_C], esi
    mov     ecx, [rbp+var_C]
    mov     rax, [rbp+var_8]
    mov     edx, 0Ah
    mov     esi, ecx
    mov     rdi, rax
    call    sub_401E85
    leave
    retn
sub_401E14 endp

