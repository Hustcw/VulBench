sub_40094E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+nptr]
    mov     esi, 20h ; ' '
    mov     rdi, rax
    call    sub_4008C9
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_400996
    call    ___stack_chk_fail
locret_400996:
    leave
    retn
sub_40094E endp

