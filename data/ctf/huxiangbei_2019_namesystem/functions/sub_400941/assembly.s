sub_400941 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+nptr]
    mov     esi, 10h
    mov     rdi, rax
    call    sub_400846
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    mov     eax, 0
    call    _atoi
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_40098E
    call    ___stack_chk_fail
locret_40098E:
    leave
    retn
sub_400941 endp

