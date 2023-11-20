call_free proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhich; "Which: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_9]
    mov     rsi, rax
    lea     rdi, aC; "%c"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    movzx   eax, [rbp+var_9]
    cmp     al, 6Dh ; 'm'
    jnz     short loc_D01
    mov     rax, cs:ptr_m
    mov     rdi, rax; ptr
    call    _free
    jmp     short loc_D3F
loc_D01:
    movzx   eax, [rbp+var_9]
    cmp     al, 63h ; 'c'
    jnz     short loc_D1A
    mov     rax, cs:ptr_c
    mov     rdi, rax; ptr
    call    _free
    jmp     short loc_D3F
loc_D1A:
    movzx   eax, [rbp+var_9]
    cmp     al, 72h ; 'r'
    jnz     short loc_D33
    mov     rax, cs:ptr_r
    mov     rdi, rax; ptr
    call    _free
    jmp     short loc_D3F
loc_D33:
    lea     rdi, aInvalidChoice; "Invalid choice"
    call    _puts
loc_D3F:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D54
    call    ___stack_chk_fail
locret_D54:
    leave
    retn
call_free endp

