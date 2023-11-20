sub_11F0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 440h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    mov     ecx, 400h
    mov     edx, ecx; n
    lea     rax, [rbp+s]
    xor     ecx, ecx
    mov     rdi, rax; s
    mov     esi, ecx; c
    mov     [rbp+var_418], ecx
    mov     [rbp+nptr], rax
    call    _memset
    lea     rdi, aData+4; format
    mov     ecx, [rbp+var_418]
    mov     r8b, cl
    mov     [rbp+var_428], rax
    mov     al, r8b
    call    _printf
    mov     [rbp+var_414], 0
    mov     ecx, 3FFh
    mov     edx, ecx
    mov     edi, [rbp+var_418]
    mov     rsi, [rbp+nptr]
    mov     [rbp+var_42C], eax
    call    sub_1050
    mov     rdi, [rbp+nptr]; nptr
    mov     [rbp+var_438], rax
    call    _atoi
    mov     [rbp+var_414], eax
    mov     eax, [rbp+var_414]
    mov     rdx, fs:28h
    mov     rsi, [rbp+var_8]
    cmp     rdx, rsi
    mov     [rbp+var_43C], eax
    jnz     loc_12C1
    mov     eax, [rbp+var_43C]
    add     rsp, 440h
    pop     rbp
    retn
loc_12C1:
    call    ___stack_chk_fail
sub_11F0 endp

