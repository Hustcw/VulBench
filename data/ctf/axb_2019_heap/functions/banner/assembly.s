banner proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, s; "Welcome to note management system!"
    call    _puts
    lea     rdi, format; "Enter your name: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+format]
    mov     rsi, rax
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    ___isoc99_scanf
    lea     rdi, aHello; "Hello, "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+format]
    mov     rdi, rax; format
    mov     eax, 0
    call    _printf
    lea     rdi, asc_12C8; "\n-------------------------------------"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_B74
    call    ___stack_chk_fail
locret_B74:
    leave
    retn
banner endp

