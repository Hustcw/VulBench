get_long proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+var_48], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+var_48]
    mov     rsi, rax
    lea     rdi, aS; "%s> "
    mov     eax, 0
    call    printf
    mov     rdx, cs:stdin@@GLIBC_2_2_5; stream
    lea     rax, [rbp+s]
    mov     esi, 20h ; ' '; n
    mov     rdi, rax; s
    call    _fgets
    test    rax, rax
    jnz     short loc_144B
    mov     edi, 0; status
    call    _exit
loc_144B:
    lea     rax, [rbp+s]
    lea     rsi, reject; "\n"
    mov     rdi, rax; s
    call    _strcspn
    mov     [rbp+rax+s], 0
    lea     rax, [rbp+s]
    mov     rsi, rax; s2
    lea     rdi, s1; "quit"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1484
    mov     edi, 0; status
    call    _exit
loc_1484:
    lea     rax, [rbp+s]
    mov     rsi, rax; s2
    lea     rdi, aDebug; "debug"
    call    _strcmp
    test    eax, eax
    jnz     short loc_14C9
    mov     rdx, cs:qword_40F8
    mov     rcx, cs:qword_4100
    mov     rax, cs:debug_info
    mov     rsi, rcx
    mov     rdi, rax
    call    debug
    mov     rax, [rbp+var_48]
    mov     rdi, rax
    call    get_long
    jmp     short loc_151F
loc_14C9:
    lea     rax, [rbp+s]
    mov     rsi, rax; s2
    lea     rdi, aLocaldebug; "localdebug"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1513
    mov     rax, rbp
    mov     [rbp+var_40], rax
    mov     rax, rsp
    mov     [rbp+var_38], rax
    mov     rdx, [rbp+var_38]
    mov     rax, [rbp+var_40]
    mov     rsi, rax
    lea     rdi, __func___3802; "get_long"
    call    debug
    mov     rax, [rbp+var_48]
    mov     rdi, rax
    call    get_long
    jmp     short loc_151F
loc_1513:
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atol
loc_151F:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1533
    call    ___stack_chk_fail
locret_1533:
    leave
    retn
get_long endp

