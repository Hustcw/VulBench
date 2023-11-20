hexdump_line proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_28], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+var_28]
    mov     [rbp+var_10], rax
    mov     rax, [rbp+var_28]
    mov     rsi, rax
    lea     rdi, aP; "%p | "
    mov     eax, 0
    call    printf
    mov     [rbp+var_18], 0
    jmp     short loc_17A5
loc_1768:
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, [rbp+var_10]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    movzx   eax, al
    mov     esi, eax
    lea     rdi, a02x; "%02x "
    mov     eax, 0
    call    printf
    cmp     [rbp+var_18], 7
    jnz     short loc_17A1
    mov     edi, 20h ; ' '; c
    call    _putchar
loc_17A1:
    add     [rbp+var_18], 1
loc_17A5:
    cmp     [rbp+var_18], 0Fh
    jle     short loc_1768
    mov     edi, 7Ch ; '|'; c
    call    _putchar
    mov     [rbp+var_14], 0
    jmp     short loc_17F8
loc_17BE:
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, [rbp+var_10]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    mov     [rbp+var_19], al
    cmp     [rbp+var_19], 1Fh
    jle     short loc_17EA
    cmp     [rbp+var_19], 7Fh
    jz      short loc_17EA
    movsx   eax, [rbp+var_19]
    mov     edi, eax; c
    call    _putchar
    jmp     short loc_17F4
loc_17EA:
    mov     edi, 2Eh ; '.'; c
    call    _putchar
loc_17F4:
    add     [rbp+var_14], 1
loc_17F8:
    cmp     [rbp+var_14], 0Fh
    jle     short loc_17BE
    lea     rdi, s; "|"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_181F
    call    ___stack_chk_fail
locret_181F:
    leave
    retn
hexdump_line endp

