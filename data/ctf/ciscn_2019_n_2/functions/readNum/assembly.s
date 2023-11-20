readNum proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+nptr]
    mov     esi, 10h
    mov     rdi, rax
    call    myRead
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    atoll
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_400B1C
    call    __stack_chk_fail
locret_400B1C:
    leave
    retn
readNum endp

