sub_400C90 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 8; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+s]
    mov     esi, 8
    mov     rdi, rax
    call    sub_400B76
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400CEE
    call    ___stack_chk_fail
locret_400CEE:
    leave
    retn
sub_400C90 endp

