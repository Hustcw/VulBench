secure_strdup proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+s], rdi
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    add     rax, 1
    mov     [rbp+len], rax
    mov     rax, [rbp+len]
    mov     rdi, rax; sz
    call    secure_malloc
    mov     [rbp+buf], rax
    mov     rax, [rbp+len]
    lea     rdx, [rax+1]; n
    mov     rcx, [rbp+s]
    mov     rax, [rbp+buf]
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _memcpy
    mov     rax, [rbp+buf]
    leave
    retn
secure_strdup endp

