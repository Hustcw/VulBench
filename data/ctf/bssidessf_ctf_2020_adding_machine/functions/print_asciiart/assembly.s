print_asciiart proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 70h
    mov     [rbp+filename], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+filename]
    lea     rsi, modes; "r"
    mov     rdi, rax; filename
    call    _fopen
    mov     [rbp+stream], rax
    cmp     [rbp+stream], 0
    jz      short loc_189C
    jmp     short loc_1874
loc_185C:
    lea     rax, [rbp+s]
    mov     rsi, rax
    lea     rdi, aS_0; "%s"
    mov     eax, 0
    call    printf
loc_1874:
    mov     rdx, [rbp+stream]; stream
    lea     rax, [rbp+s]
    mov     esi, 40h ; '@'; n
    mov     rdi, rax; s
    call    _fgets
    test    rax, rax
    jnz     short loc_185C
    mov     rax, [rbp+stream]
    mov     rdi, rax; stream
    call    _fclose
    jmp     short loc_189D
loc_189C:
    nop
loc_189D:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_18B1
    call    ___stack_chk_fail
locret_18B1:
    leave
    retn
print_asciiart endp

