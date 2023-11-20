start_routine proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0E0h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_DC], 0
    lea     rsi, modes; "r"
    lea     rdi, name; filename
    call    _fopen
    mov     [rbp+stream], rax
    jmp     short loc_400C5C
loc_400C47:
    mov     eax, cs:dword_6022A0
    cmp     [rbp+var_DC], eax
    jz      short loc_400C7E
    add     [rbp+var_DC], 1
loc_400C5C:
    mov     rdx, [rbp+stream]; stream
    lea     rax, [rbp+s]
    mov     esi, 0C8h; n
    mov     rdi, rax; s
    call    _fgets
    test    rax, rax
    jnz     short loc_400C47
    jmp     short loc_400C7F
loc_400C7E:
    nop
loc_400C7F:
    lea     rax, [rbp+s]
    lea     rsi, delim; "\n"
    mov     rdi, rax; s
    call    _strtok
    lea     rax, [rbp+s]
    mov     rsi, rax
    lea     rdi, format; "Data: %s\n"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+stream]
    mov     rdi, rax; stream
    call    _fclose
    mov     cs:dword_6020FC, 0
    nop
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400CDE
    call    ___stack_chk_fail
locret_400CDE:
    leave
    retn
start_routine endp

