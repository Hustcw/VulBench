secure_malloc proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+sz], rdi
    mov     edi, 1Eh; name
    call    _sysconf
    mov     [rbp+pg_size], rax
    mov     rdx, [rbp+sz]
    mov     rax, [rbp+pg_size]
    add     rax, rdx
    lea     rdx, [rax-1]
    mov     rax, [rbp+pg_size]
    neg     rax
    and     rax, rdx
    mov     [rbp+sz], rax
    mov     rax, [rbp+pg_size]
    add     rax, rax
    add     [rbp+sz], rax
    mov     rax, [rbp+sz]
    mov     r9d, 0; offset
    mov     r8d, 0FFFFFFFFh; fd
    mov     ecx, 2022h; flags
    mov     edx, 7; prot
    mov     rsi, rax; len
    mov     edi, 0; addr
    call    _mmap
    mov     [rbp+ptr], rax
    cmp     [rbp+ptr], 0FFFFFFFFFFFFFFFFh
    jnz     short loc_1CDA
    lea     rdi, aUnableToAlloca; "Unable to allocate memory!\n"
    call    _puts
    call    ___errno_location
    mov     eax, [rax]
    mov     edi, eax; errnum
    call    _strerror
    mov     rsi, rax
    lea     rdi, aErrorS; "Error: %s\n"
    mov     eax, 0
    call    _printf
    mov     edi, 1; status
    call    __exit
loc_1CDA:
    mov     rax, [rbp+ptr]
    mov     rdx, [rbp+sz]
    mov     [rax], rdx
    mov     rcx, [rbp+pg_size]
    mov     rax, [rbp+ptr]
    mov     edx, 0; prot
    mov     rsi, rcx; len
    mov     rdi, rax; addr
    call    _mprotect
    mov     rax, [rbp+sz]
    sub     rax, [rbp+pg_size]
    mov     rdx, rax
    mov     rax, [rbp+ptr]
    lea     rcx, [rdx+rax]
    mov     rax, [rbp+pg_size]
    mov     edx, 0; prot
    mov     rsi, rax; len
    mov     rdi, rcx; addr
    call    _mprotect
    mov     rdx, [rbp+ptr]
    mov     rax, [rbp+pg_size]
    add     rax, rdx
    leave
    retn
secure_malloc endp

