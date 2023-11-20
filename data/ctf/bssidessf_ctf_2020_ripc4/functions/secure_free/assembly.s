secure_free proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+ptr], rdi
    mov     edi, 1Eh; name
    call    _sysconf
    mov     [rbp+pg_size], rax
    mov     rax, [rbp+pg_size]
    neg     rax
    mov     rdx, rax
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     [rbp+base], rax
    mov     rcx, [rbp+pg_size]
    mov     rax, [rbp+base]
    mov     edx, 1; prot
    mov     rsi, rcx; len
    mov     rdi, rax; addr
    call    _mprotect
    mov     rax, [rbp+base]
    mov     rax, [rax]
    mov     [rbp+sz], rax
    mov     rax, [rbp+pg_size]
    lea     rdx, [rax+rax]
    mov     rax, [rbp+sz]
    sub     rax, rdx
    mov     rdx, rax; n
    mov     rax, [rbp+ptr]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     rdx, [rbp+sz]
    mov     rax, [rbp+base]
    mov     rsi, rdx; len
    mov     rdi, rax; addr
    call    _munmap
    nop
    leave
    retn
secure_free endp

