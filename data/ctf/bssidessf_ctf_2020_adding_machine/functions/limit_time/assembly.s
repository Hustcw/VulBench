limit_time proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_24], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, [rbp+var_24]
    cdqe
    mov     [rbp+rlimits.rlim_cur], rax
    mov     eax, [rbp+var_24]
    cdqe
    mov     [rbp+rlimits.rlim_max], rax
    lea     rax, [rbp+rlimits]
    mov     rsi, rax; rlimits
    mov     edi, 0; resource
    call    _setrlimit
    test    eax, eax
    jz      short loc_12A6
    mov     edi, 1; status
    call    __exit
loc_12A6:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_12BB
    call    ___stack_chk_fail
locret_12BB:
    leave
    retn
limit_time endp

