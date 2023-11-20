sub_CD3 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 20h ; ' '; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rax, [rbp+s]
    mov     edx, 0Ah; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_D36
    call    __stack_chk_fail
locret_D36:
    leave
    retn
sub_CD3 endp

