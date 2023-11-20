get_ll proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+buffer]
    mov     esi, 20h ; ' '; size
    mov     rdi, rax; buffer
    call    get_inp
    lea     rax, [rbp+buffer]
    mov     rdi, rax; nptr
    call    atoll
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_400A73
    call    __stack_chk_fail
locret_400A73:
    leave
    retn
get_ll endp

