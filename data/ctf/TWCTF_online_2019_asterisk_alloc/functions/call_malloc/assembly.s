call_malloc proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:ptr_m
    test    rax, rax
    jnz     short loc_B36
    lea     rdi, format; "Size: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aLd; "%ld"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    lea     rdi, aData; "Data: "
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    _malloc
    mov     cs:ptr_m, rax
    mov     rax, [rbp+size]
    mov     rdx, rax; nbytes
    mov     rax, cs:ptr_m
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     short loc_B37
loc_B36:
    nop
loc_B37:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_B4B
    call    ___stack_chk_fail
locret_B4B:
    leave
    retn
call_malloc endp

