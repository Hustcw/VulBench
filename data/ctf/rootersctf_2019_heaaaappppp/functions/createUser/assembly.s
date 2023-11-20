createUser proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     edi, 10h; size
    call    _malloc
    mov     cs:root, rax
    lea     rdi, format; "Enter age of user: "
    mov     eax, 0
    call    _printf
    mov     rax, cs:root
    add     rax, 8
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    lea     rdi, aEnterUsername; "Enter username: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 1Fh; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     rbx, cs:root
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    _strdup
    mov     [rbx], rax
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_12B3
    call    ___stack_chk_fail
loc_12B3:
    add     rsp, 38h
    pop     rbx
    pop     rbp
    retn
createUser endp

