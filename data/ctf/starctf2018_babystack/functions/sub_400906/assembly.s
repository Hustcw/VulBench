sub_400906 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rdx, cs:stdin; stream
    lea     rax, [rbp+s]
    mov     esi, 8; n
    mov     rdi, rax; s
    call    fgets
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    atol
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400955
    call    __stack_chk_fail
locret_400955:
    leave
    retn
sub_400906 endp

