sub_BE0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+var_14]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_14]
    cmp     eax, 100h
    jg      short loc_C26
    mov     eax, [rbp+var_14]
    test    eax, eax
    jns     short loc_C2D
loc_C26:
    mov     eax, 0Ah
    jmp     short loc_C30
loc_C2D:
    mov     eax, [rbp+var_14]
loc_C30:
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_C44
    call    __stack_chk_fail
locret_C44:
    leave
    retn
sub_BE0 endp

