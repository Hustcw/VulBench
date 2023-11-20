debug proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+var_18]
    mov     rsi, rax
    lea     rdi, aDebugInS; "Debug in %s\n"
    mov     eax, 0
    call    printf
    lea     rsi, main
    lea     rdi, aMainP; "  main @ %p\n"
    mov     eax, 0
    call    printf
    mov     rax, cs:printf_ptr
    mov     rsi, rax
    lea     rdi, aPrintfP; "  printf @ %p\n"
    mov     eax, 0
    call    printf
    mov     rax, cs:malloc_ptr
    mov     rsi, rax
    lea     rdi, aMallocP; "  malloc @ %p\n"
    mov     eax, 0
    call    printf
    mov     edi, 0Ah; c
    call    _putchar
    mov     rdx, [rbp+var_20]
    mov     rax, [rbp+var_28]
    mov     rsi, rax
    lea     rdi, aRspIsPRbpIsP; "RSP is %p, RBP is %p\n"
    mov     eax, 0
    call    printf
    mov     edi, 0Ah; c
    call    _putchar
    mov     rax, [rbp+var_28]
    mov     [rbp+var_10], rax
    jmp     short loc_1703
loc_16F2:
    mov     rax, [rbp+var_10]
    mov     rdi, rax
    call    hexdump_line
    add     [rbp+var_10], 10h
loc_1703:
    mov     rax, [rbp+var_10]
    cmp     rax, [rbp+var_20]
    jbe     short loc_16F2
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1722
    call    ___stack_chk_fail
locret_1722:
    leave
    retn
debug endp

