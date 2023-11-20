sub_C70 proc
    lea     rdi, a1New; "1. new"
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    puts
    lea     rdi, a2Delete; "2. delete"
    call    puts
    lea     rsi, aYourChoice; "Your choice:"
    xor     eax, eax
    mov     edi, 1
    call    __printf_chk
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_CCA
    xor     eax, eax
    add     rsp, 18h
    jmp     sub_C10
loc_CCA:
    call    __stack_chk_fail
sub_C70 endp

