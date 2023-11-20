sub_1440 proc
    sub     rsp, 18h
    lea     rdi, a1New; "1. new"
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    _puts
    lea     rdi, a2Delete; "2. delete"
    call    _puts
    xor     eax, eax
    lea     rdi, format; "Your choice:"
    call    _printf
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_1495
    xor     eax, eax
    add     rsp, 18h
    jmp     sub_13E0
loc_1495:
    call    ___stack_chk_fail
sub_1440 endp

