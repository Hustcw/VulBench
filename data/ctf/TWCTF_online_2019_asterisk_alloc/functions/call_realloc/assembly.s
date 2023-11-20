call_realloc proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, format; "Size: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aLd; "%ld"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     rax, [rbp+size]
    mov     rdx, rax
    mov     rax, cs:ptr_r
    mov     rsi, rdx; size
    mov     rdi, rax; ptr
    call    _realloc
    mov     cs:ptr_r, rax
    lea     rdi, aData; "Data: "
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+size]
    mov     rdx, rax; nbytes
    mov     rax, cs:ptr_r
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_CA1
    call    ___stack_chk_fail
locret_CA1:
    leave
    retn
call_realloc endp

