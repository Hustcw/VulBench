editUsername proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:root
    test    rax, rax
    jnz     short loc_12D4
    mov     eax, 0
    call    bye
loc_12D4:
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
    mov     rax, cs:root
    mov     rax, [rax]
    mov     edx, 1Fh; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    nop
    pop     rbp
    retn
editUsername endp

