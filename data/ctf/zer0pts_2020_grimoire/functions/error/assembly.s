error proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    mov     [rbp+s], rdi
    mov     [rbp+var_40], rsi
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    cmp     [rbp+s], 0
    jz      short loc_E13
    mov     rax, [rbp+s]
    movzx   eax, byte ptr [rax]
    test    al, al
    jnz     short loc_E28
loc_E13:
    lea     rax, unk_15DE
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_28]
    mov     [rbp+s], rax
    jmp     short loc_E33
loc_E28:
    lea     rax, asc_15DF; ": "
    mov     [rbp+var_28], rax
loc_E33:
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     rbx, rax
    mov     rax, [rbp+var_28]
    mov     rdi, rax; s
    call    _strlen
    add     rbx, rax
    mov     rax, [rbp+var_40]
    mov     rdi, rax; s
    call    _strlen
    add     rax, rbx
    add     rax, 2
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+ptr], rax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _malloc_usable_size
    mov     rdi, rax
    mov     rsi, [rbp+var_40]
    mov     rcx, [rbp+var_28]
    mov     rdx, [rbp+s]
    mov     rax, [rbp+ptr]
    mov     r9, rsi
    mov     r8, rcx
    mov     rcx, rdx
    lea     rdx, aSSS; "%s%s%s\n"
    mov     rsi, rdi; maxlen
    mov     rdi, rax; s
    mov     eax, 0
    call    _snprintf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     rdx, [rbp+ptr]
    mov     rsi, rdx; format
    mov     rdi, rax; stream
    mov     eax, 0
    call    _fprintf
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_EEB
    call    ___stack_chk_fail
loc_EEB:
    add     rsp, 38h
    pop     rbx
    pop     rbp
    retn
error endp

