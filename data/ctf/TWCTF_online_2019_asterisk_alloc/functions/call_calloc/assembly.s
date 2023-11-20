call_calloc proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:ptr_c
    test    rax, rax
    jnz     short loc_BE4
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
    mov     rsi, rax; size
    mov     edi, 1; nmemb
    call    _calloc
    mov     cs:ptr_c, rax
    lea     rdi, aData; "Data: "
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+size]
    mov     rdx, rax; nbytes
    mov     rax, cs:ptr_c
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     short loc_BE5
loc_BE4:
    nop
loc_BE5:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_BF9
    call    ___stack_chk_fail
locret_BF9:
    leave
    retn
call_calloc endp

